SECTION "bank0",HOME
SECTION "rst0",HOME[$0]
	pop hl
	add a
	rst $28
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]

SECTION "rst8",HOME[$8] ; HackPredef
    ld [TempA], a ; 3
	jp Rst8Cont

SECTION "rst10",HOME[$10] ; Bankswitch
    ld [hBank], a
	ld [$2000], a
	ret

SECTION "rst18",HOME[$18]
	ld a, [$c6e0]
	;ld [$2000], a
	rst $10
	ret

SECTION "rst20",HOME[$20]
	add l
	ld l, a
	ret c
	dec h
	ret

SECTION "rst28",HOME[$28]
	add l
	ld l, a
	ret nc
	inc h
	ret

SECTION "rst30",HOME[$30]
    add a
    rst $28
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ret

SECTION "rst38",HOME[$38]
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

SECTION "vblank",HOME[$40] ; vblank interrupt
	jp $049b

SECTION "lcd",HOME[$48] ; lcd interrupt
	jp $04d0

SECTION "timer",HOME[$50] ; timer interrupt
	nop

SECTION "serial",HOME[$58] ; serial interrupt
	jp $3e12

SECTION "joypad",HOME[$60] ; joypad interrupt
	reti

Rst8Cont:
    ld a, [hBank]
	ld [BankOld],a
	ld a, BANK(HackPredef)
	ld [$2000], a
    call HackPredef
    ld [TempA], a
    ld a, [BankOld]
    cp a, $17
    jr z, .bs
    cp a, $1f
    jr nc, .bs ; new bank
    ld a, [$c6e0]
.bs
	ld [$2000], a
	ld a, [TempA]
	ret

;Char4FAdvice:
;    ld a, $6
;    rst $8
;    jp Char4F
Char4EAdvice:
    ld a, $6
    rst $8
    jp Char4E
;Char4CAdvice:
;    ld a, $6
;    rst $8
;    jp Char4C
Char4AAdvice:
    ld a, $6
    rst $8
    jp Char4A
SECTION "romheader",HOME[$100]

INCBIN "baserom.gbc", $100, $50

SECTION "start",HOME[$150]

INCBIN "baserom.gbc", $150,$cb7-$150

CopyVRAMData: ;  cb7
	ld a, [hli]
	di
	call $17cb
	ld [de], a
	ei
	inc de
	dec bc
	ld a, b
	or c
	jr nz, CopyVRAMData ; 0xcc2 $f3
	ret
; 0xcc5

INCBIN "baserom.gbc", $cc5,$e2c-$cc5

LoadTilemap_: ; $e2c	ld a, $1e
	ld a, BANK(Tilemaps) ; $1e
	rst $10
	push de
	ld a, b
	and $1f
	ld b, a
	ld a, c
	and $1f
	ld c, a
	ld d, $0
	ld e, c
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld hl, $9800
	ld c, b
	ld b, $0
	add hl, bc
	add hl, de
	pop de
	push hl
	ld hl, Tilemaps
	ld d, $0
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld b, h
	ld c, l
	ld a, [de]
	cp $ff
	jp z, $0f83
	and $3
	jr z, .asm_e7d ; 0xe71 $a
	dec a
	jr z, .asm_eac ; 0xe74 $36
	dec a
	jp z, $0f20
	jp $0f51
.asm_e7d
	inc de
	ld a, [de]
	cp $ff
	jp z, $0f83
	cp $fe
	jr z, .asm_e97 ; 0xe86 $f
	cp $fd
	jr z, .asm_ea6 ; 0xe8a $1a
	di
	call $17cb
	ld [hli], a
	ei
	call $2a2a
	jr .asm_e7d ; 0xe95 $e6
.asm_e97
	push de
	ld de, $0020
	ld h, b
	ld l, c
	add hl, de
	call $2a94
	ld b, h
	ld c, l
	pop de
	jr .asm_e7d ; 0xea4 $d7
.asm_ea6
	inc hl
	call $2a2a
	jr .asm_e7d ; 0xeaa $d1
