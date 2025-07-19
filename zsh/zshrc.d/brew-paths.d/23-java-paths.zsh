openjdk_root="$HOMEBREW_PREFIX/opt/openjdk"

if [ -d "${openjdk_root}" ]; then
	export JAVA_HOME="${openjdk_root}/libexec/openjdk.jdk/Contents/Home"
	export PATH="${openjdk_root}/bin:$PATH"
fi

# vim : set ft=zsh sw=4 ts=4 noet :
