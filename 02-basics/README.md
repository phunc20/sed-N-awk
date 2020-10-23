### `ed`
- How to **exit** `ed`?
    - `Ctrl-d`

```bash
[phunc20@tako-x60 02-basics]$ sed 's/MA/Massachusetts' list
sed: -e expression #1, char 18: unterminated `s' command
[phunc20@tako-x60 02-basics]$ sed 's/MA/Massachusetts/' list
John Dagget, 341 King Road, Plymouth Massachusetts
Alice Ford, 22 East Broadway, Richmond VA
Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
Terry Kalkas, 402 Lans Road, Beaver Falls PA
Eric Admas, 20 Post Road, Sudbury Massachusetts
Hubert Sims, 328A Brook Road, Roanoke VA
Amy Wilde, 334 Bayshore Pkwy, Mountain View CA
Sal Carpenter, 73 6th Street, Boston Massachusetts
[phunc20@tako-x60 02-basics]$ sed s/MA/Massac
husetts/ list
John Dagget, 341 King Road, Plymouth Massachusetts
Alice Ford, 22 East Broadway, Richmond VA
Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
Terry Kalkas, 402 Lans Road, Beaver Falls PA
Eric Admas, 20 Post Road, Sudbury Massachusetts
Hubert Sims, 328A Brook Road, Roanoke VA
Amy Wilde, 334 Bayshore Pkwy, Mountain View CA
Sal Carpenter, 73 6th Street, Boston Massachusetts
[phunc20@tako-x60 02-basics]$ sed s/MA/, Massachusetts/ list
sed: -e expression #1, char 6: unterminated `s' command
```

# `sed`
## The mechanism of `sed`'s substitute
### `s/regex/replacement/`
`s` for **s**ubstitute will substitute any line containing the `regex`, replacing them with `replacement` while keep unchanged those lines not containing `regex`
02. `sed` will go thru its input file, **one line after another**
03. `sed` **only** output to `stdout`, i.e. **without modifying** the original file

### Specify multiple instructions in `sed`
01. By **separating** instructions with **`;`**, e.g. `sed 's/ MA/, Massachusetts/; s/ PA/, Pennsylvania/' list`
02. By **repeatedly** using `-e`, e.g. `sed -e 's/ MA/, Massachusetts/' -e 's/ PA/, Pennsylvania/' list`
03. By using the **mutliline entry capability** of Bourne shell, e.g.
  ```bash
  [phunc20@tako-x60 02-basics]$ sed '
  > s/ MA/, Mass/
  > s/ PA/, Penn/
  > s/ CA/, Cali/
  > ' list
  John Dagget, 341 King Road, Plymouth, Mass
  Alice Ford, 22 East Broadway, Richmond VA
  Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
  Terry Kalkas, 402 Lans Road, Beaver Falls, Penn
  Eric Admas, 20 Post Road, Sudbury, Mass
  Hubert Sims, 328A Brook Road, Roanoke VA
  Amy Wilde, 334 Bayshore Pkwy, Mountain View, Cali
  Sal Carpenter, 73 6th Street, Boston, Mass
  ```

### Using a `sed` script instead of typing on stdin
```bash
[phunc20@tako-x60 02-basics]$ cat sedscr
s/ MA/, Massachusetts/
s/ PA/, Pennsylvania/
s/ CA/, California/
s/ VA/, Virginia/
s/ OK/, Oklahoma/
[phunc20@tako-x60 02-basics]$ sed -f sedscr list
John Dagget, 341 King Road, Plymouth, Massachusetts
Alice Ford, 22 East Broadway, Richmond, Virginia
Orville Thomas, 11345 Oak Bridge Road, Tulsa, Oklahoma
Terry Kalkas, 402 Lans Road, Beaver Falls, Pennsylvania
Eric Admas, 20 Post Road, Sudbury, Massachusetts
Hubert Sims, 328A Brook Road, Roanoke, Virginia
Amy Wilde, 334 Bayshore Pkwy, Mountain View, California
Sal Carpenter, 73 6th Street, Boston, Massachusetts
```

### How to not print every line
The <code>-n</code> option.
- try **w/o `-e`**
- try **w/o `/p`**
- what'd happen if `sed -n -e '' list`?
    - will print **nothing**
- what'd happen if `sed 's/MA/Massachusetts/p' list`?
    - The same as `sed 's/MA/Massachusetts/' list`
- `d` instead of `p`, i.e. delete instead of print?
    - No such a thing as `d`
```bash
[phunc20@tako-x60 02-basics]$ sed -n -e 's/MA/Massachusetts/p' list
John Dagget, 341 King Road, Plymouth Massachusetts
Eric Admas, 20 Post Road, Sudbury Massachusetts
Sal Carpenter, 73 6th Street, Boston Massachusetts
[phunc20@tako-x60 02-basics]$ sed -n 's/MA/Massachusetts/p' list
John Dagget, 341 King Road, Plymouth Massachusetts
Eric Admas, 20 Post Road, Sudbury Massachusetts
Sal Carpenter, 73 6th Street, Boston Massachusetts
[phunc20@tako-x60 02-basics]$ sed -n -e 's/MA/Massachusetts/' list
[phunc20@tako-x60 02-basics]$ sed -n -e 's/MA/Massachusetts/d' list
sed: -e expression #1, char 20: unknown option to `s'
[phunc20@tako-x60 02-basics]$ sed -n -e '' list
[phunc20@tako-x60 02-basics]$ sed -e '' list
John Dagget, 341 King Road, Plymouth MA
Alice Ford, 22 East Broadway, Richmond VA
Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
Terry Kalkas, 402 Lans Road, Beaver Falls PA
Eric Admas, 20 Post Road, Sudbury MA
Hubert Sims, 328A Brook Road, Roanoke VA
Amy Wilde, 334 Bayshore Pkwy, Mountain View CA
Sal Carpenter, 73 6th Street, Boston MA
[phunc20@tako-x60 02-basics]$ sed 's/MA/Massachusetts/p' list
John Dagget, 341 King Road, Plymouth Massachusetts
John Dagget, 341 King Road, Plymouth Massachusetts
Alice Ford, 22 East Broadway, Richmond VA
Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
Terry Kalkas, 402 Lans Road, Beaver Falls PA
Eric Admas, 20 Post Road, Sudbury Massachusetts
Eric Admas, 20 Post Road, Sudbury Massachusetts
Hubert Sims, 328A Brook Road, Roanoke VA
Amy Wilde, 334 Bayshore Pkwy, Mountain View CA
Sal Carpenter, 73 6th Street, Boston Massachusetts
Sal Carpenter, 73 6th Street, Boston Massachusetts

