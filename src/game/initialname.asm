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
  ld hl, $c6a2
  ld a, $9a
  ld [hli], a
  ld a, $85
  ld [hli], a
  ld a, $a8
  ld [hli], a
  ld a, $50
  ld [hli], a
  xor a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld a, $3
  ld [$c5ce], a
  ld a, $2
  call $015f
  ld a, $3
  call $015f
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
  ld hl, $c6a2
  ld bc, $984a
  call $0264
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
