SECTION "bank0",HOME

SECTION "romheader",HOME[$100]

INCBIN "baserom.gbc", $100, $50

SECTION "start",HOME[$150]

INCBIN "baserom.gbc", $150,$cb7-$150


INCBIN "baserom.gbc", $cc5,$1cc9-$cc5


INCBIN "baserom.gbc", $1ff2,$2d85-$1ff2


;2d8b

INCBIN "baserom.gbc", $2d8b,$2e58-$2d8b

LoadMedarotterData: ;Load Medarotter Names 2e58 to 2eaf
    ld a, $17
    ld [$2000], a
    ld a, [$c753]
    ld hl, $64e6
    ld b, $0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [hl]
    ld b, $0
    ld c, a
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, $14
    ld [$2000], a
    ld hl, $4000
    add hl, bc
    ld de, $9110
    ld bc, $0100
    call $0cb7
    ld a, [$c740]
    inc a
    ld [$c740], a
    xor a
    ld [$c741], a
    ret
;2eb0
INCBIN "baserom.gbc", $2eb0,$2faa-$2eb0
    ld a, $17
    ld [$2000], a
    ld a, [$c753]
    ld hl, $64e6
    ld b, $0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    inc hl
    inc hl
    inc hl
    ld de, $c6a2
    ld b, $9
.asm_2fc8
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_2fc8 ; 0x2fcc $fa
    ret
; 0x2fcf


; 0x303b

INCBIN "baserom.gbc", $303b,$328f-$303b

LoadItemData: ;328f to 32b8, 0x29 bytes
	push af
	ld a,$17
	ld [$2000],a
	pop af
	ld hl,$5ae0
	ld b,$00
	ld c,a
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld de,$C6A2
	ld b,$09
.asm_032b2
	ldi a,hl
	ld [de],a
	inc de
	dec b
	jr nz,.asm_032b2
	ret

LoadMedalData: ;0x32b9 to 0x32de, 0x26 bytes
	push af
	ld a,$17
	ld [$2000],a
	pop af
	ld hl,$5d50
	ld b,$00
	ld c,a
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl, bc
	ld de,$C6A2
	ld b,$07 ;max size of medal name is n+1
.asm_032d8
	ldi a,hl
	ld [de],a
	inc de
	dec b
	jr nz,.asm_032d8
	ret

INCBIN "baserom.gbc",$32df,$34f0-$32df

;TODO: Find out what these unknowns are
unk_0034f0:  ;0:34f0, 0x034f0 seems to load data into RAM for the setup screen to use
    ld [$c64e], a
    ld a, $1c
    ld [$2000], a
    ld a, b
    or a
    jp nz, $352d
    ld hl, $3562
    ld b, $0
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [$c64e]
    ld b, $0
    ld c, a
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    ld de, $c6a2 ;Part names are loaded here
    ld b, $9
.asm_3526
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_3526 ; 0x352a $fa
    ret
; 0x352d
unk_00352d:
    ld hl, $3562
    ld b, $0
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [$c64e]
    ld b, $0
    ld c, a
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    add hl, bc
    ld b, $0
    ld c, $9
    add hl, bc
    ld de, $c6a2
    ld b, $7
.asm_355b
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_355b ; 0x355f $fa
    ret
; 0x3562

INCBIN "baserom.gbc",$3562,$35bb-$3562

unk_0035bb: ;35bb
    push af
    ld a, $17
    ld [$2000], a
    pop af
    ld hl, $6879
    ld b, $0
    ld c, a
    sla c
    rl b
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld b, $9
    ld de, $c64e
.asm_35d5
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_35d5 ; 0x35d9 $fa
    ret
; 0x35dc

LoadMedarotNameData: ;35dc to 35ff, 0x21 bytes
	push hl
	push de
	ld a,$17
	ld [$2000],a
	ld hl,$6c36
	ld b,$00
	ld a,$04
	call $3981
	ld de,$c6a2
	ldi a,hl
	cp a,$50
	jr z,.asm_35fa
	ld [de],a
	inc de
	jp $35f0
.asm_35fa
	ld a,$50
	ld [de],a
	pop de
	pop hl
	ret

