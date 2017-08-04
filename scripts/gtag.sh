#!/bin/bash

tag=`date '+%y%m%d%H%M'`-`echo $1|sed -e 's/^[ 	]*//'|sed -e 's/[ 	]*$//'`;
echo $tag;
git tag $tag;
git push origin $tag
