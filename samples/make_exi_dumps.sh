#!/bin/zsh

for d in exi-C2S-normal exi-S2C-normal exi-C2S-persistent exi-S2C-persistent; do 
    for s in base base+muc base+muc-dummy; do
	if [ -d $d/$s ]; then
	    firstFile=`ls $d/$s/*.exi|head -1`
	    for f in $d/$s/*.exi; do 
		echo $f
		if [ `basename $f` != $firstFile ]; then
		    dd if=$f of=$f.headless bs=1 skip=1
		    od -t x1 $f.headless > $f:r.dump
		    rm $f.headless
		else
		    od -t x1 $f > $f:r.dump
		fi
	    done
	fi
    done
done