.asm_eac
	inc de
	ld a, [de]
	cp $ff
	jp z, $0f83
	ld a, [de]
	and $c0
	cp $c0
	jp z, $0f08
	cp $80
	jp z, $0ef0
	cp $40
	jp z, $0ed9
	push bc
	ld a, [de]
	inc a
	ld b, a
	inc de
	ld a, [de]
	di
	call $17cb
	ld [hli], a
	ei
	dec b
	jp nz, $0ec9
	pop bc
	jp $0eac
; 0xed9

INCBIN "baserom.gbc", $ed9,$f84-$ed9

LoadTilemapWindow ; f84
	ld a, BANK(Tilemaps) ; was $1e
	rst $10
	push de
	ld a, b
	and $1f
	ld b, a
	ld a, c
	and $1f
	ld c, a
	ld d, $0
	ld e, c
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	sla e
	rl d
	ld hl, $9c00
	ld c, b
	ld b, $0
	add hl, bc
	add hl, de
	pop de
	push hl
	ld hl, Tilemaps
	ld d, $0
	sla e
	rl d
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld b, h
	ld c, l
	ld a, [de]
	cp $ff
	jp z, $10d2
	and $3
	jr z, .asm_fd5 ; 0xfc9 $a
	dec a
	jr z, .asm_ffb ; 0xfcc $2d
	dec a
	jp z, $106f
	jp $10a0
.asm_fd5
	inc de
	ld a, [de]
	cp $ff
	jp z, $10d2
	cp $fe
	jr z, .asm_fec ; 0xfde $c
	cp $fd
	jr z, .asm_ff8 ; 0xfe2 $14
	di
	call $17cb
	ld [hli], a
	ei
	jr .asm_fd5 ; 0xfea $e9
.asm_fec
	push de
	ld de, $0020
	ld h, b
	ld l, c
	add hl, de
	ld b, h
	ld c, l
	pop de
	jr .asm_fd5 ; 0xff6 $dd
.asm_ff8
	inc hl
	jr .asm_fd5 ; 0xff9 $da
.asm_ffb
	inc de
	ld a, [de]
	cp $ff
	jp z, $10d2
	ld a, [de]
	and $c0
	cp $c0
	jp z, $1057
	cp $80
	jp z, $103f
	cp $40
	jp z, $1028
	push bc
	ld a, [de]
	inc a
	ld b, a
	inc de
	ld a, [de]
	di
	call $17cb
	ld [hli], a
	ei
	dec b
	jp nz, $1018
	pop bc
	jp $0ffb
; 0x1028

INCBIN "baserom.gbc", $1028,$1c87-$1028

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

   db 02, 04, 00

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

TextTableBanks: ; 0x1d3b
    db BANK(Snippet1)
    db BANK(Snippet2)
    db BANK(Snippet3)
    db BANK(Snippet4)
    db BANK(StoryText1)
    db BANK(Snippet5)
    db $00
    db $00
    db BANK(StoryText2)
    db $00
    db BANK(StoryText3)
    db $00
    db $00
    db BANK(BattleText)
    db $00
    db $00

TextTableOffsets: ; 0x1d4b
    dw Snippet1
    dw Snippet2
    dw Snippet3
    dw Snippet4
    dw StoryText1
    dw Snippet5
    dw $4000
    dw $4000
    dw StoryText2
    dw $4000
    dw StoryText3
    dw $4000
    dw $4000
    dw BattleText
    dw $4000
    dw $4000

Char4F: ; 1d6b end of text
	;ld a, $7; Char4FAdvice
	;rst $0
	ld a, $12
	rst $8 ;SetFlag4F

	inc hl
	ld a, [hl]
	or a

	jp nz, .Char4fMore
	ld a, [$ff8d]
	and $3
	jr nz, .asm_1d8b ; 0x1d75 $14
	ld a, [$ff8c]
	and $3
	jr z, .asm_1d89 ; 0x1d7b $c
	ld a, [$c6c5]
	cp $10
	jp z, .asm_1d8b
	inc a
	ld [$c6c5], a
