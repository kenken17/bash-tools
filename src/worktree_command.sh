branch=${args[branch]}
worktreePath=${args[--path]}
folderName=${PWD##*/}
worktreeDest=~/Worktrees/$folderName

echo "Create new worktree for $branch"

if [[ $worktreePath ]]; then
  worktreeDest=$worktreePath/$folderName
fi

echo "$worktreeDest"
mkdir -p "$worktreeDest"

echo "xx"
