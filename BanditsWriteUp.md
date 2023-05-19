## Level 0

```shell
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

In this command *ssh* is a method to login into another server very securely .
*-p* means the port at which this server will be running is 2220
*bandit0@ bandit.labs.overthewire.org* means we are logging into this server with username bandit0

## Level 0 to 1

```shell
ls -la
```

*ls* to list all the directories
*-a* flag to include all the files and not ignore starting with **.**
*-l* flag to list in long listing format

```shell
cat readme
```

to read the content written in the file readme
the password I got was: **NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL**
then ```exit``` command-\> to exit from the server

## Level 1 to 2

```shell
ssh bandit1@bandit.labs.overthewire.org -p 2220
```

then entered the password
then I knew that the password in this level is stored in the – named file
so I ran the command ```cat ./-``` to list contents of the file

I got the password **rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi**

Here I used ./ before file name as all flags start with – but here it was not flag , it was file name so to specify that I attached ./ before it that indicates that we trying to access a file named – in current directory

## Level 2 to 3

```shell
ssh bandit2@bandit.labs.overthewire.org -p 2220
```

then entered the password

I knew that the password in this level is stored in the *spaces in this filename* named file

as there was space in the file name of this file so I had to run the command

**cat spaces\ in\ this\ filename** to tell that there is a space after word it is not a different file

the password I got was: **aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG**

## Level 3 to 4

``` shell
ssh bandit3@bandit.labs.overthewire.org -p 2220
```

then entered the password
I knew that password is in a hidden subdierctory named inhere
So, I ran command *cd inhere* to go to directory
When the current directory became inhere I ran command *cat .hidden*
From there I got the password: **2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe**

## Level 4 to 5

```shell
ssh bandit4@bandit.labs.overthewire.org -p 2220
```

then entered the password

I knew that password is in a hidden folder named inhere

So, I ran command ```cd inhere``` to go to directory

When current directory became inhere I ran command ls -la to list all the files in this directory there were so many files in this directory from -file00 to -file 09

So I ran command 
```shell
find . -type f | xargs file**
```

Here in this command
*find* tells that we want to find a particular type of files in the current directory
*-type f* specifies that only the regular files need to be returned excluding directories and links.
| is pipe symbol that tells that the output from previous command has to be sent as a input to next command

*xargs* passes the input as argument to the next command

*file* command is executed to find the type of file and type of contents in it
The I got this as output
************attach image

As human readable file is ./-file07 so I ran command ```cat ./-file07```

From there I got the password : **lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR**

## Level 5 to 6

```shell
ssh bandit5@bandit.labs.overthewire.org -p 2220
```

I changed to directory inhere as current directory using command *cd inhere*
then I knew that password is in a file which is 1033bytes in size and is human readable
so I searched for files with size 1033 bytes using command

```shell
find . -type f -size 1033c -exec ls -lh {} +
```

- *-size* specifies that I want to search file with 1033bytes size and -exec specifies that this command has to be executed for all the files that are found

- *ls -lh* specifies to list all the files found in human readable format and {} acts as a placeholder for the found file name and + specifies that this command has to be executed for all the files found

It printed only 1 result which was a file named . *file2* in subdirectory *maybehere07*

then I executed command 
```shell
cd ./maybehere07
cat .file2
```
from there I got the password: **P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU**

## Level 6 to 7

```shell
ssh bandit6@bandit.labs.overthewire.org -p 2220**
```
then I ran command ```ls -la``` but got no output from there

after that I ran command 
```shell
find / -user bandit7 -type f -group bandit6 -exec ls -la {} +
```

Here I am searching for a file with user bandit7 and group bandit6 then I am executing the command ls -la for the result I got.
from there I got the password: **z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S**

## Level 7 to 8

```shell
ssh bandit7@bandit.labs.overthewire.org -p 2220
```

then I ran command ```ls -la``` but there was a file data.txt that contained the password but a lot of other data.

So to find a line that started with millionth word only I ran a command

```shell
grep -m 1 millionth data.txt
```

as *grep* helps to find a particular pattern or sequence in file
1 means only the first match found will be printed
data.txt is file in which we have to find
on running that I got

********************

So, I got the password: **TESKZC0XvTetK0S9xNwm25STk5iWrBvP**

## Level 8 to 9

```shell
ssh bandit8@bandit.labs.overthewire.org -p 2220
```

then I ran command ```ls -la``` and there was a file data.txt that contained the password but a lot of other data.

So, to find a line that occurred only once I ran a command
```sort data.txt | uniq -u```

as *sort* helps to arrange data in alphabetical order
data.txt is file in which we have to find
and here *uniq* command prints only the one line that occurs once

I got the password: **EN632PlfYiZbn3PhVK3XOGSlNInNE00t**

## Level 9 to 10

I ran the command: 
```shell
strings data.txt | grep -a "="
```

Here strings help to print the strings
Than the strings returned from this are piped into the next command .
Next command is to find all the strings that have = in them

The output was :

**********************************************
The password I got was: **G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s**

## Level 10 to 11

I ran the command ls -la. There was a file data.txt that contained data encoded in base64.
So, I ran command

```cat data.txt | base64 –decode```

to decode the base64 data into string using piping.
The password I got was: **6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM**

## Level 11 to 12

I ran the command *ls -la.* There was a file data.txt that contained data in which every letter was rotated by 13 positions.

So, I ran command

```cat data.txt | tr '[a-z][A-Z]' '[n-za-m][N-ZA-M]'```

this rotates the data of the file back by 13 letters

The first set specified is [a-z], which is a shorthand way of typing [abcdefghijklmnopqrstuvwxyz]. The second is [n-za-m], which turns into [nopqrstuvwxyzabcdefghijklm]. tr reads each character from stdin, and if it appears in the first set, it replaces it with the character in the same position in the second set

The output I got was

The password is **JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv**

## Level 12 to 13

I ran the command *ls -la.* There was a file data.txt that contained data that was compressed multiple times and was containing hexdump initially

```cat data.txt```

It was hexdump data

```mkdir /tmp/rizu```

to make directory rizu in tmp in root directory

```cp data.txt > /tmp/rizu```

to copy data from data.txt to a file in temp/rizu

```xxd -r data.txt \> data```

to convert data from hex dump to normal data

then I ran multiple loops of

```file data```

and then

if gzip compressed file

{ 
```shell
    mv data data.gz
    gzip -d data.gz
