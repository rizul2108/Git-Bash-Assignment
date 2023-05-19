# Git-Exercises

## Exercise-1(master)
Just to verify the setup has been completely successsful
```shell
 git verify
```
## Exercise-2(commit-one-file)
*add* add the file to staging area
then *commit* file with a message "add A.txt"
```shell
git add A.txt
git commit -m "add A.txt"
git verify
```

## Exercise-3(commit-one-file-staged)
*reset* command removes the files from staging area that have not been committed 
```shell
git reset
git add A.txt
git commit -m "add A.txt"
git verify
```

## Exercise-4(ignore-them)
Type this command that creates the file **.gitignore** and opens the editor to enter text in this file.
```shell
nano .gitignore 
```
Enter the folllowing content
```
*.exe
*.o
*.jar
libraries/
```
Then run these commands to commit all the rest files.
```shell
git add .
git commit -m "ignored files"
git verify
```
## Exercise-5(chase-branch)
Initially commit tree looks like this 
```
   HEAD
     |
chase-branch        escaped
     |                 |
     A <----- B <----- C
```
We have to change it to 
```
                    escaped
                       |
     A <----- B <----- C
                       |
                  chase-branch
                       |
                      HEAD
```
using **merge** commamd

 as head is at chase-branch and we have to merge it with escaped branch. So we run command 
 ```shell
 git merge escaped
 git verify
 ```
 
 
## Exercise-6(merge-conflict)
Initially commit tree looks like this 
```
       HEAD
         |
    merge-conflict
         |
A <----- B
 \
  \----- C
         |
another-piece-of-work
```
We have to change it to 
```
                    escaped
                       |
     A <----- B <----- C
                       |
                  chase-branch
                       |
                      HEAD
```
I tried command 
```shell
git merge another-piece-of-work
```
But conflict showed up :
```
Auto-merging equation.txt
CONFLICT (content): Merge conflict in equation.txt
Automatic merge failed; fix conflicts and then commit the result.
```

So,to see the conflict I ran command
```shell
cat equation.txt
```
```
<<<<<<< HEAD
2 + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
the content above ======= represents what is present in file commited in commit in *merge-conflict* branch while below it shows the content of file because of the commit *another-piece-of-work*
So, to edit the file I ran command
```shell
echo equation.txt>2+3=5
git add equation.txt
git commit -m "resolve conflict"
git verify
```
equation.txt was modified. So added it again and then committed

## Exercise-7(save-your-work)
```shell
git stash
```
To keep the changes aside for some time and keep them available to be pulled later.
```shell
nano bug.txt
```
```
This file contains bug
It has to be somewhere.
I feel like I can smell it.
THIS IS A BUG - remove the whole line to fix it.    [this line had to be removed]
How this program could work with such bug?
 In the text editor, deleted the line which was having the bug
``` 
```shell
git add bug.txt
git commit -m "fix bug"
git stash pop
```
and then commited the changes and popped the previous changes that were stored in stash.
Then again run the command to add the instructed line in it:
```shell
nano bug.txt
```
In the text editor added the line "Finally, finished it!" to the end of the file

Then, run the commands
```shell
git add bug.txt
git commit -m "use stash"
git verify
```
## Exercise-8(change-branch-history)
Initially commit tree looks like this 
```
        HEAD
         |
change-branch-history
         |
A <----- B
 \
  \----- C
         |
     hot-bugfix
```
We have to change it to using rebase command
```
                 HEAD
                  |
         change-branch-history
                  |
A <----- C <----- B
         |
     hot-bugfix

```
Just run the command :
```shell
git rebase hot-bugfix
git verify 
```
It just changed the base of the *change-branch-history* commit to *hot-bugfix*.

## Exercise-9(remove-ignored)
Run the command
```shell
git rm --cached ignored.txt 
git commit -m "remove ignored.txt"
git verify
```
To remove the file from staging area only not from local storage if --cached is not added the file will be deleted from local storage also .

## Exercise-10(case-sensitive-filename)
```shell 
git mv File.txt file.txt
git add file.txt
git commit -m "move File to file"
git verify
```
first command is to move the File to file But it is kind of rename only.
And then commited the new file.txt.

## Exercise-11(fix-typo)
```shell
nano file.txt
```
fixed the typo in the file.txt in text editor.
then added the file.txt and also ammended the last commit 
```shell
git add file.txt
git commit --amend -m "Add Hello world"
```
