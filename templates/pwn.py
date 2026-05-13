from pwn import *
# for context
context.log_level = 'debug'
# for remote
host = ''
port = 0
io = None
# for local
exe = context.binary = ELF("./chall")
# libc = ELF("./solution/libc.so.6")
############## ROP Gadgets ###############


############## Addr ######################




############## Exploit ###################
def start():
    if args.R:
        return remote(host, port)
    if args.G:
        return gdb.debug([exe.path], gdbscript=gdbscript)
    return process([exe.path])
def exploit(io):

io = start()
exploit(io)
