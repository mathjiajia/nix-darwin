# The editor lazygit and Yazi run: edit.sh [+LINE] [--] FILE...
# It opens the files in the Neovim of the same Rex tab, through float_edit in
# floats.lua, or else starts Neovim here as before.
line=
case ${1-} in
+[0-9]*)
	line=${1#+}
	shift
	;;
esac
if [ "${1-}" = -- ]; then shift; fi

if [ -n "${REX_BLOCK-}" ] && [ $# -gt 0 ]; then
	# That Neovim has its own working directory.
	files=()
	for file in "$@"; do
		case $file in
		/*) ;;
		*) file=$PWD/$file ;;
		esac
		files+=("$file")
	done
	rex=${REX_BIN_DIR:+$REX_BIN_DIR/}rex
	# "do" is quoted so ShellCheck doesn't take it for a loop.
	if jq -n '{ files: $ARGS.positional, line: $line }' --argjson line "${line:-null}" --args "${files[@]}" |
		"$rex" "do" float_edit -b "$REX_BLOCK" --args - >/dev/null 2>&1; then
		exit 0
	fi
fi
exec nvim ${line:+"+$line"} -- "$@"
