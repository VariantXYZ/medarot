SECTION "Setup Dialogue", ROM0[$1c87]
SetupDialogue: ; $1c87
	ld [$c5c7], a
	xor a
	ld [$c5c8], a
	call $1ab0
	xor a
	ld a, $a
	rst $8 ; ZeroTextOffset
	;ld [$c6c0], a
	ld [$c6c5], a
	ld [$c6c6], a
	ld hl, $1cc6
	ld b, $0
	ld a, [$c765]
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [$c6c1], a
	ld [$c6c4], a
	ld hl, $9c00
	ld bc, $0041
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1cbc ; 0x1cb7 $3
	ld bc, $0021
.asm_1cbc
	add hl, bc
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ret
; 0x1cc6
