import md5

s = 'chirath'
key =  md5.new(s).digest()

print repr(key)
