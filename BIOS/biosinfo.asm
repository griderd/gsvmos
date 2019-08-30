; biosinfo.asm

; PURPOSE: Prints BIOS info onto the screen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string vers "Grider Monolithic BIOS v1.0\0"
string copyright "Copyright (C) 2019, Grider Software\0"
string delSetup "Press DEL to enter setup.\0"

string logo0 " ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ \0"
string logo1 "▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌\0"
string logo2 "▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ \0"
string logo3 "▐░▌          ▐░▌          \0"
string logo4 "▐░▌ ▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ \0"
string logo5 "▐░▌▐░░░░░░░░▌▐░░░░░░░░░░░▌\0"
string logo6 "▐░▌ ▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌\0"
string logo7 "▐░▌       ▐░▌          ▐░▌\0"
string logo8 "▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌\0"
string logo9 "▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌\0"
string logo10 " ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ \0"

; initial position of (0,50) in the format of (ah,al)
ushort logopos 50

ptr[11] logo {@logo0,@logo1,@logo2,@logo3,@logo4,@logo5,@logo6,@logo7,@logo8,@logo9,@logo10}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Prints the BIOS name/version and copyright info onto the screen
; as well as the setup instructions
printvers:
  mov eax, vers_0
  call printline
  mov eax, copyright_0
  call printline

  mov al, 0
  mov ah, 25
  call setcursor
  mov eax, delSetup_0
  call printline
  mov eax, 0
  call setcursor
  ret

; Draws the logo onto the screen
drawlogo:
  mov ax, logo_0
  
  drawlogo_loop:
    cmp ax, logo_10
    jg drawlogo_endloop
  
  drawlogo_loopbody:
    ; AX is currently pointed to the logo. Store it a couple times
    push ax
    push ax
    
    ; Read the logo position to AX and set the cursor position.
    read ax, logopos
    call setcursor
    
    ; Pop the logo pointer back to AX, dereference it, and print the line
    pop ax
    deref ax, ax
    call println
    
    ; Update the position of the next line
    read ax, logopos
    add ah, 1
    write logopos, ax
    
    ; Get the logo pointer again
    pop ax
    add ax, 2
    
    jmp
  
  drawlogo_endloop:
    ; reset the cursor position to (0,0)
    mov ax, 0
    call setcursor
    ret