```
}

if bzip2 compressed file

{
```shell
    mv data data.bz2
   bzip2 -d data.bz2
```
}

If tar compressed file

{
```shell
mv data data.tar

tar xf data.tar
```
}

At last I got the password : **wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw**

## Level 13 to 14 and Level 14 to 15

```ls -al``` shows there is sshkey.private containing sshkey in it

So I ran command ```ssh -i sshkey.private bandit14@localhost -p 2220```

To login into level 14 using the ssh key

I ran command/ ```etc/bandit\_pass/bandit14 to get the password```

I got password: ```fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq```

I ran command ```nc localhost 30000```

Where *nc* stands for netcat it is used to read and write data between 2 computer networks.

And here it ask for the password to read the data which is the latest password I got.

After submitting the password I got new password as output:

**jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt**

So using this I successfully completed level 14

## Level 15 to 16

```shell
openssl s\_client -connect localhost:30001
```

then I entered the latest password I had got and then another password prompted which was: **JQttfApK4SeyHwDlI9SXGR50qclOAil1**

## Level 16 to 17

**Entered the password**

```shell
nmap 127.0.0.1 -sV -p 31000-32000 localhost
```

*Nmap* is the command used for network exploration and security editing

*127.0.0.1* is the loopback IP address also known as local host It refers to current machine or the local system.

*-sV* is flag to tell the versions of the open ports found during the scan.

*-p 31000-32000* specifies which ports have to be scanned. Here it means that all ports between 31000 to 32000 are being scanned

***********************************

As we can see 31790 is open and it is speaking ssl only so it is the server we have to connect to

```shell
openssl s\_client localhost:31790
```

then I enetered the password of the current level to get the rsa private key from the server.

```shell
chmod 600 /tmp/bandit17.key
nano /tmp/bandit17.key
```
and added -----BEGIN PRIVATE RSA KEY------
in starting of the private key and
added -----END PRIVATE RSA KEY------in end of private key
then run the command

```ssh bandit17@localhost -i /tmp/bandit17.key -p 2220```

## Level 17 to 18

```diff passwords.new passwords.old```

********************************************

**2 passwords mean 1**** st **** line has been replaced by 2 ****nd**  **line in 2**** nd **** folder**

And as the password is in passwords.new
 this means the password is **hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg**

## Level 18 to 19

In the next level the user gets logged out just at the same time he logges into the server because .bashsrc has been modified but there is certain time gap between the user's logging and logging out .

So we can specify a command that gets executed as soon as he logges into the sever

```ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme```

the output was the password stored in readme file: **awhqfNnAbc1naukrpqDYcF95h7HoMTrC**

## Level 19 to 20**

**************************************************************************

```./bandit20-do cat /etc/bandit\_pass/bandit20```

Password: **VxCazJaVykI6W36BkBU0mJTCM8rR95XT**
