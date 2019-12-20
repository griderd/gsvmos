; memory.asm

; Copies the content of memory from one location to another
; AX - Destination
; BX - Source
; CX - Length
memcopy:
    ; dx is the counter
    mov edx, 0

    memcopy_loop:
        cmp dx, cx
        jge memcopy_endloop

        push dx
        read dl, bx
        write ax, dl
        pop dx

        add ax, 1
        add bx, 1
        add dx, 1
        jmp memcopy_loop

    memcopy_endloop:
        ret
