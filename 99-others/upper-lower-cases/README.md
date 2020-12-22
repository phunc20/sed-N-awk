
```bash
$ echo 'getFoo_Bar' | sed -e 's/\(get[A-Z][A-Za-z0-9]*_\)\([A-Z]\)/\1\L\2/g'
getFoo_bar
$ echo 'getFoo_Bar' | sed -e 's/\(get[A-Z][A-Za-z0-9]*_\)\([A-Z]\)/\1\U\2/g'
getFoo_Bar
$ echo 'getFoo_Bar' | sed -e 's/\(.*\)/\U\1/g'
GETFOO_BAR
```