INCBIN "baserom.gbc", $3600,$39da-$3600
;0:39da
PrepareDamageForDisplay: ;Writes damage characters to c705
	push hl
	push bc
	push de
	ld a, h
	ld [$c642], a
	ld a, l
	ld [$c643], a
	xor a
	ld [$c650], a
	ld h, b
	ld l, c
	ld bc, $03e8
	call $330e
	ld a, [$c64e]
	or a
	jr z, .asm_3a02 ; 0x39f5 $b
	add $6b
	ld b, a
	call $3a69
	ld a, $1
	ld [$c650], a
.asm_3a02
	ld a, [$c640]
	ld h, a
	ld a, [$c641]
	ld l, a
	ld bc, $0064
	call $330e
	ld a, [$c64e]
	or a
	jr nz, .asm_3a1d ; 0x3a14 $7
	ld a, [$c650]
	or a
	jr z, .asm_3a28 ; 0x3a1a $c
	xor a
.asm_3a1d
	add $6b
	ld b, a
	call $3a69
	ld a, $1
	ld [$c650], a
.asm_3a28
	ld a, [$c640]
	ld h, a
	ld a, [$c641]
	ld l, a
	ld bc, $000a
	call $330e
	ld a, [$c64e]
	or a
	jr nz, .asm_3a43 ; 0x3a3a $7
	ld a, [$c650]
	or a
	jr z, .asm_3a49 ; 0x3a40 $7
	xor a
.asm_3a43
	add $6b
	ld b, a
	call $3a69
.asm_3a49
	ld a, [$c640]
	ld h, a
	ld a, [$c641]
	ld l, a
	ld bc, $0001
	call $330e
	ld a, [$c64e]
	add $6b
	ld b, a
	call $3a69
	ld b, $50
	call $3a69
	pop de
	pop bc
	pop hl
	ret
; 0x3a69

INCBIN "baserom.gbc", $3a69,$4000-$3a69

SECTION "bank1",DATA,BANK[$1]
INCBIN "baserom.gbc", $4000,$4a9f-$4000


; 0x4b1c
INCBIN "baserom.gbc", $4b1c,$8000-$4b1c

SECTION "bank2",DATA,BANK[$2]
INCBIN "baserom.gbc", $8000,$8bdc-$8000

LoadAndDrawItemData: ;8bdc
	ld hl, $aa00
	dec a
	ld b, $0
	ld c, a
	sla c
	rl b
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, $98
	ld [$c644], a
	ld a, $62
	ld [$c645], a
	ld b, $5
.asm_8bf8
	ld a, [hli]
	or a
	ret z
	push hl
	push bc
	call $01e3 ;LoadItemData
	ld hl, $c6a2
	ld a, [$c644]
	ld b, a
	ld a, [$c645]
	ld c, a
	call $0264
	ld a, [$c644]
	ld h, a
	ld a, [$c645]
	ld l, a
	ld bc, $0040
	add hl, bc
	ld a, h
	ld [$c644], a
	ld a, l
	ld [$c645], a
	pop bc
	pop hl
	ld a, [hl]
	and $80
	jp z, $4c70
	ld a, [hl]
	and $7f
	ld [$c64e], a
	push hl
	push bc
	ld d, $0
	ld e, b
	sla e
	rl d
	ld hl, $4c75
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, $77
	di
	call $016e
	ld [hli], a
	ei
	ld a, [$c64e]
	push hl
	call $025b
	pop hl
	ld a, [$c64f]
	and $f0
	swap a
	ld b, $6b
	add b
	di
	call $016e
	ld [hli], a
	ei
	ld a, [$c64f]
	and $f
	ld b, $6b
	add b
	di
	call $016e
	ld [hli], a
	ei
	pop bc
	pop hl
	inc hl
	dec b
	jr nz, .asm_8bf8 ; 0x8c72 $84
	ret
; 0x8c75

INCBIN "baserom.gbc",$8c75,$aefb-$8c75

LoadAndDrawMedalData:
	ld hl, $a640
	ld c, b
	ld b, $0
	ld a, $5
	call $02b8
	ld a, $40
	ld hl, $988a
	call $585a
	ld hl, $0001
	add hl, de
	ld a, [hl]
	call $0282 ;LoadMedalData
	ld hl, $c6a2
	ld bc, $98ac
	call $0264
	ret

