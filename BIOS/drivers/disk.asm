; disk.asm
; Disk driver

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Disk Request Structure
dskreq:
	byte dr_read 0
	uint dr_address 0
	uint dr_length 0
	int dr_error 0
	byte[512] dr_data {default}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Sends a handshake to the provided disk
; Disk port: EAX
handshake:
	mov edx, 254
	write dr_error, edx
	mov edx, 1
	write dr_read, edx
	mov ebx, dskreq
	mov ecx, 525
	out
	in
	read eax, dr_error
	cmp eax, 0
	je handshakeReadData
	ret
	
	handshakeReadData:
		read eax, dr_data_0
		ret

; Requests a 512-byte sector from the provided disk
; Disk port: EAX
; Sector index: EBX
readdisk:
	mov ecx, 1
	write dr_read, ecx
	mult ebx, 512
	write dr_address, ebx
	mov ebx, 512
	write dr_length, ebx
	mov ebx, 0
	write dr_error, ebx
	mov ebx, dskreq
	mov ecx, 525
	out
	in
	
	; TODO: Implement read error
	; cmp error, 0
	; jg readerror

	ret