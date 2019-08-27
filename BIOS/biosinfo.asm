; biosinfo.asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string vers "Grider Monolithic BIOS v1.0\0"
string copyright "Copyright (C) 2019, Grider Software\0"

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

ptr[11] logo {@logo0,@logo1,@logo2,@logo3,@logo4,@logo5,@logo6,@logo7,@logo8,@logo9,@logo10}

drawlogo:
  mov ax, 0
  
  drawlogo_loop:
    cmp ax, 0
    jge
  
  drawlogo_loopbody:
    add ax, 2
    
  
  drawlogo_endloop:
    ret