INCBIN "baserom.gbc",$af20,$c000-$af20

SECTION "bank3",DATA,BANK[$3]
INCBIN "baserom.gbc", $c000,$4000

SECTION "bank4",DATA,BANK[$4]

INCBIN "baserom.gbc", $10000,$10d8f-$10000

SetupData_LoadRAM: ;04:4d8f, Loads names into RAM + more?
    ld c, $a
    ld a, [de]
    ld b, a
    ld a, [$c64e]
    cp b
    jp nz, $4ddb
    ld hl, $a500
    ld b, $0
    ld a, [$c654]
    ld c, a
    ld a, $5
    call $02b8
    push de
    ld hl, $ac00
    ld b, $0
    ld a, [$c652]
    ld c, a
    ld a, $8
    call $02b8
    pop de
    ld b, $20
    push hl
.asm_10dbb
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .asm_10dbb ; 0x10dbf $fa
    ld a, [$c652]
    inc a
    ld [$c652], a
    pop hl
    ld d, h
    ld e, l
    ld hl, $0011
    add hl, de
    ld a, [$c650]
    ld [hl], a
    ld a, [$c650]
    inc a
    ld [$c650], a
    ret
; 0x10ddb

INCBIN "baserom.gbc", $10ddb,$10de8-$10ddb

unk_044de8:
    ld a, $0 ; 4:4de8, 0x10de8
    ld [$c64e], a
    ld hl, $ac00
    ld b, $0
    ld a, [$c64e]
    ld c, a
    ld a, $8
    call $02b8
    ld a, [de]
    or a
    ret z
    push de
    ld hl, $000b
    add hl, de
    ld a, [hli]
    ld [$c650], a
    ld a, [hl]
    ld [$c651], a
    ld b, $0
.asm_10e0d
    push bc
    ld hl, $a640
    ld c, b
    ld b, $0
    ld a, $5
    call $02b8
    pop bc
    ld hl, $0001
    add hl, de
    ld a, [hl]
    ld h, a
    ld a, [$c650]
    cp h
    jr nz, .asm_10e32 ; 0x10e24 $c
    ld hl, $001f
    add hl, de
    ld a, [hl]
    ld h, a
    ld a, [$c651]
    cp h
    jr z, .asm_10e35 ; 0x10e30 $3
.asm_10e32
    inc b
    jr .asm_10e0d ; 0x10e33 $d8
.asm_10e35
    ld h, d
    ld l, e
    pop de
    push hl
    ld hl, $0080
    add hl, de
    ld d, h
    ld e, l
    pop hl
    ld b, $20
.asm_10e42
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_10e42 ; 0x10e46 $fa
    ld a, [$c64e]
    inc a
    ld [$c64e], a
    cp $3
    jp nz, $4ded
    ret
	;10e55

unk_044e55:
    xor a
    ld [$c5c2], a
    ld hl, $ac00
    ld b, $0
    ld a, [$c5c2]
    ld c, a
    ld a, $8
    call $02b8
    ld a, [de]
    or a
    jp z, $4efa
    push de
    ld hl, $000d
    add hl, de
    ld a, [hl]
    and $7f
    ld c, a
    ld a, $0
    ld de, $9010
    call $0297
    pop de
    push de
    ld hl, $000e
    add hl, de
    ld a, [hl]
    and $7f
    ld c, a
    ld a, $1
    ld de, $9110
    call $0297
    pop de
    push de
    ld hl, $000f
    add hl, de
    ld a, [hl]
    and $7f
    ld c, a
    ld a, $2
    ld de, $9200
    call $0297
    pop de
    push de
    ld hl, $0010
    add hl, de
    ld a, [hl]
    and $7f
    ld c, a
    ld a, $3
    ld de, $92f0
    call $0297
    pop de
    xor a
    ld [$c741], a
.asm_10eb8
    ld a, [$c741]
    add $1
    ld c, a
    call $01b9
    ld a, [$c741]
    inc a
    ld [$c741], a
    ld a, [$c741]
    cp $e
    jr nz, .asm_10eb8 ; 0x10ecd $e9
    ld a, $2
    call $01e6
    ld hl, $a000
    ld b, $0
    ld a, [$c5c2]
    ld c, a
    ld a, $a
    call $02b8
    ld hl, $9010
    ld bc, $0400
