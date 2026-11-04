set -euo pipefail

max_diff_chars=12000

if git diff --cached --quiet; then
	echo 'Stage changes before generating a commit message.' >&2
	exit 1
fi

# Prefer a diff without lockfiles/pdf noise; fall back to --stat
# if nothing else is staged.
diff=$(git --no-pager diff --cached --no-color --no-ext-diff -U1 -- . ':(exclude)*.lock' ':(exclude)*.pdf')
if [ -z "$diff" ]; then
	diff=$(git --no-pager diff --cached --no-color --no-ext-diff --stat)
fi

# Cap size to limit the prompt.
if [ "${#diff}" -gt "$max_diff_chars" ]; then
	diff="${diff:0:$max_diff_chars}"$'\n[diff truncated]'
fi

message=$(mktemp)
trap 'rm -f "$message"' EXIT

prompt=$(
	cat <<-'EOF'
		Write a Git commit message for the staged changes.

		- First line: a concise imperative summary under 72 characters describing the specific change.
		- Add a blank line and 1-3 short bullets only if needed.
		- Describe only changes supported by the input; do not invent details.

		Output only the message as plain text, without line numbers, hashes, or commentary.
	EOF
)

printf '%s\n' "$diff" |
	pi -p --no-tools --no-session --provider magpie --model codex/gpt-5.6-luna \
		"$prompt" >"$message"

git commit --edit --file "$message"
