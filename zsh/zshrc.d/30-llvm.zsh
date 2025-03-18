
LLVM_PATH="${HOMEBREW_PREFIX}/opt/llvm/bin"

if [ -z "$(echo "${PATH}" | grep "${LLVM_PATH}")" ]; then
	export PATH="${LLVM_PATH}:$PATH"
fi