.asm_10ee8
    di
    call $016e
    ld a, [hli]
    ei
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, .asm_10ee8 ; 0x10ef3 $f3
    ld a, $1
    call $01e6
    ld a, [$c5c2]
    inc a
    ld [$c5c2], a
    cp $6
    jp nz, $4e59
    ret
; 0x10f07
INCBIN "baserom.gbc", $10f07,$10f2a-$10f07

unk_044f2a:
	xor a
	ld [$c658], a
	ld hl, $ac00
	ld b, $0
	ld a, [$c658]
	ld c, a
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jp z, $5144
	ld a, [$c658]
	ld hl, $0020
	add hl, de
	ld [hl], a
	ld hl, $0083
	add hl, de
	ld a, [hli]
	sla a
	ld b, a
	ld a, [hl]
	add b
	ld hl, $0024
	add hl, de
	ld [hl], a
	ld hl, $0012
	add hl, de
	ld a, [hl]
	ld hl, $0025
	add hl, de
	ld [hl], a
	ld hl, $000d
	add hl, de
	ld a, [hli]
	and $7f
	ld c, a
	ld b, $0
	ld a, $7
	push de
	call $0276
	pop de
	ld a, [$c64e]
	or a
	jr nz, .asm_10f79 ; 0x10f77 $0
.asm_10f79
	ld hl, $0038
	add hl, de
	ld [hl], a
	ld hl, $00d3
	add hl, de
	ld [hl], a
	ld hl, $000d
	add hl, de
	ld a, [hli]
	ld hl, $0039
	add hl, de
	ld [hl], a
	ld hl, $000d
	add hl, de
	ld a, [hli]
	and $7f
	ld c, a
	ld b, $0
	ld a, $2
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $003a
	add hl, de
	ld [hl], a
	ld hl, $00c0
	add hl, de
	ld [hl], a
	ld hl, $000e
	add hl, de
	ld a, [hli]
	ld hl, $003f
	add hl, de
	ld [hl], a
	ld hl, $000e
	add hl, de
	ld a, [hli]
	and $7f
	ld c, a
	ld b, $1
	ld a, $2
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0040
	add hl, de
	ld [hl], a
	ld hl, $00c1
	add hl, de
	ld [hl], a
	ld hl, $000f
	add hl, de
	ld a, [hli]
	ld hl, $0045
	add hl, de
	ld [hl], a
	ld hl, $000f
	add hl, de
	ld a, [hli]
	and $7f
	ld c, a
	ld b, $2
	ld a, $2
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0046
	add hl, de
	ld [hl], a
	ld hl, $00c2
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hli]
	ld hl, $004b
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hli]
	and $7f
	ld c, a
	ld b, $3
	ld a, $2
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $004c
	add hl, de
	ld [hl], a
	ld hl, $00c3
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $3
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0051
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $4
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0052
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $5
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0053
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $6
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0054
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $7
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0055
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	ld b, $3
	ld a, $8
	push de
	call $0276
	pop de
	ld a, [$c64e]
	ld hl, $0056
	add hl, de
	ld [hl], a
	ld hl, $0013
	add hl, de
	ld a, [hl]
	dec a
	ld hl, $5151
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $0057
	add hl, de
	ld [hl], a
	xor a
	ld [$c64e], a
	ld [$c64f], a
	ld hl, $00c0
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c64f]
	add b
	ld [$c64f], a
	ld a, [$c64e]
	adc $0
	ld [$c64e], a
	ld hl, $00c1
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c64f]
	add b
	ld [$c64f], a
	ld a, [$c64e]
	adc $0
	ld [$c64e], a
	ld hl, $00c2
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c64f]
	add b
	ld [$c64f], a
	ld a, [$c64e]
	adc $0
	ld [$c64e], a
	ld hl, $00c3
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c64f]
	add b
	ld [$c64f], a
	ld a, [$c64e]
	adc $0
	ld [$c64e], a
	ld hl, $0059
	add hl, de
	ld a, [$c64e]
	ld [hli], a
	ld a, [$c64f]
	ld [hli], a
	ld a, [$c64e]
	ld [hli], a
	ld a, [$c64f]
	ld [hl], a
	ld a, [$c658]
	ld [$c650], a
	call $6391
	ld a, [$c658]
	inc a
	ld [$c658], a
	cp $6
	jp nz, $4f2e
	ret
