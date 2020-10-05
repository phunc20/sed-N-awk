

### Hello, world
- syntax01: <code>awk '{ print "sth" }' \<filename\></code>
    - This will print as many times <b><code>"sth"</code></b> as <b>the number of lines</b> in <code>filename</code>
    - The <b>space</b> next to <code>{</code> and <code>}</code> are <b>not</b> mandatory.
- syntax02: <code>awk '{ print }' \<filename\></code>
    - This will print the content of <code>\<filename\></code>
- syntax03: <code>awk 'BEGIN { print "sth" }' [\<filename\>]</code>
    - The <code><b>BEGIN</b></code> tells <code>awk</code> to do the specified work, before <code>awk</code> encounters any line of input
- syntax04: <code>awk 'BEGIN { print "sth" }; { print "sth\_else" }; END { print "sth\_more" }' [\<filename\>]</code>
    - <code><b>Ctrl-D</b></code> is the <code><b>EOF</b></code> (<b>E</b>nd <b>O</b>f <b>F</b>ile) signal when it comes to <b>input from <code>stdin</code></b>.

```bash
[phunc20@denjiro-x220 07-awk]$ cat test00
This line of text is ignored.
So as this one.
This, too.
[phunc20@denjiro-x220 07-awk]$ awk '{print "Hello, world"}' test00
Hello, world
Hello, world
Hello, world
[phunc20@denjiro-x220 07-awk]$ awk '{ print "Hello, world" }' test00
Hello, world
Hello, world
Hello, world
[phunc20@denjiro-x220 07-awk]$
[phunc20@denjiro-x220 07-awk]$ awk '{ print }' test00
This line of text is ignored.
So as this one.
This, too.
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }'
anfangen
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }' test00
anfangen
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; END { print "beenden" }' test00
anfangen
beenden
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; END { print "beenden" }; END' test00
awk: cmd. line:1: END blocks must have an action part
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; END { print "beenden" }; END {print "anything"}' test00
anfangen
beenden
anything
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; END { print "beenden" }; END {print "anything"}'
anfangen


beenden
anything
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; { print "Halo, Welt!" }; END { print "beenden" }; END {print "anything"}'
anfangen

Halo, Welt!

Halo, Welt!

Halo, Welt!

Halo, Welt!

Halo, Welt!
beenden
anything
[phunc20@denjiro-x220 07-awk]$ awk 'BEGIN { print "anfangen" }; { print "Halo, Welt!" }; END { print "beenden" }; END {print "anything"}' test00
anfangen
Halo, Welt!
Halo, Welt!
Halo, Welt!
beenden
anything
[phunc20@denjiro-x220 07-awk]$
```

### Pattern Matching (and Reading Code from Script)
- The <code><b>-f</b></code> option to <code>awk</code> to specify the code in a script

```bash
[phunc20@denjiro-x220 07-awk]$ cat blank
/^$/ { print "This is a blank line." }
[phunc20@denjiro-x220 07-awk]$ cat test01
a
b

d
e
f

h
i
j
k
[phunc20@denjiro-x220 07-awk]$ awk -f blank test01
This is a blank line.
This is a blank line.
[phunc20@denjiro-x220 07-awk]$
[phunc20@denjiro-x220 07-awk]$ awk -f detector.awk
4
This line arabic number(s).
I am 3 years old now.
This line arabic number(s).
This line contains latin alphabet(s).
3-year-old child cann't be that tall.
This line arabic number(s).
This line contains latin alphabet(s).

This is a blank line.
124751098245
This line arabic number(s).
asdfjaijfqi
This line contains latin alphabet(s).
[phunc20@denjiro-x220 07-awk]$ awk -f detector.awk test00
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This line contains latin alphabet(s).
[phunc20@denjiro-x220 07-awk]$ cat test00
This line of text is ignored.
So as this one.
This, too.
[phunc20@denjiro-x220 07-awk]$ awk -f detector.awk test01
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This is a blank line.
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This is a blank line.
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This line contains latin alphabet(s).
This line contains latin alphabet(s).
[phunc20@denjiro-x220 07-awk]$ cat test01
a
b

d
e
f

h
i
j
k
```


### Records and Fields (2020/10/05)



