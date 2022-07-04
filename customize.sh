ui_print " "

# magisk
if [ -d /sbin/.magisk ]; then
  MAGISKTMP=/sbin/.magisk
else
  MAGISKTMP=`find /dev -mindepth 2 -maxdepth 2 -type d -name .magisk`
fi

# optionals
OPTIONALS=/sdcard/optionals.prop

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
ui_print " MagiskVersion=$MAGISK_VER"
ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
ui_print " "

# sepolicy.rule
if [ "$BOOTMODE" != true ]; then
  mount -o rw -t auto /dev/block/bootdevice/by-name/persist /persist
  mount -o rw -t auto /dev/block/bootdevice/by-name/metadata /metadata
fi
FILE=$MODPATH/sepolicy.sh
DES=$MODPATH/sepolicy.rule
if [ -f $FILE ] && [ "`grep_prop sepolicy.sh $OPTIONALS`" != 1 ]; then
  mv -f $FILE $DES
  sed -i 's/magiskpolicy --live "//g' $DES
  sed -i 's/"//g' $DES
fi

# .aml.sh
mv -f $MODPATH/aml.sh $MODPATH/.aml.sh

# cleaning
ui_print "- Cleaning..."
rm -rf /metadata/magisk/$MODID
rm -rf /mnt/vendor/persist/magisk/$MODID
rm -rf /persist/magisk/$MODID
rm -rf /data/unencrypted/magisk/$MODID
rm -rf /cache/magisk/$MODID
ui_print " "

# primary
if [ "`grep_prop hires.primary $OPTIONALS`" == 1 ]; then
  ui_print "- Enable Hi-Res to low latency playback (primary) output..."
  sed -i 's/#p//g' $MODPATH/.aml.sh
  sed -i 's/buffer/buffer and low latency/g' $MODPATH/module.prop
  ui_print " "
fi

# force 32
if [ "`grep_prop hires.32 $OPTIONALS`" == 1 ]; then
  ui_print "- Forcing audio format PCM to 32 bit instead of 24 bit..."
  sed -i 's/#32//g' $MODPATH/.aml.sh
  sed -i 's/#32//g' $MODPATH/service.sh
  sed -i 's/enforce_mode 24/enforce_mode 32/g' $MODPATH/service.sh
  sed -i 's/24 bit/32 bit/g' $MODPATH/module.prop
  ui_print " "
fi

# force float
if [ "`grep_prop hires.float $OPTIONALS`" == 1 ]; then
  ui_print "- Enable audio format PCM float..."
  sed -i 's/#f//g' $MODPATH/.aml.sh
  sed -i 's/24 bit/24 bit and float/g' $MODPATH/module.prop
  sed -i 's/32 bit/32 bit and float/g' $MODPATH/module.prop
  ui_print " "
fi

# speaker
if [ "`grep_prop speaker.bit $OPTIONALS`" == 16 ]; then
  ui_print "- Forcing audio format PCM 16 bit to internal speaker..."
  sed -i 's/#s16//g' $MODPATH/.aml.sh
  sed -i 's/playback/playback and low resolution to internal speaker/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop hires.32 $OPTIONALS`" == 1 ]\
&& [ "`grep_prop speaker.bit $OPTIONALS`" == 24 ]; then
  ui_print "- Forcing audio format PCM 24 bit to internal speaker..."
  sed -i 's/#s24//g' $MODPATH/.aml.sh
  sed -i 's/playback/playback and 24 bit to internal speaker/g' $MODPATH/module.prop
  ui_print " "
fi

# sampling rates
if [ "`grep_prop sample.rate $OPTIONALS`" == 88 ]; then
  ui_print "- Forcing sample rate to 88200..."
  sed -i 's/|48000/|48000|88200/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 88200/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 96 ]; then
  ui_print "- Forcing sample rate to 96000..."
  sed -i 's/|48000/|48000|88200|96000/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 96000/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 128 ]; then
  ui_print "- Forcing sample rate to 128000..."
  sed -i 's/|48000/|48000|88200|96000|128000/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000,128000/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 128000/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 176 ]; then
  ui_print "- Forcing sample rate to 176400..."
  sed -i 's/|48000/|48000|88200|96000|128000|176400/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000,128000,176400/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 192000/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 192 ]; then
  ui_print "- Forcing sample rate to 192000..."
  sed -i 's/|48000/|48000|88200|96000|128000|176400|192000/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000,128000,176400,192000/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 192000/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 352 ]; then
  ui_print "- Forcing sample rate to 352800..."
  sed -i 's/|48000/|48000|88200|96000|128000|176400|192000|352800/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000,128000,176400,192000,352800/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 352800/g' $MODPATH/module.prop
  ui_print " "
elif [ "`grep_prop sample.rate $OPTIONALS`" == 384 ]; then
  ui_print "- Forcing sample rate to 384000..."
  sed -i 's/|48000/|48000|88200|96000|128000|176400|192000|352800|384000/g' $MODPATH/.aml.sh
  sed -i 's/,48000/,48000,88200,96000,128000,176400,192000,352800,384000/g' $MODPATH/.aml.sh
  sed -i 's/bit/bit with sample rate 354000/g' $MODPATH/module.prop
  ui_print " "
fi

# other
FILE=$MODPATH/service.sh
if [ "`grep_prop other.etc $OPTIONALS`" == 1 ]; then
  ui_print "- Activating other etc files bind mount..."
  sed -i 's/#p//g' $FILE
  ui_print " "
fi

# permission
ui_print "- Setting permission..."
DIR=`find $MODPATH/system/vendor -type d`
for DIRS in $DIR; do
  chown 0.2000 $DIRS
done
ui_print " "