; 0x11151
unk_045151:
	ld bc, $0001
	nop
	ld [bc], a
	ld [bc], a
	ld bc, $000e
	xor a
	ld [$c64e], a
	ld [$c650], a
	push bc
	ld hl, $ac00
	ld b, $0
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jr z, .asm_11184 ; 0x1116e $14
	ld a, [$c64e]
	inc a
	ld [$c64e], a
	ld hl, $0024
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c650]
	add b
	ld [$c650], a
.asm_11184
	pop bc
	inc c
	ld a, c
	cp $3
	jp nz, $5161
	ld c, $0
	xor a
	ld [$c652], a
	ld [$c654], a
	push bc
	ld hl, $af00
	ld b, $0
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jr z, .asm_111b8 ; 0x111a2 $14
	ld a, [$c652]
	inc a
	ld [$c652], a
	ld hl, $0024
	add hl, de
	ld a, [hl]
	ld b, a
	ld a, [$c654]
	add b
	ld [$c654], a
.asm_111b8
	pop bc
	inc c
	ld a, c
	cp $3
	jp nz, $5195
	ld a, [$c64e]
	ld [$a414], a
	ld a, [$c652]
	ld [$a424], a
	ld a, [$c650]
	ld [$a415], a
	ld a, [$c654]
	ld [$a425], a
	ret
; 0x111d9

INCBIN "baserom.gbc", $111d9,$1120c-$111d9

SetUpMedarotData: ; 1120c 4:520c
	ld a, [$c753]
	call $02bb
	ld a, [$c64e]
	ld [$c745], a
	xor a
	ld [$c65a], a
	ld hl, $af00
	ld b, $0
	ld a, [$c65a]
	ld c, a
	ld a, $8
	call $02b8
	ld a, $3
	ld [de], a
	ld a, $1
	ld hl, $0000
	add hl, de
	ld [hl], a
	ld a, [$c650]
	ld hl, $5326
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $0001
	add hl, de
	ld [hl], a
	ld a, [$c656]
	ld hl, $000b
	add hl, de
	ld [hl], a
	call $0162
	ld a, [$c5f0]
	and $3
	ld hl, $c650
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $000d
	add hl, de
	ld [hl], a
	call $0162
	ld a, [$c5f0]
	and $3
	ld hl, $c650
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $000e
	add hl, de
	ld [hl], a
	call $0162
	ld a, [$c5f0]
	and $3
	ld hl, $c650
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $000f
	add hl, de
	ld [hl], a
	call $0162
	ld a, [$c5f0]
	and $3
	ld hl, $c650
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, $0010
	add hl, de
	ld [hl], a
	ld a, [$c65a]
	inc a
	ld hl, $0011
	add hl, de
	ld [hl], a
	ld a, [$c64e]
	push af
	call $539b
	pop af
	ld [$c64e], a
	ld hl, $000d
	add hl, de
	ld a, [hl]
	and $7f
	ld c, a
	call $02be
	push de
	ld b, $9 ; MEDAROT NAME LENGTH
	ld hl, $0002
	add hl, de
	ld d, h
	ld e, l
	ld hl, $c6a2
.asm_112cb
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_112cb ; 0x112cf $fa
	pop de
	ld a, $1
	ld hl, $00c8
	add hl, de
	ld [hl], a
	ld hl, $0080
	add hl, de
	ld a, $1
	ld [hl], a
	ld hl, $000b
	add hl, de
	ld a, [hl]
	ld hl, $0081
	add hl, de
	ld [hl], a
	ld a, [$c654]
	ld b, a
	ld a, [$c934]
	add b
	ld c, a
	sub $b
	jr c, .asm_112f9 ; 0x112f5 $2
	ld c, $a
