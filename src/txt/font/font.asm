SECTION "Load Font", ROM0[$2d85]

LoadFont:
    ld a, 3
    call $12e8 ; Decompress
    ret
