SECTION "PutChar", ROM0[$1cc9]
PutChar:
	ld a, [$c6c6]
	or a
	ret nz
	ld a, [$c6c0]
	sub $2
	jr nc, .asm_1cda ; 0x1cd3 $5
	ld a, $1
	ld [$c600], a
.asm_1cda
	ld a, [$c6c1]
	or a
	jr z, .asm_1ce5 ; 0x1cde $5
	dec a
	ld [$c6c1], a
	ret
.asm_1ce5
	push bc
	ld a, b
	and $f0
	swap a
	push af
	ld hl, $1d3b
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	rst $10
	pop af
	ld hl, $1d4b
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
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [$c6c0]
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	cp $4f
	jp z, Char4F
	cp $4e
	jp z, Char4E
	cp $4d
	jp z, Char4D
	cp $4c
	jp z, Char4C
	cp $4b
	jp z, Char4B
	cp $4a
	jp z, Char4A
	jp WriteChar

SECTION "WriteChar", ROM0[$1f96]
WriteChar: ; 1f96
  	ld a, [hl]
  	ld d, a
  	ld a, $40
  	sub d
  	jp c, $1fc2
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
  	di
  	call $17cb
  	ld [hl], a ; "/°
  	ei
  	pop hl
  	ld a, [hl]
  	ld d, a
  	ld a, [$c6c2]
  	ld h, a
  	ld a, [$c6c3]
  	ld l, a
  	ld a, d
  	di
  	call $17cb
  	ld [hl], a
  	ei
  	inc hl
  	ld a, h
  	ld [$c6c2], a
  	ld a, l
  	ld [$c6c3], a
  	ld a, [$c6c0]
  	inc a
  	ld [$c6c0], a
  	ld a, [$c6c4]
  	ld [$c6c1], a
  	pop hl
  	cp $ff
  	ret nz
  	xor a
  	ld [$c6c1], a
  	jp $1d11
  ; 0x1ff2