.asm_112f9
	ld a, c
	ld hl, $0083
	add hl, de
	ld [hl], a
	ld a, [$c655]
	ld b, a
	ld a, [$c935]
	add b
	ld c, a
	sub $7
	jr c, .asm_1130e ; 0x1130a $2
	ld c, $6
.asm_1130e
	ld a, c
	ld hl, $0084
	add hl, de
	ld [hl], a
	ld a, [$c65a]
	inc a
	ld [$c65a], a
	ld a, [$c64e]
	dec a
	ld [$c64e], a
	jp nz, $521c
	ret
; 0x11326

INCBIN "baserom.gbc", $11326,$113b7-$11326

unk_0453b7:
	xor a
	ld [$c64e], a
	ld hl, $ac00
	ld b, $0
	ld a, [$c64e]
	ld c, a
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jp z, $5451
	ld hl, $00c8
	add hl, de
	ld a, [hl]
	ld [$c650], a
	ld hl, $0057
	add hl, de
	ld a, [hl]
	ld [$c651], a
	ld hl, $c1e0
	ld b, $0
	ld a, [$c64e]
	ld c, a
	ld a, $5
	call $02b8
	ld hl, $0004
	add hl, de
	ld a, [$c650]
	sla a
	sla a
	sla a
	ld b, a
	ld a, [$c651]
	sla a
	add b
	add $d0
	ld [hl], a
	ld hl, $0017
	add hl, de
	ld [hl], a
	ld hl, $5463
	ld b, $0
	ld a, [$c64e]
	ld c, a
	sla c
	rl b
	add hl, bc
	ld a, [hli]
	ld [$c652], a
	ld a, [hl]
	ld [$c653], a
	ld hl, $0002
	add hl, de
	ld a, [$c652]
	ld [hli], a
	ld a, [$c653]
	ld [hl], a
	ld a, $11
	ld [de], a
	ld b, $8
	ld a, [$c650]
	or a
	jr z, .asm_1143a ; 0x11433 $5
	ld a, $21
	ld [de], a
	ld b, $98
.asm_1143a
	ld hl, $0012
	add hl, de
	ld a, b
	ld [hl], a
	ld a, [$c650]
	sla a
	sla a
	ld c, a
	ld a, [$c651]
	add $50
	add c
	call $0165
	ld a, [$c64e]
	inc a
	ld [$c64e], a
	cp $6
	jp nz, $53bb
	ld a, $1
	ld [$c600], a
	ret
; 0x11463

INCBIN "baserom.gbc", $11463,$11514-$11463

;04:5514, 0x11514
    add hl, bc
    ld a, [hl]
    and $7f
    ld b, $0
    ld c, $0
    call $0294
    ld hl, $c6a2
    call $028e
    ld hl, $99c6
    ld b, $0
    ld c, a
    add hl, bc
    ld b, h
    ld c, l
    ld hl, $c6a2
    call $0264
    ret
; 0x11535

INCBIN "baserom.gbc", $11535,$1154b-$11535

        ld hl, $000e
        add hl, de
        ld a, [hl]
        and $7f
        ld hl, $b5a0
        ld c, a
        ld b, $0
        sla c
        rl b
        add hl, bc
        ld a, [hl]
        and $7f
        ld b, $0
        ld c, $1
        call $0294
        ld hl, $c6a2
        ld bc, $9a0b
        call $0264
        ret
; 0x11571

INCBIN "baserom.gbc", $11571,$11598-$11571
        add hl, bc
        ld a, [hl]
        and $7f
        ld b, $0
        ld c, $2
        call $0294
        ld hl, $c6a2
        call $546f
        ld hl, $9a01
        ld b, $0
        ld c, a
        add hl, bc
        ld b, h
        ld c, l
        ld hl, $c6a2
        call $0264
        ret
; 0x115b9

INCBIN "baserom.gbc", $115b9,$136cc-$115b9