.asm_1d89
	pop hl
	ret
.asm_1d8b
	ld a, $22
	ld [$ffa1], a
	xor a
	ld [$c5c7], a
	ld [$c6c5], a
	call $1ab0
	ld a, $1
	ld [$c6c6], a
	pop hl
	ret
.Char4fMore: ; 0x1da0
	ld a, [hl]
	cp $1
	jr nz, .asm_1db6 ; 0x1da3 $11
	xor a
	ld [$c5c7], a
	ld [$c6c5], a
	call $1ab0
	ld a, $1
	ld [$c6c6], a
	pop hl
	ret
.asm_1db6
	ld a, [hl]
	cp $2
	jr nz, .asm_1de4 ; 0x1db9 $29
	ld a, [$ff8d]
	and $3
	jr nz, .asm_1dd5 ; 0x1dbf $14
	ld a, [$ff8c]
	and $3
	jr z, .asm_1d89 ; 0x1dc5 $c2
	ld a, [$c6c5]
	cp $10
	jp z, .asm_1dd5
	inc a
	ld [$c6c5], a
	pop hl
	ret
.asm_1dd5
	ld a, $22
	ld [$ffa1], a
	xor a
	ld [$c6c5], a
	ld a, $1
	ld [$c6c6], a
	pop hl
	ret
.asm_1de4
	ld a, [hl]
	cp $3
	jr nz, .asm_1e1b ; 0x1de7 $32
	ld a, [$ff8d]
	and $3
	jr nz, .asm_1e03 ; 0x1ded $14
	ld a, [$ff8c]
	and $3
	jr z, .asm_1d89 ; 0x1df3 $94
	ld a, [$c6c5]
	cp $10
	jp z, .asm_1e03
	inc a
	ld [$c6c5], a
	pop hl
	ret
.asm_1e03
	ld a, $22
	ld [$ffa1], a
	ld b, $1
	ld c, $1
	ld e, $2f
	call $0f84
	xor a
	ld [$c6c5], a
	ld a, $1
	ld [$c6c6], a
	pop hl
	ret
.asm_1e1b
	ld a, $1
	ld [$c6c6], a
	pop hl
	ret

Char4E:
	ld hl, $9c00
	ld bc, $0081
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1e32 ; 0x1e2d $3
	ld bc, $0061
.asm_1e32
	add hl, bc
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ld a, [$c6c0]

	ld a, $b
	rst $8 ; IncTextOffsetAndResetVWF
	;inc a
	;ld [$c6c0], a
	pop hl
	jp HandleTextOffset

Char4D: ; 0x1e46
; text speed
	inc hl
	ld a, [hl]
	ld [$c6c1], a
	ld [$c6c4], a
	;ld a, [$c6c0]
	ld a, $9
	rst $8 ; IncTextOffset
	;add $2
	ld a, $9
	rst $8 ; IncTextOffset
	;ld [$c6c0], a
	pop hl
	ld a, [$c6c1]
	cp $ff
	ret nz
	xor a
	ld [$c6c1], a
	ret

Char4C: ; 0x1e62
; new text box
	pop hl
	ld hl, $9c00
	ld bc, $0092
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1e73 ; 0x1e6e $3
	ld bc, $0072
.asm_1e73
	add hl, bc
	ld a, $fa
	di
	call $17cb
	ld [hl], a
	ei
	ld a, [$ff8d]
	and $3
	jr nz, .asm_1e94 ; 0x1e80 $12
	ld a, [$ff8c]
	and $3
	ret z
	ld a, [$c6c5]
	cp $10
	jp z, .asm_1e94
	inc a
	ld [$c6c5], a
	ret
.asm_1e94
	ld a, $22
	ld [$ffa1], a
	xor a
	ld [$c6c5], a
	ld b, $1
	ld c, $1
	ld e, $2f
	call $0f84
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1eb5 ; 0x1eaa $9
	ld b, $0
	ld c, $0
	ld e, $30
	call $0f84
