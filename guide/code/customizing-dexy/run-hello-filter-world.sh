set -u
set -e

template_name="cd-hello-world-filter"

dexy gen -t $template_name -d $template_name -meta

cd $template_name

dexy
