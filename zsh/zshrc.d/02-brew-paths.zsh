
if [[ ${brew_loaded} -eq 0 ]]; then
	load_brew
fi

extra_paths_dir="${HOME}/.zshrc.d/brew-paths.d"
ls $extra_paths_dir

if [ -d $extra_paths_dir ]; then
	for script in ${extra_paths_dir}/*.zsh; do
		if [[ "$script" =~ ".*/empty.zsh" ]]; then
			continue
		fi
		script_compiled=${script}.zwc

		# If there's no precompiled zwc file,
		# or the compiled file is older than the zsh file,
		if [ ! -f $script_compiled ] ||
		   [ $script_compiled -ot $script ] ; then
			source $script
			zsh -c "zcompile $script" &
			disown
			continue
		fi
		source $script
	done
fi


# vim: ft=zsh ts=4 sts=4 sw=4 noet :
