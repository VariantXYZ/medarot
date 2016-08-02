;Character and string related functions, including the ones that put the strings into VRAM

SECTION "PutChar", ROM0[$1cc9]
PutChar: ; $1cc9
	ld a, [$c6c6]
	or a
	ret nz
	ld a, [$c6c0]
	sub $2
	jr nc, .asm_1cda ; 0x1cd3 $5

	ld a, $11 ;2
	rst $8 ;1 ResetBank

	db 0,0
.asm_1cda
	ld a, [$c6c1]
	or a
	jr z, .nowait
	dec a
	ld [$c6c1], a
	ret
.nowait
	push bc
	ld a, b
	and $f0
	swap a
	push af
	ld hl, TextTableBanks
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	rst $10
	pop af
	ld hl, TextTableOffsets
	ld b, $0
	ld c, a
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	ld a, b
	and $f
	ld b, a
	sla c
	rl b
	add hl, bc
	rst $38
	db 0
HandleTextOffset: ;1d10
	ld a, $10
	rst $8 ;CheckBank
	rst $10
	push hl
	ld a, $08
	rst $8 ; GetTextOffset
ProcessText: ;1d18
	add hl, bc
	ld a, [hl]
	cp $4f
	jp z, Char4F
	cp $4e
	jp z, Char4EAdvice
	cp $4d
	jp z, Char4D
	cp $4c
	jp z, Char4C
	cp $4b
	jp z, Char4B
	cp $4a
	jp z, Char4AAdvice
	jp WriteChar

SECTION "WriteChar", ROM0[$1f96]
WriteChar: ; 1f96
	ld a, [hl]
	ld d, a
	ld a, $40
	;sub d
	nop
	jp .notdakuten ; $1fc2;c, $1fc2
	ld hl, $1ff2
	ld c, d
	ld b, $0
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	push hl
	push af
	ld a, [$c6c2]
	ld h, a
	ld a, [$c6c3]
	ld l, a
	ld bc, $ffe0
	add hl, bc
	pop af
	;di
	;call $17cb
	;ld [hl], a ; "/°
	;ei
	db 0, 0, 0, 0, 0, 0 ; waste of cycles
	pop hl
	ld a, [hl]
	ld d, a
.notdakuten
	ld a, [$c6c2]
	ld h, a
	ld a, [$c6c3]
	ld l, a
	ld a, d
	;di ; 1
	;call $17cb ; 3
	;ld [hl], a ; 1

	ld [hSaveA], a ; 2
	xor a ; 1 WriteCharAdvice
	rst $8 ; 1
	ld a, [hSaveA]
	nop
	;ei
	;inc hl
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ld a, [$c6c0]
	inc a
	ld a, $9
	rst $8 ; IncTextOffset
	;ld [$c6c0], a
	ld a, [$c6c4]
	ld [$c6c1], a
	pop hl
	cp $ff
	ret nz
	xor a
	ld [$c6c1], a
	jp HandleTextOffset
  ; 0x1ff2

SECTION "PutString", ROM0[$2fcf]
PutString: ; 2fcf
  ld a, $1 ; 2 ; PutStringAdvice
  rst $8 ; 1
  nop

	;ld a, h ; 1
	;ld [$c640], a ; 3
	ld a, l
	ld [$c641], a
	ld a, b
	ld [$c642], a
	ld a, c
	ld [$c643], a
.char
	ld a, [$c640]
	ld h, a
	ld a, [$c641]
	ld l, a
	ld a, [hl]
	cp $50
	ret z
	ld [$c64e], a
	call $2068
	ld a, [$c64f]
	or a
	jp z, $300d
	ld a, [$c642]
	ld h, a
	ld a, [$c643]
	ld l, a
	ld bc, $ffe0
	add hl, bc
	ld a, [$c64f]
	;di
	;call $17cb
	;ld [hl], a ; "/°
	;ei
	db 0, 0, 0, 0, 0, 0 ; waste of cycles
	ld a, [$c642]
	ld h, a
	ld a, [$c643]
	ld l, a
	ld a, [$c64e]

	;di ; 1
	;call $17cb ; 3
	;ld [hl], a ; 1

	ld [hSaveA], a ; 2
	xor a ; 1
	rst $8 ; 1 ; WriteCharAdvice
	ld a, [hSaveA]
	nop
	;db 0, 0, 0, 0, 0, 0, 0
	;ei
	;inc hl

	ld a, h
	ld [$c642], a
	ld a, l
	ld [$c643], a
	ld a, [$c640]
	ld h, a
	ld a, [$c641]
	ld l, a
	inc hl
	;nop
	ld a, h
	ld [$c640], a
	ld a, l
	ld [$c641], a
	jp .char
; 0x303b
