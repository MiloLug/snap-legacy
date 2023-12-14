#/bin/sh

in=$1
out=$2

./node_modules/.bin/babel $in --out-file $out
./node_modules/.bin/babel --plugins=@babel/plugin-transform-member-expression-literals,@babel/plugin-transform-property-literals $out --out-file $out

