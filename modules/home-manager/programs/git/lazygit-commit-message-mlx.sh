set -euo pipefail

mlx_bin="$HOME/.local/bin/mlx-serve"
model="$HOME/.mlx-serve/models/LiquidAI/LFM3-Omni-2B-MLX-8bit"
max_diff_chars=12000

if [ ! -x "$mlx_bin" ]; then
	echo "mlx-serve not found or not executable: $mlx_bin" >&2
	exit 1
fi
if [ ! -d "$model" ]; then
	echo "Model directory not found: $model" >&2
	exit 1
fi

if git diff --cached --quiet; then
	echo 'Stage changes before generating a commit message.' >&2
	exit 1
fi

# Prefer a diff without lockfiles/pdf noise; fall back to --stat
# if nothing else is staged.
diff=$(git --no-pager diff --cached --no-color --no-ext-diff -U1 -- . \
	':(exclude)*.lock' ':(exclude)*.pdf')
if [ -z "$diff" ]; then
	diff=$(git --no-pager diff --cached --no-color --no-ext-diff --stat)
fi

# Cap size to limit the prompt and command-line argument length.
if [ "${#diff}" -gt "$max_diff_chars" ]; then
	diff="${diff:0:$max_diff_chars}"$'\n[diff truncated]'
fi

commit_dir=$(mktemp -d)
trap 'rm -rf "$commit_dir"' EXIT

prompt=$(
	cat <<-EOF
		<staged_diff>
		$diff
		</staged_diff>

		Write a Git commit message for the changes above.

		- First line: a concise imperative summary under 72 characters describing the specific change.
		- Add a blank line and 1-3 short bullets only if needed.
		- Describe only changes supported by the input; do not invent details.

		Output only the message as plain text, without line numbers, hashes, or commentary.
	EOF
)

"$mlx_bin" --model "$model" --max-tokens 256 --no-vision \
	--prompt "$prompt" >"$commit_dir/raw"

# Extract the text between the ========== delimiters, then clean it up:
# drop code fences, strip a "Commit message:" preface, trim trailing
# whitespace and leading blank lines.
awk '/^==========$/ { body = !body; next } body' "$commit_dir/raw" |
	sed -E -e '/^```/d' \
		-e 's/^[Cc]ommit message:[[:space:]]*//' \
		-e 's/[[:space:]]+$//' |
	awk 'NF || started { started = 1; print }' \
		>"$commit_dir/message"

if [ ! -s "$commit_dir/message" ]; then
	echo 'Model returned no usable message. Raw output:' >&2
	cat "$commit_dir/raw" >&2
	exit 1
fi

git commit --edit --file "$commit_dir/message"
