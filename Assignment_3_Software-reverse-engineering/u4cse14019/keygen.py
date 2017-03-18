import md5
import sys
from struct import *

s = sys.argv[1]

def xor_strings(xs, ys):
    return "".join(chr(ord(x) ^ ord(y)) for x, y in zip(xs, ys))

key =  md5.new(s).digest()

key = map(hex,unpack('<QQ',key))

key_left = key[0][2:18]
key_right = key[1][2:18]

binary_a = key_left.decode("hex")
binary_b = key_right.decode("hex")

key = xor_strings(binary_a, binary_b).encode("hex")

r8 = int(key, 16)
key = r8

rax = 0
ecx = 0

array = [0x5daac65f720be8c9,
            0x8c92b50d1c2d1e4f,
            0xa6fd433408510ea4,
            0x0e9296eddd450b03,
            0x84db12124b70fbd9,
            0x091d7b508606ffac,
            0xfd41e1b9fd423b8f,
            0x56bd6aca483c8c74,
            0x037c7f5864b34642,
            0xb488202e8ea9111b,
            0x88af43a6fe478cda,
            0xaa4fc294b8b380b6,
            0x5b1c0d7ed87b9535,
            0x4a9b68be4888bc63,
            0x0b1a4657555b0964,
            0xf0e4afaab7a436c1,
            0x3b031b0100000408
        ]

for i in [0, 16, 32, 48]:
    tmp = r8
    tmp = tmp >> i
    tmp = tmp & 0xf
    rax = rax ^ array[tmp]

rdx = 0xda57e1b4b758031a

rax = rax * rdx

# get last 16 hex values
a = str(hex(rax))[-17:]
rax = int(a[:-1], 16)

rdx = 0xa508de475239764c
rax = rax + rdx

# get last 16 hex values
a = str(hex(rax))[-17:]
rax = int(a[:-1], 16)

rsi = 0xda57e1b4b758031a
rcx = rdx
s = [0] * 18  # define an array
s[0] = rax

# loop 2

for i in range(7):
    rdx = rsi
    rdx = rdx * s[i]

    # get last 16 hex values
    a = str(hex(rdx))[-17:]
    rdx = int(a[:-1], 16)
    rdx = rdx + rcx

    # get last 16 hex values
    a = str(hex(rdx))[-17:]
    rdx = int(a[:-1], 16)
    s[i+1] = rdx

s[8] = key
r13 = -1

# loop 3

string = "%016lx"%r8

for i in range(8):
     r8 = s[i]
     r8 = r8 ^ s[i+8]
     s[i+9] = r8
     string = string + "%016lx"%r8

print string
