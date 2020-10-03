

<code>
  $ **ftp ftp.oreilly.com**
  Connected to ftp.oreilly.com.
  220 ProFTPD 1.3.5rc3 Server (ftp.oreilly.com) [172.17.107.51]
  Name (ftp.oreilly.com:phunc20): anonymous
  331 Anonymous login ok, send your complete email address as your password
  Password:
  230-Welcome to the O'Reilly Media, Inc. FTP Archive.
  
   Local date and time: Thu Oct 01 15:46:23 2020
  
   --> Hello 113.23.16.232 <--
   --> There are 5 users out of 100 allowed in your usage class. <--
  
   Check us out on the web at http://www.oreilly.com
  
   --> Please Note!! <--
   If you're using an FTP client in "active" mode and you're behind
   a firewall, you may be unable to list directories. To do so requires
   that the server initiate a data connection back to your client
   on a port that could be blocked by your firewall configuration.
   Attempts to list directories or retrieve files under these conditions
   will result in a message similar to the following:
  
   Can't build data connection: Connection refused.
  
   Depending on your FTP client software, it may be possible to toggle
   from active to passive mode. If it isn't possible, we suggest using
   a recent version of the Firefox browser, which runs in passive mode
   by default. Use this URL:
  
   ftp://ftp.oreilly.com
  
   thank you.
  
   ftpmaster@oreilly.com
  230 Anonymous access granted, restrictions apply
  Remote system type is UNIX.
  Using binary mode to transfer files.
  ftp> ls
  200 PORT command successful
  150 Opening ASCII mode data connection for file list
  lrwxrwxrwx   1 ftp      ftp            12 Jun 21  2002 examples -> pub/examples
  drwxrwxr-x 232 ftp      ftp         57344 Sep 24 09:55 incoming
  drwxrwxr-x   5 ftp      ftp          4096 Jul 25  2010 intl
  drwxrwxr-x  41 ftp      ftp         20480 Sep 30 20:56 outgoing
  drwxrwxr-x  41 ftp      ftp          4096 Sep 16  2013 pub
  drwxr-xr-x   2 ftp      ftp          4096 Jun 21  2002 published
  226 Transfer complete
  ftp> cd /published/oreilly/nutshell/sedawk_2
  250 CWD command successful
  ftp> ls
  200 PORT command successful
  150 Opening ASCII mode data connection for file list
  lrwxrwxrwx   1 ftp      ftp            13 Oct 14  2009 9780937175590 -> 9780937175590
  -rwxr-xr-x   1 ftp      ftp         71525 Aug 12  2009 progs.tar.Z
  226 Transfer complete
  ftp> binary
  200 Type set to I
  ftp> get progs.tar.Z
  200 PORT command successful
  150 Opening BINARY mode data connection for progs.tar.Z (71525 bytes)
  226 Transfer complete
  71525 bytes received in 1.87 seconds (37.3 kbytes/s)
  ftp> quit
  221 Goodbye.





  $ tar tvf progs.tar.Z
  <b>$ tar xvf progs.tar.Z</b>
</code>
