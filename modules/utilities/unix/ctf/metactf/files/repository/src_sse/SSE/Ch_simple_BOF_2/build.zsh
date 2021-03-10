#!/bin/zsh
SALT=`date +%g`
if [[ ARGC -gt 0 ]] then
  BINNAME=`basename $PWD`
  foreach USER ($@)
    mkdir -p obj/$USER
    AA=`echo $USER $SALT $BINNAME | sha512sum | sum | cut -c 1-2 | awk '{printf "%d",$1+10}'`
    cat program.c.template | sed s/AAAAAA/$AA/ >! program.c
    gcc -g -m32 -fno-stack-protector -z execstack -z norelro -fno-pie -no-pie -o obj/$USER/$BINNAME program.c
  end
else
  echo "USAGE: build.zsh <user_email(s)>"
fi
