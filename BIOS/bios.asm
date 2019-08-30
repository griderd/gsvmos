; bios.asm

; The first thing CPU1 does is perform a speed test
; The speed test requires 5 operations. NOP is fastest.
; I'm not going to use a loop because the jump instructions
; would count towards the operation count.
nop
nop
nop
nop
nop

jmp main

%include biosinfo.asm
%include video.asm
;%include /POST/post.asm

main:
    ; INITIALIZATION
    ; setup video memory
    mov smv, VIDEO
  
    ; setup interrupt table
    call init_idt
    call initbiosidt
    
    ; Draw the screen
    call drawlogo
    call printvers