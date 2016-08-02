SECTION "Load Font", ROM0[$2d85]

LoadFont:
  ld a, 5 ;LoadFontDialogueAdvice
  rst $8
  nop
  nop
  ret

; TODO: Move below
SECTION "Unknown Section, loads font", ROMX[$4417], BANK[$1]
  nop
  nop
  ld a, 2 ; LoadFont_
  rst $8
SECTION "After battle won", ROMX[$4b30], BANK[$1]

; after battle won
  ld a, 2 ; LoadFont_
  rst $8

SECTION "On start menu", ROMX[$4038], BANK[$2]
  nop
  nop
  ld a, 2 ; LoadFont_
  rst $8

SECTION "When returning to menu from items", ROMX[$403d], BANK[$2]
; when returning to menu from items
  ld a, 2 ; LoadFont_
  rst $8

SECTION "When returning to menu", ROMX[$5c78], BANK[$2]
  ; when returning to menu
  nop
  nop
  ld a, 2 ; LoadFont_
  rst $8

SECTION "When returning to save screen", ROMX[$5c84], BANK[$2]
; when returning from save screen
  ld a, 2 ; LoadFont_
  rst $8

SECTION "On medarot choice selection", ROMX[$690B], BANK[$2]
  ; on medarot choice selection
    nop
    nop
    ld a, 3 ; LoadFont2
    rst $8
