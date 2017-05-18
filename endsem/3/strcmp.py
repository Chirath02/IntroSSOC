import sys

if len(sys.argv) == 3:
    len1 = len(sys.argv[1])
    len2 = len(sys.argv[2])
    if len1 == len2:
	print 0
    elif len1 > len2:
	print 1
    else: 
	print -1
    
