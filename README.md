# Git-Exercises

## Exercise-1(master)
Just to verify the setup has been completely successsful
```shell
$ git verify
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
```*.exe
*.o
*.jar
libraries/```
Then run these commands to commit all the rest files.
```shell
git add .
git commit -m "ignored files"
git verify```


