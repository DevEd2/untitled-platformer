#!/bin/sh
PROJECTNAME="gbcompo23"

BuildError () {
    PROJECTNAME=
    echo Build failed, aborting...
    exit 1
}

echo "Converting sprites... (this may take a while)"
cd GFX/Player
for file in *.ec; do
    fname=`basename $file .ec`
	echo $fname
    python3 ../../Tools/extractcels.py -v $fname.ec $fname.png $fname.2bpp $fname.sdef
done
rm _*.png
cd ../..

echo "Converting maps... (This may take a while)"
cd Levels
for file in *.json; do
	python3 ../Tools/convertmap.py -c $file
done
cd ..

echo Assembling...
rgbasm -o $PROJECTNAME.obj -p 255 Main.asm -Wno-numeric-string -Wno-obsolete
if test $? -eq 1; then
    BuildError
fi

echo Linking...
rgblink -p 255 -o $PROJECTNAME.gbc -n $PROJECTNAME.sym $PROJECTNAME.obj
if test $? -eq 1; then
    BuildError
fi

echo Fixing...
rgbfix -v -p 255 $PROJECTNAME.gbc

echo Cleaning up...
rm $PROJECTNAME.obj

echo Build complete.

# unset vars
PROJECTNAME=
echo "** Build finished with no errors **"