.asm_1eb5
	ld hl, $9c00
	ld bc, $0041
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1ec5 ; 0x1ec0 $3
	ld bc, $0021
.asm_1ec5
	add hl, bc
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ld a, [$c6c0]
	inc a
	ld a, $b
	rst $8 ; IncTextOffsetAndResetVWF
	;ld [$c6c0], a
	ret

Char4B: ; 0x1ed6
; call subtext
	inc hl
	ld a, [hli] ; bank
	push af
	;ld a, [hli]
	;ld h, [hl]
	;ld l, a
	rst $38
	pop af
	cp $00
	jr z, .Char4BCont ;2
	rst $10
	ld b,h
	ld c,l
	pop hl
	ld a,$e ;Char4BAdvice2, set b, c, a
	rst $8
	jp HandleTextOffset;3
	db 0
.Char4BCont
	;add hl, bc
	ld a,$d ;Char4BAdvice, set b, c
	rst $8
	ld a, [hl]
	cp $50
	jr nz, .asm_1f04 ; 0x1ee4 $1e
	ld a, $f
	rst $8 ; IncTextOffset4Times
	xor a
	ld [$c6c5], a
	ld a, [$c6c4]
	ld [$c6c1], a
	pop hl
	cp $ff
	ret nz
	xor a
	ld [$c6c1], a
	jp HandleTextOffset
.asm_1f04
	ld d, a
	ld a, $40
	sub d
	jp c, $1f2f
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
	;ld [hl], a
	;ei
	pop hl
	ld a, [hl]
	ld d, a
	ld a, [$c6c2]
	ld h, a
	ld a, [$c6c3]
	ld l, a
	ld a, d
	;di
	;call $17cb
	;ld [hl], a
	;ei
	;inc hl
	; ^ 7
	ld [hSaveA], a ; 2
	xor a ; 1
	rst $8 ; 1 ; WriteCharAdvice
	ld a, [hSaveA]
	nop
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ld a, [$c6c5]
	inc a
	ld [$c6c5], a
	ld a, [$c6c4]
	ld [$c6c1], a
	pop hl
	cp $ff
	ret nz
	xor a
	ld [$c6c1], a
	jp HandleTextOffset


Char4A: ; 0x1f5f
; \r
	ld c, $1
	ld a, $41
	ld [$c650], a
	ld a, [$c5c7]
	cp $1
	jr z, .asm_1f74 ; 0x1f6b $7
	ld c, $0
	ld a, $21
	ld [$c650], a
.asm_1f74
	ld b, $1
	ld e, $2f
	call $0f84
	ld hl, $9c00
	ld a, [$c650]
	ld b, $0
	ld c, a
	add hl, bc
	ld a, h
	ld [$c6c2], a
	ld a, l
	ld [$c6c3], a
	ld a, [$c6c0]
	inc a

	ld a, $9
	rst $8 ; IncTextOffset
	;ld [$c6c0], a
	pop hl
	ret
; 0x1f96

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


INCBIN "baserom.gbc", $1ff2,$2d85-$1ff2

LoadFontDialogue: ; 2d85
    ld a, 5 ; LoadFontDialogueAdvice
    rst $8
    ;ld a, 3
    ;call $12e8 ; Decompress
    nop
    nop
    ret
;2d8b

INCBIN "baserom.gbc", $2d8b,$2dba-$2d8b

; 2dba
    ld a, $17
;    ld [$2000], a
    rst $10
    nop
    nop

INCBIN "baserom.gbc", $2dbf,$2e58-$2dbf

LoadMedarotterData: ;Load Medarotter Names 2e58 to 2eaf
    ld a, $17
    rst $10
    nop
    nop
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

INCBIN "baserom.gbc", $2eb0,$2f43-$2eb0

    ld a, $17
;    ld [$2000], a
    rst $10
    nop
    nop

INCBIN "baserom.gbc", $2f48,$2faa-$2f48
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

INCBIN "baserom.gbc", $303b,$328f-$303b