DrawMedarotData:
	xor a
	ld [$c652], a
	ld hl, $ac00
	ld b, $0
	ld a, [$c652]
	ld c, a
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jp z, $770d
	ld hl, $0002
	add hl, de
	call $546f
	ld [$c650], a
	push de
	ld hl, $98e0
	ld b, $0
	ld a, [$c652]
	ld c, a
	ld a, $6
	call $02b8
	pop de
	ld a, [$c650]
	ld b, $0
	ld c, a
	add hl, bc
	ld b, h
	ld c, l
	ld hl, $0002
	add hl, de
	call $0264
	ld a, [$c652]
	inc a
	ld [$c652], a
	cp $3
	jp nz, $76d0
	xor a
	ld [$c652], a
	ld hl, $af00
	ld b, $0
	ld a, [$c652]
	ld c, a
	ld a, $8
	call $02b8
	ld a, [de]
	or a
	jp z, $7749
	push de
	ld hl, $98ec
	ld b, $0
	ld a, [$c652]
	ld c, a
	ld a, $6
	call $02b8
	pop de
	ld b, h
	ld c, l
	ld hl, $0002
	add hl, de
	call $0264
	ld a, [$c652]
	inc a
	ld [$c652], a
	cp $3
	jp nz, $771d
	ret
; 0x13756

INCBIN "baserom.gbc", $13756,$14000 -$13756

SECTION "bank5",DATA,BANK[$5]
INCBIN "baserom.gbc", $14000,$158b5-$14000

unk_0558B5: ;05:58b5, 0x158b5, pulls name text during attacks
	push de
    ld hl, $0002
    add hl, de
    ld de, $c6a2
    ld b, $9
.asm_158bf
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_158bf ; 0x158c3 $fa
    pop de
    ret
; 0x158c7
unk_0558c7: ;05:58c7, 0x158c7
    push de
    ld [$c650], a
    ld hl, $000d
    add hl, de
    ld b, $0
    ld a, [$c650]
    ld c, a
    add hl, bc
    ld a, [hl]
    and $7f
    push af
    ld b, $0
    ld a, [$c650]
    ld c, a
    pop af
    call $0294
    ld hl, $c6a2
    ld de, $c705
    ld b, $9
.asm_158ec
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_158ec ; 0x158f0 $fa
    pop de
    ret
; 0x158f4
unk_0558f4: ;05:58f4, 0x158f4
    push de
    ld [$c650], a
    ld hl, $002f
    add hl, de
    ld a, [hl]
    and $7f
    push af
    ld b, $0
    ld a, [$c650]
    ld c, a
    pop af
    call $0294
    ld hl, $c6a2
    ld de, $c70e
    ld b, $9
.asm_15912
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .asm_15912 ; 0x15916 $fa
    pop de
    ret
; 0x1591a
INCBIN "baserom.gbc", $1591a,$18000-$1591a

SECTION "bank6",DATA,BANK[$6]
INCBIN "baserom.gbc", $18000,$4000

SECTION "bank7",DATA,BANK[$7]
INCBIN "baserom.gbc", $1c000,$27a0

; free space

SECTION "bank8",DATA,BANK[$8]
INCBIN "baserom.gbc", $20000,$4000

SECTION "bank9",DATA,BANK[$9]
INCBIN "baserom.gbc", $24000,$4000

SECTION "banka",DATA,BANK[$a]
INCBIN "baserom.gbc", $28000,$4000

SECTION "bankb",DATA,BANK[$b]
INCBIN "baserom.gbc", $2c000,$4000

SECTION "bankc",DATA,BANK[$c]
INCBIN "baserom.gbc", $30000,$4000

SECTION "bankd",DATA,BANK[$d]
INCBIN "baserom.gbc", $34000,$4000

SECTION "banke",DATA,BANK[$e]
INCBIN "baserom.gbc", $38000,$4000

SECTION "bankf",DATA,BANK[$f]
INCBIN "baserom.gbc", $3c000,$4000

SECTION "bank10",DATA,BANK[$10]
INCBIN "baserom.gbc", $40000,$4000

SECTION "bank11",DATA,BANK[$11]
INCBIN "baserom.gbc", $44000,$4000

SECTION "bank12",DATA,BANK[$12]
INCBIN "baserom.gbc", $48000,$4000

SECTION "bank13",DATA,BANK[$13]
INCBIN "baserom.gbc", $4c000,$4000

SECTION "bank14",DATA,BANK[$14]
INCBIN "baserom.gbc", $50000,$4000

