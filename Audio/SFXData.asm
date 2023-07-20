section "SFX - Test",romx

SFX_Test:
    db  1<<DSFX_CH3WAVEVOL | 1<<DSFX_CH3FREQLO | 1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  %11000000 | 1
    db  $00
    db  $00
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $01
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $02
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $03
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $04
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $05
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $06
    db  4
    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
    db  $07
    db  4
    db  1<<DSFX_CH3WAVEVOL | 1<<DSFX_CH4ENV | 1<<DSFX_CH4FREQ | 1<<DSFX_CH4RESET | 1<<DSFX_DELAY
    db  %00000000
    db  $f1
    db  $56
    db  4
    db  1<<DSFX_CH4FREQ | 1<<DSFX_CH4RESET | 1<<DSFX_DELAY
    db  $69
    db  4
    db  1<<DSFX_END

section "SFX - Jump",romx
SFX_Jump:
    db %00000111
    db 192 | $F ; ch3 vol 0x3 + ch3 wave
    db 9 ; ch3 freq low 0x9
    db 7 ; ch3 freq high 0x7
    db %00000110
    db 217 ; ch3 freq low 0xd9
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 169 ; ch3 freq low 0xa9
    db %00000010
    db 185 ; ch3 freq low 0xb9
    db %00000010
    db 201 ; ch3 freq low 0xc9
    db %00000010
    db 217 ; ch3 freq low 0xd9
    db %00000010
    db 233 ; ch3 freq low 0xe9
    db %00000010
    db 249 ; ch3 freq low 0xf9
    db %00000110
    db 9 ; ch3 freq low 0x9
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 25 ; ch3 freq low 0x19
    db %00000010
    db 41 ; ch3 freq low 0x29
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 57 ; ch3 freq low 0x39
    db %00000010
    db 73 ; ch3 freq low 0x49
    db %00000010
    db 89 ; ch3 freq low 0x59
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 105 ; ch3 freq low 0x69
    db %00000010
    db 121 ; ch3 freq low 0x79
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX - Dash Loop",romx
SFX_DashLoop:
    db %00111000
    db 241 ; ch4 envelope 0xf1
    db $35 ; ch4 freq 0x55
    db %00010000
    db $25 ; ch4 freq 0x25
    db %00010000
    db $3f ; ch4 freq 0x3f
    db %00010000
    db $15 ; ch4 freq 0x15
    db %00010000
    db $12 ; ch4 freq 0x12
    db %01010000
    db $15 ; ch4 freq 0x15
    db 7
    db %10101000
    db 0 ; ch4 envelope 0x0

section "SFX - Skid",romx
SFX_Skid:
    db %00000111
    db 64 | $f ; ch3 vol 0x1 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 7 ; ch3 freq high 0x7
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX - Dash Into Wall",romx
SFX_DashWall:
    db %00111111
    db 192 | $f ; ch3 vol 0x3 + ch3 wave
    db 161 ; ch3 freq low 0xa1
    db 6 ; ch3 freq high 0x6
    db 160 ; ch4 envelope 0xa0
    db 39 ; ch4 freq 0x27
    db %00000010
    db 33 ; ch3 freq low 0x21
    db %00111010
    db 74 ; ch3 freq low 0x4a
    db 160 ; ch4 envelope 0xa0
    db 68 ; ch4 freq 0x44
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %00111010
    db 200 ; ch3 freq low 0xc8
    db 160 ; ch4 envelope 0xa0
    db 93 ; ch4 freq 0x5d
    db %00000010
    db 121 ; ch3 freq low 0x79
    db %00000010
    db 42 ; ch3 freq low 0x2a
    db %00111110
    db 219 ; ch3 freq low 0xdb
    db 5 ; ch3 freq high 0x5
    db 80 ; ch4 envelope 0x50
    db 93 ; ch4 freq 0x5d
    db %00000010
    db 140 ; ch3 freq low 0x8c
    db %00000110
    db 61 ; ch3 freq low 0x3d
    db 5 ; ch3 freq high 0x5
    db %00111110
    db 238 ; ch3 freq low 0xee
    db 4 ; ch3 freq high 0x4
    db 32 ; ch4 envelope 0x20
    db 93 ; ch4 freq 0x5d
    db %10111011
    db 0 | $f ; ch3 vol 0x0 + ch3 wave
    db 238 ; ch3 freq low 0xee
    db 0 ; ch4 envelope 0x0
    db 93 ; ch4 freq 0x5d