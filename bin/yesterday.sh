DAY_OF_WEEK=`date +%w`
if [ $DAY_OF_WEEK == 1 ] ; then
  LOOK_BACK=3
else
  LOOK_BACK=1
fi

date -d "$LOOK_BACK day ago" +'%Y/%m/%d'
