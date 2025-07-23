# simple-boot
A simple bootloader.

### Requirements
```
sudo apt install nasm qemu
```

### Compilation
```
nasm -f bin boot.asm -o boot.bin
```

### Run
```
qemu-system-x86_64 -fda boot.bin
```
