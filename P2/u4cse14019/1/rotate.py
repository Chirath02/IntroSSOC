import sys

string = sys.argv[1]

shift = sys.argv[2]

shift = int(shift) % 26

s = ''

for i in string:
    v = ord(i) + shift
    if i >= 'A' and i <= 'Z' and v > ord('Z'):
	v = v - 26
    if i >= 'a' and i <= 'z' and v > ord('z'):
	v = v - 26
    s = s + chr(v)

print s

# ord , chr