```

# `awk`
## Basics
Some spaces are irrelevant.
```bash
[phunc20@tako-x60 02-basics]$ awk '{print $1}' list
John
Alice
Orville
Terry
Eric
Hubert
Amy
Sal
[phunc20@tako-x60 02-basics]$ awk '{ print $1 }' list
John
Alice
Orville
Terry
Eric
Hubert
Amy
Sal
[phunc20@tako-x60 02-basics]$ awk '{ print $1 } ' list
John
Alice
Orville
Terry
Eric
Hubert
Amy
Sal
[phunc20@tako-x60 02-basics]$ awk ' { print $1 } ' list
John
Alice
Orville
Terry
Eric
Hubert
Amy
Sal
```

## Important concepts
- **_record_**: a _record_ is one line of the input file
- **_field_**: specified using `$1, $2, ...`, etc. `$0` refers to the entire record, i.e. the entire line
- **_field separator_**: default to _spaces_ and _tabs_, consecutive _spaces_ or _tabs_ are viewed as **a single separator**

## pattern and procedure
Syntax: **`awk '/pattern/ {procedure}' <file>`**
- only pattern: will print only those lines matching the pattern
    ```bash
    [phunc20@tako-x60 02-basics]$ awk '/MA/' list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    ```
- The above resembles `grep`. Which is faster?
    ```bash
    [phunc20@tako-x60 02-basics]$ time awk '/MA/' list                                           [18/673]
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.010s
    user    0m0.009s
    sys     0m0.001s
    [phunc20@tako-x60 02-basics]$ time awk '/MA/' list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.011s
    user    0m0.005s
    sys     0m0.006s
    [phunc20@tako-x60 02-basics]$ time awk '/MA/' list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.012s
    user    0m0.005s
    sys     0m0.006s
    [phunc20@tako-x60 02-basics]$ time grep "MA" list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.010s
    user    0m0.005s
    sys     0m0.005s
    [phunc20@tako-x60 02-basics]$ time grep "MA" list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.011s
    user    0m0.009s
    sys     0m0.001s
    [phunc20@tako-x60 02-basics]$ time grep "MA" list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    
    real    0m0.009s
    user    0m0.000s
    sys     0m0.008s
    [phunc20@tako-x60 02-basics]$
    ```
- pattern and procedure: Do those procedures only on those lines matching the pattern
    ```bash
    [phunc20@tako-x60 02-basics]$ awk '/MA/ {print $1}' list
    John
    Eric
    Sal
    ```
- use the **`-F`** option to **change the field separator**
    ```bash
    [phunc20@tako-x60 02-basics]$ awk -F, '/MA/ {print $1}' list
    John Dagget
    Eric Admas
    Sal Carpenter
    ```
- The above is similar to `cut`. Again, which is faster?
    ```bash
    [phunc20@tako-x60 02-basics]$ time awk -F, '{print $1}' list
    John Dagget
    Alice Ford
    Orville Thomas
    Terry Kalkas
    Eric Admas
    Hubert Sims
    Amy Wilde
    Sal Carpenter
    
    real    0m0.012s
    user    0m0.007s
    sys     0m0.004s
    [phunc20@tako-x60 02-basics]$ time cut -d, -f1 list
    John Dagget
    Alice Ford
    Orville Thomas
    Terry Kalkas
    Eric Admas
    Hubert Sims
    Amy Wilde
    Sal Carpenter
    
    real    0m0.003s
    user    0m0.000s
    sys     0m0.003s
    [phunc20@tako-x60 02-basics]$ time cut -d, -f1 list > /dev/null
    
    real    0m0.002s
    user    0m0.000s
    sys     0m0.002s
    [phunc20@tako-x60 02-basics]$ time awk -F, '{print $1}' list > /dev/null
    
    real    0m0.012s
    user    0m0.005s
    sys     0m0.006s
    [phunc20@tako-x60 02-basics]$ time cut -d, -f1 list > /dev/null
    
    real    0m0.003s
    user    0m0.001s
    sys     0m0.002s
    [phunc20@tako-x60 02-basics]$ time awk -F, '{print $1}' list > /dev/null
    
    real    0m0.014s
    user    0m0.006s
    sys     0m0.006s
    [phunc20@tako-x60 02-basics]$ awk -F, '/MA/ {print $1}' list
    John Dagget
    Eric Admas
    Sal Carpenter
    [phunc20@tako-x60 02-basics]$ grep MA list
    John Dagget, 341 King Road, Plymouth MA
    Eric Admas, 20 Post Road, Sudbury MA
    Sal Carpenter, 73 6th Street, Boston MA
    [phunc20@tako-x60 02-basics]$ grep MA list | cut -d, -f1
    John Dagget
    Eric Admas
    Sal Carpenter
    [phunc20@tako-x60 02-basics]$ time awk -F, '/MA/ {print $1}' list
    John Dagget
    Eric Admas
    Sal Carpenter
    
    real    0m0.011s
    user    0m0.007s
    sys     0m0.003s
    [phunc20@tako-x60 02-basics]$ time grep MA list | cut -d, -f1 > /dev/null
    
    real    0m0.010s
    user    0m0.007s
    sys     0m0.005s
    [phunc20@tako-x60 02-basics]$ time grep MA list | cut -d, -f1 > /dev/null
    
    real    0m0.013s
    user    0m0.010s
    sys     0m0.003s
    [phunc20@tako-x60 02-basics]$ time awk -F, '/MA/ {print $1}' list > /dev/null
    
    real    0m0.016s
    user    0m0.007s
    sys     0m0.007s
    [phunc20@tako-x60 02-basics]$ time awk -F, '/MA/ {print $1}' list > /dev/null
    
    real    0m0.014s
    user    0m0.003s
    sys     0m0.009s
    ```
- multiple instructions
    ```bash
    [phunc20@tako-x60 02-basics]$ awk -F, '{print $1\nprint $2\nprint $3}' list
    awk: cmd. line:1: {print $1\nprint $2\nprint $3}
    awk: cmd. line:1:          ^ backslash not last character on line
    awk: cmd. line:1: {print $1\nprint $2\nprint $3}
    awk: cmd. line:1:          ^ syntax error
    [phunc20@tako-x60 02-basics]$ awk -F, '{print $1"\n"print $2"\n"print $3}' list
    awk: cmd. line:1: {print $1"\n"print $2"\n"print $3}
    awk: cmd. line:1:              ^ syntax error
    awk: cmd. line:1: {print $1"\n"print $2"\n"print $3}
    awk: cmd. line:1:                          ^ syntax error
    [phunc20@tako-x60 02-basics]$ awk -F, '{print $1 "\n" $2 "\n" $3}' list
    John Dagget
     341 King Road
     Plymouth MA
    Alice Ford
     22 East Broadway
     Richmond VA
    Orville Thomas
     11345 Oak Bridge Road
     Tulsa OK
    Terry Kalkas
     402 Lans Road
     Beaver Falls PA
    Eric Admas
     20 Post Road
     Sudbury MA
    Hubert Sims
     328A Brook Road
     Roanoke VA
    Amy Wilde
     334 Bayshore Pkwy
     Mountain View CA
    Sal Carpenter
     73 6th Street
     Boston MA
    [phunc20@tako-x60 02-basics]$ awk -F, '{print $1 \n $2 \n $3}' list
    awk: cmd. line:1: {print $1 \n $2 \n $3}
    awk: cmd. line:1:           ^ backslash not last character on line
    awk: cmd. line:1: {print $1 \n $2 \n $3}
    awk: cmd. line:1:           ^ syntax error
    [phunc20@tako-x60 02-basics]$ awk -F, '{print "$1 \n $2 \n $3"}' list
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    $1
     $2
     $3
    [phunc20@tako-x60 02-basics]$ sed -f sedscr list | awk -F, '{ print $4 }' | sort | uniq -c
          1  California
          3  Massachusetts
          1  Oklahoma
          1  Pennsylvania
          2  Virginia
    [phunc20@tako-x60 02-basics]$ sed -f sedscr list | awk -F, '{ print $4 }' | sort
     California
     Massachusetts
     Massachusetts
     Massachusetts
     Oklahoma
     Pennsylvania
     Virginia
     Virginia
    [phunc20@tako-x60 02-basics]$ sed -f sedscr list | awk -F, '{ print $4 }' | uniq -c
          1  Massachusetts
          1  Virginia
          1  Oklahoma
          1  Pennsylvania
          1  Massachusetts
          1  Virginia
          1  California
          1  Massachusetts
    ```

## A cooler example: make a report
Which persons are in which states?
```bash
[phunc20@tako-x60 02-basics]$ cat byState
#!/bin/sh
awk -F, '{
        print $4 ", " $0
        }' $* |
