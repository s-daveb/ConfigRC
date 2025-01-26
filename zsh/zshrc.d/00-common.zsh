export brew_loaded=0
local function load_brew() { #<
	if [[ ${brew_loaded} -eq 1 ]]; then
		return
	fi

	brew_cmd="${HOMEBREW_PREFIX}/bin/brew"

	if [ -x "$(command -v ${brew_cmd})" ]; then
		eval "$(${brew_cmd} shellenv)"
	fi
	export brew_loaded=1
}



local function prepend_path() {
	local path_to_prepend="$1"
	local path="$2"

	if [ -n "${path}" ]; then
		local cleaned_path="${path//:${path_to_prepend}:}"
		cleaned_path="${path//${path_to_prepend}:}"
		cleaned_path="${path//\:${path_to_prepend}}"

		echo "${path_to_prepend}:${cleaned_path}"
		return
	fi

	echo "${path_to_prepend}"
}

local function append_path() {
	local path_to_append="$1"
	local path="$2"

	if [ -n "${path}" ]; then
		local cleaned_path="${path//:${path_to_append}:}"
		cleaned_path="${path//${path_to_append}:}"
		cleaned_path="${path//\:${path_to_append}}"

		echo "${cleaned_path}:${path_to_append}"
		return
	fi

	echo "${path_to_append}"
}

