

## All commands are applied to a line subsequently
before jumping to the next line.
```bash
[phunc20@homography-x220t 04-sed]$ cat pig_cow_horse.txt
a horse is a horse.
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ cat wrong_pig_cow_horse.sed
s/pig/cow/g
s/cow/horse/g
[phunc20@homography-x220t 04-sed]$ sed -f wrong_pig_cow_horse.sed pig_cow_horse.txt
a horse is a horse.
horses when little seems to be called cattles.
horses are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$
```

A simple switch of the order of the two lines in `wrong_pig_cow_horse.sed` will be a cure.
```bash
[phunc20@homography-x220t 04-sed]$ sed -f correct_pig_cow_horse.sed pig_cow_horse.txt
a horse is a horse.
horses when little seems to be called cattles.
cows are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ cat correct_pig_cow_horse.sed
# We simply change the order of the two lines from wrong_pig_cow_horse.sed
s/cow/horse/g
s/pig/cow/g
[phunc20@homography-x220t 04-sed]$ # Recall that the same can be done w/o a sed script
[phunc20@homography-x220t 04-sed]$ sed 's/cow/horse/g;s/pig/cow/g' pig_cow_horse.txt
a horse is a horse.
horses when little seems to be called cattles.
cows are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ # " and ' work the same
[phunc20@homography-x220t 04-sed]$ sed "s/cow/horse/g;s/pig/cow/g" pig_cow_horse.txt
a horse is a horse.
horses when little seems to be called cattles.
cows are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$
```




## Addressing
- `[address]!` i.e. with an **exclamation mark** means **all lines not matching the address**
- `sed` can accept **more than one** input files
```bash
[phunc20@homography-x220t 04-sed]$ cat correct_pig_cow_horse.sed
# We simply change the order of the two lines from wrong_pig_cow_horse.sed
s/cow/horse/g
s/pig/cow/g
[phunc20@homography-x220t 04-sed]$ cat pig_cow_horse.txt
a horse is a horse.
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ sed 'd' pig_cow_horse.txt
[phunc20@homography-x220t 04-sed]$ sed '1d' pig_cow_horse.txt
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ sed '2d' pig_cow_horse.txt
a horse is a horse.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ sed '$d' pig_cow_horse.txt
a horse is a horse.
cows when little seems to be called cattles.
[phunc20@homography-x220t 04-sed]$ sed '1d' pig_cow_horse.txt correct_pig_cow_horse.sed
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
# We simply change the order of the two lines from wrong_pig_cow_horse.sed
s/cow/horse/g
s/pig/cow/g
[phunc20@homography-x220t 04-sed]$ sed '$d' pig_cow_horse.txt correct_pig_cow_horse.sed
a horse is a horse.
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
# We simply change the order of the two lines from wrong_pig_cow_horse.sed
s/cow/horse/g
[phunc20@homography-x220t 04-sed]$ sed '/\(are\|is\)/d' pig_cow_horse.txt correct_pig_cow_horse.sed
cows when little seems to be called cattles.
# We simply change the order of the two lines from wrong_pig_cow_horse.sed
s/cow/horse/g
s/pig/cow/g
[phunc20@homography-x220t 04-sed]$ sed '/\(are\|is\)/!d' pig_cow_horse.txt correct_pig_cow_horse.sed
a horse is a horse.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ sed '2!d' pig_cow_horse.txt
cows when little seems to be called cattles.
[phunc20@homography-x220t 04-sed]$
```

- `[address],[address][command]`, e.g. `/^.TS/,/^.TE/d` specifies a **range** for the sed command
  - This applies to **the shortest match** 
  - line address and pattern address are allowed to be mixed, e.g. `1,/^.TE/d`
  - **Rmk.** `.TS` and `.TE` are probably `groff` or `troff`'s **Tabular Start/End**
```bash
[phunc20@homography-x220t 04-sed]$ sed '/^.TS/,/^.TE/d' tabu.txt
outsider1
  abc
  xyz
.TE
outsider2
outsider3
[phunc20@homography-x220t 04-sed]$ cat tabu.txt
outsider1
.TS
  tabular

  def

.TE
  abc
  xyz
.TE
outsider2
outsider3
[phunc20@homography-x220t 04-sed]$ sed '1,/^outsider2/d' tabu.txt
outsider3
[phunc20@homography-x220t 04-sed]$ sed '2,/xyz/d' tabu.txt
outsider1
.TE
outsider2
outsider3
[phunc20@homography-x220t 04-sed]$ sed '/^.TS/,/^.TE/!d' tabu.txt
.TS
  tabular

  def

.TE
[phunc20@homography-x220t 04-sed]$
```


`vim` inherits about the same addressing functionality:
- `[address]command`, e.g. `/little/s/cow/holy_cow/`
- when no address is specified, in `vim` the command applies to **the current line** (as opposed to `sed`'s **to all lines**)
- except that for global addressing, `vim` uses `%`, e.g. `%s/cow/horse/g`

![before](fig/vim-before.png)
![after](fig/vim-after.png)


## Braces `{}`
Delete blank lines btw `.TS` and `.TE`
```bash
[phunc20@homography-x220t 04-sed]$ sed '/^.TS/,/^.TE/{ /^$/d}' tabu.txt
outsider1
.TS
  tabular
  def
.TE
  abc
  xyz
.TE
outsider2
outsider3
[phunc20@homography-x220t 04-sed]$
```

## Shell script looping thru input args
Actually a simple `for x` will do the trick. That is `for x` can do what `for x in "$@"`
```bash
[phunc20@homography-x220t 04-sed]$ cat testsed
for x
do
  sed '' $x
done
[phunc20@homography-x220t 04-sed]$ chmod +x testsed
[phunc20@homography-x220t 04-sed]$ ./testsed testsed
for x
do
  sed '' $x
done
[phunc20@homography-x220t 04-sed]$ ./testsed testsed pig_cow_horse.txt
for x
do
  sed '' $x
done
a horse is a horse.
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$ cat pig_cow_horse.txt
a horse is a horse.
cows when little seems to be called cattles.
pigs are intelligent, but lives dirty.
[phunc20@homography-x220t 04-sed]$
```



