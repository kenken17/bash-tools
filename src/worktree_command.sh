branch=${args[branch]}
worktreePath=${args[--path]}
folderName=${PWD##*/}
worktreeDest=~/Worktrees/$branch/$folderName

baseBranch=$(git branch -l main master --format '%(refname:short)')

# check remote branch exist
if git rev-parse --verify --quiet origin/"$branch" >/dev/null 2>&1; then
  baseBranch=$branch
fi

echo "Create new worktree for $(green "$branch")"

if [[ $worktreePath ]]; then
  worktreeDest=$worktreePath/$branch/$folderName
fi

# fetch all branches
git fetch --all

# create worktree
git worktree add -b "$branch" "$worktreeDest" origin/"$baseBranch"

# make and switch to the destination
mkdir -p "$worktreeDest" && cd "$_" || exit

# set upstream
git push --set-upstream origin "$branch"
