;The actual dialog text banks

SECTION "Dialog Text Tables", ROM0[$1d3b]
TextTableBanks: ; 0x1d3b
    db $25 ;Snippet 1
    db $26 ;Snippet 2
    db $27 ;Snippet 3
    db $28 ;Snippet 4
    db $20 ;StoryText 1
    db $29 ;Snippet 5
    db $00
    db $00
    db $22 ;Story Text 2
    db $00
    db $23 ;Story Text 3
    db $00
    db $00
    db $21 ;Battle Text
    db $00
    db $00

TextTableOffsets: ; 0x1d4b
    dw $4000 ;Snippet 1
    dw $4000 ;Snippet 2
    dw $4000 ;Snippet 3
    dw $4000 ;Snippet 4
    dw $4000 ;Story Text 1
    dw $4000 ;Snippet 5
    dw $4000
    dw $4000
    dw $4000 ;Story Text 2
    dw $4000
    dw $4000 ;Story Text 3
    dw $4000
    dw $4000
    dw $4000 ;Battle Text
    dw $4000
    dw $4000