SECTION "bank15",DATA,BANK[$15]
INCBIN "baserom.gbc", $54000,$4000

SECTION "bank16",DATA,BANK[$16]
INCBIN "baserom.gbc", $58000,$4000

SECTION "bank17",DATA,BANK[$17]
INCBIN "baserom.gbc", $5c000,$4000

SECTION "bank18",DATA,BANK[$18]
INCBIN "baserom.gbc", $60000,$4000

SECTION "bank19",DATA,BANK[$19]
INCBIN "baserom.gbc", $64000,$4000

SECTION "bank1a",DATA,BANK[$1a]
INCBIN "baserom.gbc", $68000,$4000

SECTION "bank1b",DATA,BANK[$1b]
INCBIN "baserom.gbc", $6c000,$6ec7e-$6c000

StatsScreen: ; 6ec7e
	ld hl, $ac00
	ld a, [$c0d7]
	ld b, $0
	ld c, a
	ld a, $8
	call $02b8
	push de
	ld hl, $0002
	add hl, de
	push hl
	call $028e
	ld h, $0
	ld l, a
	ld bc, $984b
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	call $0264
	pop de
	push de
	ld hl, $0081
	add hl, de
	ld a, [hl]
	ld de, $9410
	call $027c
	pop de
	ld a, $41
	ld hl, $988a
	call $6d0e
	push de
	ld hl, $0081
	add hl, de
	ld a, [hl]
	call $0282
	ld hl, $c6a2
	ld bc, $98ac
	call $0264
	pop de
	call $6fc4
	ld hl, $000d
	add hl, de
	ld a, [hl]
	and $7f
	ld [$a03d], a
	push de
	call $6d2c
	pop de
	ld hl, $000e
	add hl, de
	ld a, [hl]
	and $7f
	ld [$a03f], a
	push de
	call $6d54
	pop de
	ld hl, $000f
	add hl, de
	ld a, [hl]
	and $7f
	ld [$a041], a
	push de
	call $6d7c
	pop de
	ld hl, $0010
	add hl, de
	ld a, [hl]
	and $7f
	ld [$a043], a
	push de
	call $6da4
	pop de
	call $6ece
	ret
; 0x6ed0e

INCBIN "baserom.gbc", $6ed0e,$6ed3e-$6ed0e

SetupScreen_GetHeadData: ;1b:6d3e,0x6ed3e
    ld a, [$a03d]
    and $7f
    ld b, $0
    ld c, $0
    call $0294
    ld hl, $c6a2
    ld bc, $9949
    call $0264
    ret
; 0x6ed54

INCBIN "baserom.gbc", $6ed54,$6ed66-$6ed54

SetupScreen_GetRArmData: ;1b:6d66, 0x6ed66
    ld a, [$a03f]
    and $7f
    ld b, $0
    ld c, $1
    call $0294
    ld hl, $c6a2
    ld bc, $9989
    call $0264
    ret
; 0x6ed7c

INCBIN "baserom.gbc", $6ed7c,$6ed8e-$6ed7c

SetupScreen_GetLArmData: ;1b:6d8e, 0x6ed8e
    ld a, [$a041]
    and $7f
    ld b, $0
    ld c, $2
    call $0294
    ld hl, $c6a2
    ld bc, $99c9
    call $0264
    ret
; 0x6eda4

INCBIN "baserom.gbc", $6eda4,$6edb6-$6eda4

SetupScreen_GetLegsData: ;1b:6db6, 0x6edb6
    ld a, [$a043]
    and $7f
    ld b, $0
    ld c, $3
    call $0294
    ld hl, $c6a2
    ld bc, $9a09
    call $0264
    ret
; 0x6edcc

INCBIN "baserom.gbc", $6edcc,$70000-$6edcc

SECTION "bank1c",DATA,BANK[$1c]
INCBIN "baserom.gbc", $70000,$4000

SECTION "bank1d",DATA,BANK[$1d]
INCBIN "baserom.gbc", $74000,$4000

SECTION "bank1e",DATA,BANK[$1e]
INCBIN "baserom.gbc", $78000,$4000

SECTION "bank1f",DATA,BANK[$1f]
INCBIN "baserom.gbc", $7c000,$4000