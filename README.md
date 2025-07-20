# simple-boot
A minimalist bootloader for educational purpose.

### Requirements
```
sudo apt install nasm qemu
```

### Compilation
```
nasm -f bin boot1.asm -o boot1.bin
```

### Run
```
qemu-system-x86_64 -fda boot1.bin
```