LoadItemData: ;328f to 32b8, 0x29 bytes
	push af
	ld a,BANK(ItemData)
	ld [$2000],a
	pop af
	dec a
	ld hl,ItemData
	ld b,$00
	ld c,a
	call GetListOffset ;6
	sla c
	rl b
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add hl, bc
	ld de,ListText ;Originally c6a2
	ld b,$19
.asm_032b2
	ldi a,hl
	ld [de],a
	inc de
	dec b
	jr nz,.asm_032b2
	ret

LoadMedalData: ;0x32b9 to 0x32de, 0x26 bytes
	push af
	ld a,Bank(MedalData)
	ld [$2000],a
	pop af
	ld hl, MedalData
	ld b,$00
	ld c,a
	call GetListOffset ;6
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	add hl, bc
	ld de,ListText ;New location for longer list buffer, originally c6a2
	ld b,$0F ;Increase max size to 16 bytes for names
.asm_032d8
	ldi a,hl
	ld [de],a
	inc de
	dec b
	jr nz,.asm_032d8
	ret

INCBIN "baserom.gbc", $32df,$34f0-$32df

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
    ld de, ListText
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
    ld de, ListText
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
    ld a, $17 ;Something to do with font (Sanky?)
;    ld [$2000], a
    rst $10
    nop
    nop
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

LoadMedarotNameData: ;35dc to 35ff, 0x23 bytes
	push hl
	push de
	ld a,Bank(MedarotNames)
	ld [$2000],a
	ld hl,MedarotNames
	ld b,$00
	ld a,$04
	call $3981
	ld de,ListText ;RAM
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
	add $80
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
	add $80
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
	add $80
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
	add $80
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

INCBIN "baserom.gbc", $4000,$4417-$4000

    nop
    nop
    ld a, 2 ; LoadFont_
    rst $8

INCBIN "baserom.gbc", $441c,$4a9f-$441c

SetupInitialNameScreen: ;4a9f
    xor a
    ld hl, $c5c9
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld hl, $c923
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [$c6c6], a
	ld hl, $c6a2 ;TODO: Change to ListText
	ld a, $13 ;SetInitialName
	rst $8
    ld a, $6
    call $015f
    ld a, $2 ;Load Font
    rst $8
    ld b, $0
    ld c, $0
    ld e, $2
    call $015c
    ld b, $2
    ld c, $6
    ld e, $2b
    call $015c
    ld b, $1
    ld c, $1
    ld e, $29
    call $015c
    ld hl, $c6a2 ;TODO: Change to ListText
    ld bc, $984a
    ;call $0264
	call CopyRAMtoVRAM
	call $5213
    ld a, $1
    ld [$ffa0], a
    ld a, $4
    call $017d
    ld b, $5
    ld c, $5
    ld d, $5
    ld e, $5
    ld a, $2
    call $0309
    jp $0168
;Will copy data until we hit 0x50
CopyRAMtoVRAM: ;hl = Initial Addr, bc = To Addr
	push hl
	push bc
	push af
.CopyRAMtoVRAMloop:
	ld a, [hli]
	cp $50
	jr z, .copyRAMtoVRAMRet
	di
	call $17cb
	ld [bc], a
	inc bc
	ei
	jr .CopyRAMtoVRAMloop
.copyRAMtoVRAMRet:
	pop af
	pop bc
	pop hl
	ret
;extra space
	nop
; 0x4b1c
INCBIN "baserom.gbc", $4b1c,$4b2e-$4b1c

;TODO: Properly disassemble this routine which draws the OAM for the setup screen
;4b2e
ld a, $88
;4b30

INCBIN "baserom.gbc", $4b30,$64a6-$4b30

; after battle won
    ld a, 2 ; LoadFont_
    rst $8
;    call $15f ; probably not necessary

INCBIN "baserom.gbc", $64a9,$8000-$64a9

SECTION "bank2",DATA,BANK[$2]

INCBIN "baserom.gbc", $8000,$8038-$8000

; on start menu
    nop
    nop
    ld a, 2 ; LoadFont_
    rst $8
;803d

INCBIN "baserom.gbc", $803d,$8b71-$803d

