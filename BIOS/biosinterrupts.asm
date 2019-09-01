; biosinterrupts.asm

int_unused:
	ret

int_divByZero:
	ret
	
int_trapFlag:
	brk
	ret

int_nmi:
	ret
	
int_breakpoint:
	ret
	
int_overflow:
	ret
	
int_bounds:
	ret
	
int_invalidOpcode:
	ret
	
int_doubleFault:
	ret
	
int_stackFault:
	ret
	
int_generalProtectionFault:
	ret

int_pageFault:
	ret
	
int_mathFault:
	ret
	
int_keyboard:
	ret
	
ptr[17] biosidt {@int_divByZero,@int_trapFlag,@int_nmi,@int_breakpoint,@int_overflow,@int_bounds,@int_invalidOpcode,@int_unused,@int_doubleFault,@int_unused,@int_unused,@int_unused,@int_stackFault,@int_generalProtectionFault,@int_pageFault,@int_unused,@int_mathFault}

initbiosidt:
	mov al, 0
	mov ecx, biosidt_0
	
	copyidt:
		read ebx, ecx
		call set_idt
		add al, 1
		add ecx, 4
		cmp al, 17
		jl copyidt
		ret
		
		