### Get the current branch name
$branch = git branch --show-current

### Create directory structure
New-Item -ItemType Directory -Force -Path "cv/$branch"
Copy-Item cv.html $branch/index.html
git add $branch/index.html
git commit -m "Add CV for branch $branch"
git push


### TODO: auto export html from cv.md with mpe somehow

### add the html file to avoid untracked file error
copy cv.html $branch/index.html
git add $branch/index.html


## Commit the changes to main
git checkout main
git add $branch/index.html
git commit -m "Add CV for branch $branch"
git push


### commit the changes
git commit -m "Add submodule for $branch"

### Push the changes
git push

