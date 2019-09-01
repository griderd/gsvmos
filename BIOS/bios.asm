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

%include drivers\video.asm
%include idt.asm
%include biosinterrupts.asm
%include biosinfo.asm
;%include /POST/post.asm

main:
    ; INITIALIZATION
    ; setup video memory
    mov svm, VIDEO
  
    ; setup interrupt table
    call init_idt
    call initbiosidt
    
    ; Draw the screen
    call drawlogo
    call printvers
    hlt