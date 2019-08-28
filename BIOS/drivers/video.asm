; video.asm

%define VIDEO 5120

%define COLS 80
%define ROWS 25

int vidCol 0
int vidRow 0
byte[10] buffer {default}

; Moves the cursor to the location {AL, AH}
setcursor:
  write vidCol, al
  write vidRow, ah
  ret
  
; Prints the provided character to the current cell
; AL - Literal character to print
printc:
  pusha
  
  ; EBX is the write address. We have to calculate it.
  ; Start by multiplying the row by the columns per row
  read ebx, vidRow
  mult ebx, COLS
  
  ; Next add the current column
  read ecx, vidCol
  add ebx, ecx
  
  ; Lastly, add the shared video memory address
  add ebx, svm
  
  ; Write the character to memory
  write ebx, al
  
  add ebx, 1
  
