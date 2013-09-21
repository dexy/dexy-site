set -u
set -e

template_name="cd-settings-inheritance"

dexy gen -t $template_name -d $template_name -meta

cd $template_name

dexy
