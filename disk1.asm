; disk1.asm
; This disk contains the boot sector plus the content of the OS, and all user files

; Pad to the size of a 1.44 MB floppy
%pragma pad 1474560
; Offset to the OS position
%pragma offset 10240

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BOOT SECTOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bootsector:
jmp bootstrap
string volumelabel "DISK1\0\0\0"
string fsLabel "VMFS1\0\0\0"
; BOOTSTRAP
string noOS "Operating System Not Found\0"
bootstrap:
    mov eax, noOS_0
    int 18

    hlt
byte[435] empty {default}
;byte[427] empty {default}
ushort sig 47974
