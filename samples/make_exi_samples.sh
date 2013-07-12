#!/bin/sh

EXIFICIENT_DIR=/shome/ydoi/.s/exificient-sep2work
WDIR=`/bin/pwd`
SCHEMA_DIR=$WDIR/schema_localized/

BASESCHEMA=$SCHEMA_DIR/00_canonical_example00.xsd
EXTSCHEMA=$SCHEMA_DIR/00_canonical_example01.xsd

cd $EXIFICIENT_DIR
. ./env.sh
cd src/sample
export EXI_STRICT=1
export EXI_USE_OPTION=0

for TARGET in C2S S2C; do
 if [ x`ls $WDIR/$TARGET/|grep '\.exi$'|wc -l` != 'x0' ]; then
  echo "please cleanup $TARGET (remove exi files)"
  exit 1
 fi
 ENC_MODE=normal
 EXI_PERSISTENT_CONTEXT=0 jython loopEncoder.py $BASESCHEMA $WDIR/$TARGET/???-base-*.xml
 [ -d $WDIR/exi-$TARGET-$ENC_MODE/base ] || mkdir -p $WDIR/exi-$TARGET-$ENC_MODE/base
 mv -f $WDIR/$TARGET/???-base-*.exi $WDIR/exi-$TARGET-$ENC_MODE/base/
 EXI_PERSISTENT_CONTEXT=0 jython loopEncoder.py $EXTSCHEMA $WDIR/$TARGET/???-base+muc-*.xml
 [ -d $WDIR/exi-$TARGET-$ENC_MODE/base+muc ] || mkdir -p $WDIR/exi-$TARGET-$ENC_MODE/base+muc
 mv -f $WDIR/$TARGET/???-base+muc-*.exi $WDIR/exi-$TARGET-$ENC_MODE/base+muc/

 ENC_MODE=persistent
 EXI_PERSISTENT_CONTEXT=1 jython loopEncoder.py $BASESCHEMA $WDIR/$TARGET/0??-base-*.xml
# EXI_PERSISTENT_CONTEXT=1 jython loopEncoder.py $BASESCHEMA $WDIR/$TARGET/1??-base-*.xml
 [ -d $WDIR/exi-$TARGET-$ENC_MODE/base ] || mkdir -p $WDIR/exi-$TARGET-$ENC_MODE/base
 mv -f $WDIR/$TARGET/???-base-*.exi $WDIR/exi-$TARGET-$ENC_MODE/base/
 EXI_PERSISTENT_CONTEXT=1 jython loopEncoder.py $EXTSCHEMA $WDIR/$TARGET/0??-base+muc-*.xml
# EXI_PERSISTENT_CONTEXT=1 jython loopEncoder.py $EXTSCHEMA $WDIR/$TARGET/1??-base+muc-*.xml
 [ -d $WDIR/exi-$TARGET-$ENC_MODE/base+muc ] || mkdir -p $WDIR/exi-$TARGET-$ENC_MODE/base+muc
 mv -f $WDIR/$TARGET/???-base+muc-*.exi $WDIR/exi-$TARGET-$ENC_MODE/base+muc/

done
