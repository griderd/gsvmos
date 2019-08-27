; post.asm

; The first thing CPU1 does is perform a speed test
; The speed test requires 5 operations. NOP is fastest.
; I'm not going to use a loop because the jump instructions
; would count towards the operation count.
nop
nop
nop
nop
nop

; Now jump to the main POST code
jmp post

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



%include idt.asm
%include biosinterrupts.asm
%include video.asm
%include memorycheck.asm
%include readdisk.asm

post:
  ; setup video memory
  mov smv, VIDEO
  
  ; setup interrupt table
  call init_idt
  call initbiosidt
  
  
