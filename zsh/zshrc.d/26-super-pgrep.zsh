# Copyright © 2023 Saul D. Beniquez
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS”
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
unset -f print_super_pgrep_help 2> /dev/null
unset -f super_pgrep 2> /dev/null

function print_super_pgrep_help()
{
	echo "Better pgrep."
	echo ""
	echo "Copyright © 2023 Saul D. Beniquez"
	echo "License: BSD 2-Clause"
	echo
	echo "Usage:"
	echo "super_pgrep 	[-p|--pid-only] [pgrep-parameters] <pattern>"
	echo "spgrep 		[-p|--pid-only] [pgrep-parameters] <pattern>"
	echo
	echo "Options:"
	echo "-p --pid-only 	Return only the PID\'s of the processes, for use "
	echo "             		with awk"
	echo
}

function super_pgrep()
{
	pid_mode=0
	debug_mode=0

	grep_parameters="-iE"

	if [ "x$1" = "x--pid-only" ] || [ "x$1" = "x-p" ]; then
		pid_mode=1
		shift
	fi

	if [[ $# -lt 1 ]]; then
		echo "Invalid parameter set!"
		echo
		print_super_pgrep_help
		return 1
	fi

	while [[ $# -gt 1 ]]; do
		grep_parameters="$1 ${pgrep_parameters}"
		shift
	done
	process_name="$1"

	cmd_to_run="/usr/bin/ps auxww | /usr/bin/grep -v grep | /usr/bin/grep  $grep_parameters '$process_name'"

	if [[ $pid_mode -eq 1 ]]; then
		cmd_to_run="$cmd_to_run | awk '{ print \$2 }'"
	fi

	[[ $debug_mode -eq 1 ]] && echo "Running $cmd_to_run"
	eval "$cmd_to_run"
	return $?
}


alias spgrep="super_pgrep"
