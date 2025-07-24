# simple-boot
### Requirements
```
sudo apt install nasm qemu
```

### Compilation
```
nasm -f bin bootloader.asm -o build/bootloader.bin
```

### Run
```
qemu-system-x86_64 -fda bootloader.bin
```
