; hardwaredetect.asm
; Detects attached hardware and registers it with the BIOS.

; List of device types, one for each possible device
ushort[32] deviceType {default}
; List of device 
ushort[32] deviceID {default}
; List of interrupt channels, one for each possible device
uint[32] interruptChannel {default}
; Last used IDT
uint lastIDT 22

; Hardware detection routine
; Contains the outer detection loop. DOES NOT preserve registers
; EAX - hardware port
detect:
    mov eax, 0
    
    detect_loop:
        cmp eax, 32
        jge detect_endloop

        call hwhs
        cmp edx, 555
        je detect_next
        call storehw

    detect_next:
        add eax, 1
        jmp detect_loop

    detect_endloop:
        ret

; Hardware Handshake routine
; Performs the handshake routine for detected hardware, looping
; EAX - Hardware port
; BL - Control byte
; ECX - Interrupt channel/HSACK data
hwhs:
    read ecx, lastIDT
    jmp hwhs_loop
    
    ; if the handshake failed, increment the interrupt port and try again
    hwhs_prep:
        pop ecx
        add ecx, 1
        cmp ecx, 256
        je hwhs_idtErr

    ; Inner loop
    hwhs_loop:
        ; Push the 
        push ecx
        call serialhandshake
        ; Check if handshake acknowledged (HSACK)
        cmp bl, 4
        ; If error, increment the interrupt port and try again
        jne hwhs_prep
        ; Otherwise, everything was good. You can move on to the next device
        jmp hwhs_end

    hwhs_idtErr:
        mov edx, 555

    hwhs_end:    
        ret

; stores the hardware information
; Device port: EAX
; Device type: CL
; Device ID: CH
; Interrupt port: Top of stack
; Address: EDX
storehw:
    ; Get the address of the device type
    ; Length of 2
    mov edx, 2
    mult edx, eax
    add edx, deviceType_0
    ; Write the device type
    write dx, cl

    ; Get the address of the device ID
    mov edx, 2
    mult edx, eax
    add edx, deviceID_0
    ; Write the device ID
    write dx, ch

    ; Get the address of the interrupt channel
    mov edx, 4
    mult edx, eax
    add edx, interruptChannel_0
    ; Get the interrupt channel
    pop ecx
    write dx, ecx

    ; Clear EDX
    mov edx, 0
    ret