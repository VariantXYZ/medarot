SECTION "rst0", ROM0[$0]
	pop hl
	add a
	rst $28
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]

SECTION "rst8",ROM0[$8] ; HackPredef
	ld [TempA], a ; 3
	jp Rst8Cont

SECTION "rst8Cont",ROM0[$62]
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
	jr nc, .bs ; bank swap
	ld a, [$c6e0]
.bs
	ld [$2000], a
	ld a, [TempA]
	ret

; TODO: Move to txt/special.asm
Char4EAdvice:
  ld a, $6
	rst $8
  jp Char4E

Char4AAdvice:
	ld a, $6
	rst $8
	jp Char4A

SECTION "rst10, bank swap",ROM0[$10]
	ld [hBank], a
	ld [$2000], a
  ret

SECTION "rst18",ROM0[$18]
  ld a, [$c6e0]
  rst $10
  ret

SECTION "rst20",ROM0[$20]
  add l
  ld l, a
  ret c
  dec h
  ret

SECTION "rst28",ROM0[$28]
	add l
	ld l, a
	ret nc
	inc h
	ret

SECTION "rst30",ROM0[$30]
  add a
  rst $28
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ret

SECTION "rst38",ROM0[$38] ; Unused
	ld a, [hli]
	ld l, [hl]
	ld h, a
  ret
