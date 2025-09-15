if [[ -z "$1" ]];
then
  zellij action new-tab -n $(basename "$PWD") -c "." -l ~/.config/zellij/dev-layout-folder.kdl
elif [[ -f $1 ]];
then
  parent_dir=$(dirname $1)
  export FILE_TO_EDIT=$1
  zellij action new-tab -n $(basename $parent_dir) -c "$parent_dir" -l ~/.config/zellij/dev-layout-file.kdl
else
  zellij action new-tab -n $(basename $1) -c "$1" -l ~/.config/zellij/dev-layout-folder.kdl
fi
