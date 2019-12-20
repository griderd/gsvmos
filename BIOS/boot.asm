; boot.asm

%define _OS_ 7120

int bootdisk 1

boot:
    read eax, bootdisk
    mov ebx, 0
    call readdisk

    ; Clear the registers
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ; Copy to the OS location
    mov ax, _OS_
    mov bx, dr_data_0
    mov cx, 512
    call memcopy

    jmp _OS_