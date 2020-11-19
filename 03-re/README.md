




## 
- How to grep only chapters $\le 10$?
```bash
[phunc20@homography-x220t 03-re]$ cat chapters.txt
you will find the information in chapter 9
and chapter 12.
Chapter 4 contains a summary at the end.
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]" chapters.txt
you will find the information in chapter 9
and chapter 12.
Chapter 4 contains a summary at the end.
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9][^0-9]" chapters.txt
Chapter 4 contains a summary at the end.
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|\n)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|\r)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|\\n)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|\\r)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9] " chapters.txt
Chapter 4 contains a summary at the end.
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|$)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9]([^0-9]|\$)" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9][$]" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9][\$]" chapters.txt
[phunc20@homography-x220t 03-re]$ grep "[cC]hapter [1-9][\$]*" chapters.txt
you will find the information in chapter 9
and chapter 12.
Chapter 4 contains a summary at the end.
[phunc20@homography-x220t 03-re]$
```


## Scope of `*`
Note
- how `grep` double quotes without putting them inside single quotes is wrong
- *had the scope be the shortest match*, it should have matched **`"Alice is wrong"`** instead
![longest-match.png](longest-match.png)


