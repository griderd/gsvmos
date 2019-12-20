; bootcheck.asm
; Purpose: Queries the disk controller for operating disk drives

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; One boolean for each disk
int[5] workingDisks {default}
int diskCount 0

string detecting "Detecting disks...\0"
string drive0 "Disk 0 (CMOS)\0"
string drive1 "Disk 1\0"
string drive2 "Disk 2\0"
string drive3 "Disk 3\0"
string drive4 "Disk 4\0"
string noboot "!!! NO BOOT DISK DETECTED !!!\0"

ptr[5] drives {@drive0_0,@drive1_0,@drive2_0,@drive3_0,@drive4_0}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Checks how many disks are working
bootcheck:
    mov eax, detecting_0
    call printline

    ; EAX is flexible
    ; EBX is disk count
    ; ECX is working disk address
    ; EDX is drive string address

    mov eax, 0
    mov ebx, 0
    mov ecx, workingDisks_0
    mov edx, drives_0
    bootcheck_loop:
        cmp ebx, 5
        jge bootcheck_endloop

        ; Handshake the drive. The handshake return is placed in EAX and should be 254.
        mov eax, ebx
        pusha
        call handshake
        cmp eax, 254
        popa
        jne bootcheck_loop_endif

        ; If the handshake is successful, count the drive
        read ax, diskCount
        add ax, 1
        write diskCount, ax

        ; Then mark the drive as working
        mov eax, 1
        write ecx, ax
        
        ; Then print the drive to the screen
        mov eax, edx
        deref ax, ax
        pusha
        call printline
        popa

        bootcheck_loop_endif:
            ; Increment the counter and pointers and loop back
            add ebx, 1
            add ecx, 4
            add edx, 2
            jmp bootcheck_loop

        bootcheck_endloop:
            mov eax, 0
            read ax, diskCount
            cmp ax, 1

            jg bootcheck_endif2

            ; If the disk count is zero
            call newline
            mov eax, noboot_0
            call printline
            hlt

            bootcheck_endif2:
                ret
        