#!/bin/bash 
#!/usr/bin/env bash
# Shebang
# Debug d’un script bash
# -n  Checks for syntax errors without executing the script (noexec).
# -u  Causes an error to be thrown whenever you try to access a variable that has not been set (nounset).
# -v  Sends all lines to standard error (stderr) as they are read, even comments.
# -x  Turns on execution tracing (xtrace) which displays each command as it is executed.
# -e  Causes the script to exit whenever there is an error (errexit).
# -C Prevents the overwriting of files when using redirection (noclobber).
# -u Causes the shell to throw an error whenever an unset variable is used (nounset).
#    Causes a pipeline to error out if any section has an error (pipefail).

set -o errexit -o pipefail -o noclobber -o nounset
set -evx
source ./file.sh. # source a file
. ./file #source a file another way
enable
compgen -k 
alias ll=“ls -l”
unalias #unset alias
export
unset 
seq 1 9
echo {A..Z}
time
watch
timeout
export A=b or declare -x A=b
export -f function_name
Function name{
//command
#return
#exit
}
declare -l lowercase=“aVV”
declare -u uppercase=“aVV”
declare -r readonly=“aVV”
declare -n integer=“aVV”
declare -a int_index_array
declare -A string_index_array
local a #local variable in side a function
typeset a #local to a function
let a #let allows convenient arithmetic

#file handling
0: in 1: out 2:err
Command > stdout_here 2> stirrer-here < stdin-here
Command > file #out redirect to file
Command 2> file #err redirect to file
Command &> file #input and err redirect to file
Command | command2 # commnd2’s stdin coming from command’s stdout
Command 2>&1 | command2 # commnd2’s gets stdin as stderr stdout from command
Command |& command2 # commnd2’s gets stdin as stderr stdout from command


exec n<file1. #open file with descriptor n for reading
exec n>file2 # open file with descriptor n for writing
exec n<>file2 # open file with descriptor n for reading and writing
exec n>&- or exec n<&-  # close file
lsof -p $$ # $$ is shell’s PID, lsof list open fds
 
#input to command
1.
Command <<END
Comment lien one
Comment line 2
Comment line 3
END

2.
<<COMMENT
Comment lien one
Comment line 2
Comment line 3
COMMENT

2.
:’
Comment lien one
Comment line 2
Comment line 3
‘

#test command
test -x /bin/ls

Filters > head, tail, wc, sed, awk
Script parameters and {}
$1 $2 #variables are 1 and 2
${abc} #variable name is abc
x=abc
abc=yz
echo ${!x}. # prints yz …redirection!
${variable <operator> value}
x=${var:-hotdog}

:- if var is unset/null return value otherwise value of var
:=  if var is unset/null set var with value and return value otherwise value of var
:?  if var is unset/null then it displays error and exits script
:+  if var is unset/null then it returns nothing

String operations
${var:offset} # value of var staring from offset
${var:offset:len} # value of var staring from offset up to Len
${#var} # length of var
${var#pre} # remove matching prefix
${var%post} # remove matching suffix


tr : translate command

Coproceses : runs in background and gives fd for read write
coproc ./mycoproc.sh 

echo banana >& “${COPROC[1]}”
cat <& “${COPROC[0]}”

coproc my { ./mycoproc.sh }.  # coprocessor with name my
echo banana >& “${my[1]}”
cat <& “${my[0]}”

Debugging script

bash prog # no executable permission is required
bash -x prog #execute command after processing can also do set -x pr set +x inside of script
bash -n prog #no execute command do syntax check
set -u # report usage of unset variable

Trap: using signals

trap “just got int exit” INT
trap “u can’t quit” QUIT 

Eval command #http://mywiki.wooledge.org/BashFAQ/048
Getopt: process command line input

opts=`getopt -o a: -l apple — “$@”`

Disabling echo/print in bash
if [[ debug == "$1" ]]; then
  NO_DEBUGING=yes  # any non-null will do
  shift
fi
echo () {
  [[ "$NO_DEBUGING" ]] && builtin echo $@
}
printf () {
  [[ "$NO_DEBUGING" ]] && builtin printf $@
}

for permanent disabling 
Use the nop command
The colon (:) is the nop command in BASH. It doesn't do anything. Use an environment variable and define it as either echo or :.
printf() { :; }
echo { :; }
