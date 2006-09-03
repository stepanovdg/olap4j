#!/bin/sh
# $Id: //open/mondrian/doc/deployDoc.sh#3 $
# This software is subject to the terms of the Common Public License
# Agreement, available at the following URL:
# http://www.opensource.org/licenses/cpl.html.
# Copyright (C) 2005-2005 Julian Hyde
# All Rights Reserved.
# You must accept the terms of that agreement to use this software.
#
# This is a script to deploy olap4j's website.
# Only the release manager (jhyde) should run this script.

set -e
set -v

generate=true
if [ "$1" == --nogen ]; then
  shift
  generate=
fi

# Prefix is usually "release" or "head"
prefix="$1"
# Directory at sf.net
docdir=
case "$prefix" in
0.6) export docdir=htdocs;;
head) export docdir=head;;
*) echo "Bad prefix '$prefix'"; exit 1;;
esac

cd $(dirname $0)/..
if [ "$generate" ]; then
  ant doczip
else
  echo Skipping generation...
fi

scp dist/doc.tar.gz jhyde@shell.sf.net:

GROUP_DIR=/home/groups/o/ol/olap4j

ssh -T jhyde@shell.sf.net <<EOF
set -e
set -v
rm -f $GROUP_DIR/doc.tar.gz
mv doc.tar.gz $GROUP_DIR
cd $GROUP_DIR
tar xzf doc.tar.gz
rm -rf old
if [ -d $docdir ]; then mv $docdir old; fi
mv doc $docdir
rm -rf old
rm -f doc.tar.gz
./makeLinks
EOF

# End deployDoc.sh