; when returning to menu from items
    ld a, 2 ; LoadFont_
    rst $8
;8b74
INCBIN "baserom.gbc", $8b74,$8bdc-$8b74

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
	ld hl, ListText ;originally c6a2
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

INCBIN "baserom.gbc",$8c75,$9482-$8c75

; on medal screen and parts screen
    nop
    nop
    ld a, 3 ; LoadFont2
    rst $8

INCBIN "baserom.gbc", $9487,$9c78-$9487

; when returning to menu
    nop
    nop
    ld a, 2 ; LoadFont_
    rst $8

INCBIN "baserom.gbc", $9c7d,$9c84-$9c7d

; when returning from save screen
    ld a, 2 ; LoadFont_
    rst $8

INCBIN "baserom.gbc", $9c87,$a90b-$9c87

; on medarot choice selection
    nop
    nop
    ld a, 3 ; LoadFont2
    rst $8
;a910
INCBIN "baserom.gbc",$a910,$aefb-$a910

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
	ld hl, ListText ;Originally c6a2
	ld bc, $98ac
	call $0264
	ret
;af20
INCBIN "baserom.gbc",$af20,$c000-$af20

SECTION "bank3",DATA,BANK[$3]
INCBIN "baserom.gbc", $c000,$4000

SECTION "bank4",DATA,BANK[$4]

INCBIN "baserom.gbc", $10000,$10637-$10000

    ld a, 4 ; dec a n load font 2
    rst $8

INCBIN "baserom.gbc", $1063a,$10d8f-$1063a

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
	call $02be ;LoadMedarotNameData
	push de
	ld b, $10 ; MEDAROT NAME LENGTH
	ld hl, -$0010;$0002
	add hl, de
	ld d, h
	ld e, l
	ld hl, ListText ;Originally c6a2
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
    ld hl, ListText
    call $028e
    ld hl, $99c6
    ld b, $0
    ld c, a
    add hl, bc
    ld b, h
    ld c, l
    ld hl, ListText
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
    ld hl, ListText
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
        ld hl, ListText
        call $546f
        ld hl, $9a01
        ld b, $0
        ld c, a
        add hl, bc
        ld b, h
        ld c, l
        ld hl, ListText
        call $0264
        ret
; 0x115b9

INCBIN "baserom.gbc", $115b9,$132ea-$115b9

; entering battle selecting medarot
    ld a, 3 ; LoadFont2
    rst $8

INCBIN "baserom.gbc", $132ed,$136cc -$132ed

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
	ld hl, -$0010;$0002
	add hl, de
	call $0264
	ld a, [$c652]
	inc a
	ld [$c652], a
	cp $3
	jp nz, $771d
	ret
; 0x13756

INCBIN "baserom.gbc", $13756,$14000-$13756

SECTION "bank5",DATA,BANK[$5]
INCBIN "baserom.gbc", $14000,$158b5-$14000

unk_0558B5: ;05:58b5, 0x158b5, pulls name text during attacks
	push de
    ;ld hl, $0002 ;TODO: When we have a better disassembly, just have this information stored in a special RAM location
    ld a,$c
	rst $8 ;Use 0002 for ac00 and -0010 for af00
	add hl, de
    ld de, ListText
    ld b, $10
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
    ld hl, ListText
    ld de, $c705
    ld b, $10
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

INCBIN "baserom.gbc", $58000,$5b041-$58000
    ; tutorial
    ld a, 2 ; LoadFont_
    rst $8
INCBIN "baserom.gbc", $5b044,$5c000-$5b044

SECTION "bank17",DATA,BANK[$17]
INCBIN "baserom.gbc", $5c000,$4000

SECTION "bank18",DATA,BANK[$18]
INCBIN "baserom.gbc", $60000,$4000

SECTION "bank19",DATA,BANK[$19]
INCBIN "baserom.gbc", $64000,$4000

SECTION "bank1a",DATA,BANK[$1a]
INCBIN "baserom.gbc", $68000,$4000

