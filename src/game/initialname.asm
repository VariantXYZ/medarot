;Logic pertaining to the initial name screen

SECTION "Setup Initial Name Screen", ROMX[$4a9f], BANK[$1]
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
