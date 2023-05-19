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
So, to edit the file I ran command
```shell
echo equation.txt>2+3=5
git add equation.txt
git commit -m "resolve conflict"
git verify
```
equation.txt was modified. So added it again and then committed
