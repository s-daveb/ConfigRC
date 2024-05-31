
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
