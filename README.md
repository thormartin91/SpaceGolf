# SpaceGolf
TDT4240 - ProgArk - 2015

## Workflow
#### Create branch
First off, create a new branch:
```bash
git pull
git checkout -b <branch-name> master
```
> Branch-name should be with the convention iss(issue-id-number)

Next, write your code, stage the files and commit:
```bash
git status
git add <some-file>
git commit -m "commit message"
```
Iterate the above for changes you make.

Before you end a session, push your work to git:
```bash
git push -u origin <branch-name> 
```
#### Close branch

> When you are ready to merge your branch to the master you could issue a Pullrequest on Github to let others review your code.

When you are done with the branch.
First merge the master into your branch to check for mergconflicts:
```bash
git fetch origin
git checkout <branch-name>
git merge master
```
Fix any mergeconflicts, switch to master and merge it with your branch:
```bash
git checkout master
git merge --no-ff <branch-name>
```

Delete your branch and push to master:
```bash
git branch -d <branch-name>
git push origin master
```

ALL DONE!
