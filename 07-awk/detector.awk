# This is a comment in awk
/[0-9]+/    {print "This line arabic number(s)."}
/[a-zA-Z]+/ {print "This line contains latin alphabet(s)."}
/^$/        {print "This is a blank line."}
