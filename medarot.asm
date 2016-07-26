INCLUDE "src/core/constants/macros.asm"
INCLUDE "src/core/constants/gbhw.asm"

INCLUDE "src/core/rst.asm"

INCLUDE "src/hardware/hw.asm"

INCLUDE "src/gfx/vram.asm"

INCLUDE "src/txt/dialog/special.asm"
INCLUDE "src/txt/dialog/char.asm"
INCLUDE "src/txt/dialog/text.asm"
INCLUDE "src/txt/font/font.asm"

;SECTION "romheader", ROM0[$100]

SECTION "start", ROM0[$150]
