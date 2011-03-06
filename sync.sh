dexy -s -d

# Want to rename index.pdf files to something more useful.
for f in `find cache/docs/*/index.pdf`; do
  v=$(ruby -e "'$f'=~/cache\/docs\/(.+)\/index.pdf/; puts \$1")
  echo "moving $f to $v.pdf"
  mv $f cache/docs/$v/$v.pdf
done

# TODO use --delete tag when able to ensure extraneous files not left on server
rsync -r -v cache/* anaslist@ananelson.com:/home/anaslist/sites/dexy.it/

