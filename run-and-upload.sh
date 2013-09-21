#!/bin/bash -e

while getopts ":r" opt; do
  case $opt in
    r)
      echo "-r was triggered! Running dexy." >&2
      #source site-env/bin/activate
      dexy -r
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

rm output-site/ref/filters/.htaccess
mv output-site/ref/filters/hello{.py.gif,-py.gif}
mv output-site/ref/filters/hello{.py.jpg,-py.jpg}
mv output-site/ref/filters/hello{.py.png,-py.png}

rsync -rvz --partial --progress --delete-after --exclude=.trash output-site/ dexy:~/sites/dexy.it/

linkchecker --file-output html -q --no-warnings http://dexy.it
scp linkchecker-out.html dexy:~/sites/dexy.it/linkchecker-out.html
rm linkchecker-out.html
