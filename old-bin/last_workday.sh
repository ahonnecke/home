if [ `date +%w` == 1 ] ; then
    date -v-3d +'%Y-%m-%d'
else
    date -v-1d +'%Y-%m-%d'
fi