sort |
awk -F, '
$1 == LastState {
    print "\t" $2
}
$1 != LastState {
    LastState = $1
    print $1
    print "\t" $2
}'
[phunc20@tako-x60 02-basics]$ sed -f sedscr list | byState
-bash: byState: command not found
[phunc20@tako-x60 02-basics]$ ll byState
-rw-r--r-- 1 phunc20 wheel 188 Oct 23 22:22 byState
[phunc20@tako-x60 02-basics]$ chmod +x byState
[phunc20@tako-x60 02-basics]$ ll byState
-rwxr-xr-x 1 phunc20 wheel 188 Oct 23 22:22 byState
[phunc20@tako-x60 02-basics]$ sed -f sedscr list | byState
-bash: byState: command not found
[phunc20@tako-x60 02-basics]$ sed -f sedscr list | ./byState
 California
         Amy Wilde
 Massachusetts
         Eric Admas
         John Dagget
         Sal Carpenter
 Oklahoma
         Orville Thomas
 Pennsylvania
         Terry Kalkas
 Virginia
         Alice Ford
         Hubert Sims
```
> Note that we don't have to assign to a variable before using it (because awk variables are initialized to the empty string)

## Exercises
01. Use `ed` to create the file `list` of names and addresses
02. Edit a command having the same effect as `sed -f sedscr list | awk -F, '{ print $4 }'`
    - using uniquely `sed`
    - using uniquely `awk`


