#!/usr/bin/env python3 

from pwn import * 

binary = context.binary = ELF('./keygenme')

io = binary.process() 
gdb.attach(io,"""
break strlen
""")
# break *(0x00101455)

key = b'picoCTF{br1ng_y0ur_0wn_k3y_3b70ca1e}'

missing = b'3b70ca1e'

io.recvuntil(b'key: ')
io.sendline(key)

io.recvall(timeout=99999999999999)