SECTION "bank1b",DATA,BANK[$1b]
INCBIN "baserom.gbc", $6c000,$6eacb-$6c000

; main battle scr, returning from stats
    ;call $15f
    ld a, 4 ; Dec0AAndLoadFont2
    rst $8

INCBIN "baserom.gbc", $6eace,$6ec7e-$6eace

StatsScreen: ; 6ec7e
	ld hl, $ac00
	ld a, [$c0d7]
	ld b, $0
	ld c, a
	ld a, $8
	call $02b8
	push de
    ;ld hl, $0002 ;TODO: When we have a better disassembly, just have this information stored in a special RAM location
    ld a,$c
	rst $8 ;Use 0002 for ac00 and -0010 for af00
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
	call $0282 ;LoadMedalData
	ld hl, ListText ;Originally c6a2
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
    ld hl, ListText
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
    ld hl, ListText
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
    ld hl, ListText
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
    ld hl, ListText
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


; look!  it's a new bank!
SECTION "bank20",DATA,BANK[$20]

StoryText1:
    INCBIN "build/Dialogue_1.bin"

SECTION "bank21",DATA,BANK[$21]

BattleText:
    INCBIN "build/Battles.bin"

SECTION "bank22",DATA,BANK[$22]

StoryText2:
    INCBIN "build/Dialogue_2.bin"

SECTION "bank23",DATA,BANK[$23]

StoryText3:
    INCBIN "build/Dialogue_3.bin"

SECTION "bank24",DATA,BANK[$24]

INCLUDE "src/hack.asm"

;Snippets don't need to be in banks of their own, but to make the Makefile easier to write...
SECTION "bank25",DATA,BANK[$25]
Snippet1:
    INCBIN "build/Snippet_1.bin"

SECTION "bank26",DATA,BANK[$26]
Snippet2:
    INCBIN "build/Snippet_2.bin"

SECTION "bank27",DATA,BANK[$27]
Snippet3:
    INCBIN "build/Snippet_3.bin"

SECTION "bank28",DATA,BANK[$28]
Snippet4:
    INCBIN "build/Snippet_4.bin"

SECTION "bank29",DATA,BANK[$29]
Snippet5:
    INCBIN "build/Snippet_5.bin"

SECTION "bank2a",DATA,BANK[$2a]
Tilemaps:
    INCBIN "build/tilemaps.bin"

;Use this bank for lists
SECTION "bank2b",DATA,BANK[$2b]
GetListOffset: ;For most list offsets
	sla c ;2 byte offset
	rl b
	sla c ;4 byte offset
	rl b
	sla c ;8 byte offset
	rl b
	sla c ;16 byte offset
	rl b
	ret

MedalData:
	INCBIN "build/medals.bin"

MedarotNames:
    INCBIN "build/medarots.bin"

ItemData:
	INCBIN "build/items.bin"

SECTION "bank2c",DATA,BANK[$2c]
	INCBIN "build/additional/Additional_0.bin"
SECTION "bank2d",DATA,BANK[$2d]
	INCBIN "build/additional/Additional_1.bin"
SECTION "bank2e",DATA,BANK[$2e]
SECTION "bank2f",DATA,BANK[$2f]
SECTION "bank30",DATA,BANK[$30]
SECTION "bank31",DATA,BANK[$31]
SECTION "bank32",DATA,BANK[$32]
SECTION "bank33",DATA,BANK[$33]
SECTION "bank34",DATA,BANK[$34]
SECTION "bank35",DATA,BANK[$35]
SECTION "bank36",DATA,BANK[$36]
SECTION "bank37",DATA,BANK[$37]
SECTION "bank38",DATA,BANK[$38]
SECTION "bank39",DATA,BANK[$39]
SECTION "bank3a",DATA,BANK[$3a]
SECTION "bank3b",DATA,BANK[$3b]
SECTION "bank3c",DATA,BANK[$3c]
SECTION "bank3d",DATA,BANK[$3d]
SECTION "bank3e",DATA,BANK[$3e]
SECTION "bank3f",DATA,BANK[$3f]
