;section "SFX - Test",romx
;SFX_Test:
;    db  1<<DSFX_CH3WAVEVOL | 1<<DSFX_CH3FREQLO | 1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  %11000000 | 1
;    db  $00
;    db  $00
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $01
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $02
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $03
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $04
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $05
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $06
;    db  4
;    db  1<<DSFX_CH3FREQHI | 1<<DSFX_DELAY
;    db  $07
;    db  4
;    db  1<<DSFX_CH3WAVEVOL | 1<<DSFX_CH4ENV | 1<<DSFX_CH4FREQ | 1<<DSFX_CH4RESET | 1<<DSFX_DELAY
;    db  %00000000
;    db  $f1
;    db  $56
;    db  4
;    db  1<<DSFX_CH4FREQ | 1<<DSFX_CH4RESET | 1<<DSFX_DELAY
;    db  $69
;    db  4
;    db  1<<DSFX_END

section "SFX - Jump",romx
SFX_Jump:
    db %00000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
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
    db 64 | $10 ; ch3 vol 0x1 + ch3 wave
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
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
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
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 238 ; ch3 freq low 0xee
    db 0 ; ch4 envelope 0x0
    db 93 ; ch4 freq 0x5d

section "SFX - Kill Enemy",romx
SFX_EnemyKill:
    db %00111111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db 32 ; ch4 envelope 0x20
    db 110 ; ch4 freq 0x6e
    db %00000010
    db 230 ; ch3 freq low 0xe6
    db %00000010
    db 214 ; ch3 freq low 0xd6
    db %00000010
    db 198 ; ch3 freq low 0xc6
    db %00111110
    db 118 ; ch3 freq low 0x76
    db 7 ; ch3 freq high 0x7
    db 64 ; ch4 envelope 0x40
    db 6 ; ch4 freq 0x6
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 37 ; ch4 freq 0x25
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db 52 ; ch4 freq 0x34
    db %00010010
    db 182 ; ch3 freq low 0xb6
    db 76 ; ch4 freq 0x4c
    db %00010010
    db 118 ; ch3 freq low 0x76
    db 77 ; ch4 freq 0x4d
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 93 ; ch4 freq 0x5d
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 5 ; ch3 freq high 0x5
    db 108 ; ch4 freq 0x6c
    db %00111111
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 118 ; ch3 freq low 0x76
    db 7 ; ch3 freq high 0x7
    db 48 ; ch4 envelope 0x30
    db 6 ; ch4 freq 0x6
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 37 ; ch4 freq 0x25
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db 52 ; ch4 freq 0x34
    db %00010010
    db 182 ; ch3 freq low 0xb6
    db 76 ; ch4 freq 0x4c
    db %00010010
    db 118 ; ch3 freq low 0x76
    db 77 ; ch4 freq 0x4d
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 93 ; ch4 freq 0x5d
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 5 ; ch3 freq high 0x5
    db 108 ; ch4 freq 0x6c
    db %00111111
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 118 ; ch3 freq low 0x76
    db 7 ; ch3 freq high 0x7
    db 16 ; ch4 envelope 0x10
    db 6 ; ch4 freq 0x6
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 37 ; ch4 freq 0x25
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db 52 ; ch4 freq 0x34
    db %00010010
    db 182 ; ch3 freq low 0xb6
    db 76 ; ch4 freq 0x4c
    db %00010010
    db 118 ; ch3 freq low 0x76
    db 77 ; ch4 freq 0x4d
    db %00010010
    db 54 ; ch3 freq low 0x36
    db 93 ; ch4 freq 0x5d
    db %00010110
    db 246 ; ch3 freq low 0xf6
    db 5 ; ch3 freq high 0x5
    db 108 ; ch4 freq 0x6c
    db %10101001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 0 ; ch4 envelope 0x0

section "SFX data - Break block",romx
SFX_BlockBreak:
    db %00111000
    db 240 ; ch4 envelope 0xf0
    db 31 ; ch4 freq 0x1f
    db %00110000
    db 23 ; ch4 freq 0x17
    db %00110000
    db 77 ; ch4 freq 0x4d
    db %00110000
    db 69 ; ch4 freq 0x45
    db %00111000
    db 224 ; ch4 envelope 0xe0
    db 46 ; ch4 freq 0x2e
    db %00110000
    db 38 ; ch4 freq 0x26
    db %00110000
    db 79 ; ch4 freq 0x4f
    db %00110000
    db 71 ; ch4 freq 0x47
    db %00111000
    db 64 ; ch4 envelope 0x40
    db 60 ; ch4 freq 0x3c
    db %00110000
    db 52 ; ch4 freq 0x34
    db %00110000
    db 92 ; ch4 freq 0x5c
    db %00110000
    db 84 ; ch4 freq 0x54
    db %00111000
    db 48 ; ch4 envelope 0x30
    db 63 ; ch4 freq 0x3f
    db %00110000
    db 55 ; ch4 freq 0x37
    db %00110000
    db 108 ; ch4 freq 0x6c
    db %00110000
    db 100 ; ch4 freq 0x64
    db %00111000
    db 32 ; ch4 envelope 0x20
    db 77 ; ch4 freq 0x4d
    db %00110000
    db 69 ; ch4 freq 0x45
    db %00110000
    db 110 ; ch4 freq 0x6e
    db %00110000
    db 102 ; ch4 freq 0x66
    db %00111000
    db 16 ; ch4 envelope 0x10
    db 79 ; ch4 freq 0x4f
    db %00110000
    db 71 ; ch4 freq 0x47
    db %00110000
    db 125 ; ch4 freq 0x7d
    db %00110000
    db 117 ; ch4 freq 0x75
    db %10101000
    db 0 ; ch4 envelope 0x0
    
section "SFX data - Emily ouch",romx
SFX_EmilyOuch:
    db %00000111
    db 192 | $11 ; ch3 vol 0x3 + ch3 wave
    db 134 ; ch3 freq low 0x86
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 153 ; ch3 freq low 0x99
    db %00000010
    db 172 ; ch3 freq low 0xac
    db %00000010
    db 191 ; ch3 freq low 0xbf
    db %00000010
    db 190 ; ch3 freq low 0xbe
    db %00000010
    db 189 ; ch3 freq low 0xbd
    db %00000010
    db 188 ; ch3 freq low 0xbc
    db %00000010
    db 187 ; ch3 freq low 0xbb
    db %00000010
    db 179 ; ch3 freq low 0xb3
    db %00000010
    db 171 ; ch3 freq low 0xab
    db %00000010
    db 163 ; ch3 freq low 0xa3
    db %00000010
    db 155 ; ch3 freq low 0x9b
    db %10000011
    db 0 | $10 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Collectable 1",romx
SFX_Collectable1:
    db %00000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db 7 ; ch3 freq high 0x7
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 219 ; ch3 freq low 0xdb
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 231 ; ch3 freq low 0xe7
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db %01000001
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 4
    db %01000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 3
    db %01000001
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 4
    db %10000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Collectable 2",romx
SFX_Collectable2:
    db %00000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 231 ; ch3 freq low 0xe7
    db 7 ; ch3 freq high 0x7
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db 2
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 226 ; ch3 freq low 0xe2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db 2
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 144 ; ch3 freq low 0x90
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 237 ; ch3 freq low 0xed
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 226 ; ch3 freq low 0xe2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db 2
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 237 ; ch3 freq low 0xed
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 226 ; ch3 freq low 0xe2
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db 2
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 237 ; ch3 freq low 0xed
    db %01000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 226 ; ch3 freq low 0xe2
    db %01000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 167 ; ch3 freq low 0xa7
    db 2
    db %10000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Collectable 3",romx
SFX_Collectable3:
    db %01000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 151 ; ch3 freq low 0x97
    db 7 ; ch3 freq high 0x7
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 45 ; ch3 freq low 0x2d
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 151 ; ch3 freq low 0x97
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 2
    db %01000011
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 151 ; ch3 freq low 0x97
    db 3
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %01000011
    db 128 | $10 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 3
    db %01000011
    db 128 | $7 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %01000011
    db 128 | $10 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 128 | $7 ; ch3 vol 0x2 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 2
    db %01000011
    db 128 | $10 ; ch3 vol 0x2 + ch3 wave
    db 151 ; ch3 freq low 0x97
    db 3
    db %01000011
    db 128 | $7 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %01000011
    db 64 | $10 ; ch3 vol 0x1 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 3
    db %01000011
    db 64 | $7 ; ch3 vol 0x1 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 2
    db %01000011
    db 64 | $10 ; ch3 vol 0x1 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 64 | $7 ; ch3 vol 0x1 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 2
    db %01000011
    db 64 | $10 ; ch3 vol 0x1 + ch3 wave
    db 151 ; ch3 freq low 0x97
    db 3
    db %01000011
    db 64 | $7 ; ch3 vol 0x1 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Collectable 4",romx
SFX_Collectable4:
        db %01000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 131 ; ch3 freq low 0x83
    db 7 ; ch3 freq high 0x7
    db 3
    db %00000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db %01000011
    db 192 | $f ; ch3 vol 0x3 + ch3 wave
    db 157 ; ch3 freq low 0x9d
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 131 ; ch3 freq low 0x83
    db %01000011
    db 192 | $e ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 157 ; ch3 freq low 0x9d
    db %01000011
    db 192 | $e ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db %01000011
    db 192 | $d ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %01000011
    db 192 | $c ; ch3 vol 0x3 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %01000011
    db 192 | $c ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db %01000011
    db 192 | $b ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %01000011
    db 192 | $a ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %01000011
    db 192 | $a ; ch3 vol 0x3 + ch3 wave
    db 157 ; ch3 freq low 0x9d
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db %01000011
    db 192 | $9 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 157 ; ch3 freq low 0x9d
    db %01000011
    db 192 | $8 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db %01000011
    db 192 | $8 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %01000011
    db 192 | $7 ; ch3 vol 0x3 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %01000011
    db 192 | $6 ; ch3 vol 0x3 + ch3 wave
    db 219 ; ch3 freq low 0xdb
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db %01000011
    db 192 | $6 ; ch3 vol 0x3 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 219 ; ch3 freq low 0xdb
    db %01000011
    db 192 | $5 ; ch3 vol 0x3 + ch3 wave
    db 219 ; ch3 freq low 0xdb
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db %01000011
    db 192 | $4 ; ch3 vol 0x3 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 219 ; ch3 freq low 0xdb
    db %01000011
    db 192 | $4 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 209 ; ch3 freq low 0xd1
    db %01000011
    db 192 | $3 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db %01000011
    db 192 | $2 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db %01000011
    db 0 | $2 ; ch3 vol 0x0 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %10000001
    db 0 | 0

section "SFX data - Emily transform",romx
SFX_EmilyTransform:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 202 ; ch3 freq low 0xca
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 211 ; ch3 freq low 0xd3
    db %00000010
    db 220 ; ch3 freq low 0xdc
    db %00000010
    db 229 ; ch3 freq low 0xe5
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 192 ; ch3 freq low 0xc0
    db %00000010
    db 202 ; ch3 freq low 0xca
    db %00000010
    db 212 ; ch3 freq low 0xd4
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 178 ; ch3 freq low 0xb2
    db %00000010
    db 189 ; ch3 freq low 0xbd
    db %00000010
    db 200 ; ch3 freq low 0xc8
    db %00000010
    db 211 ; ch3 freq low 0xd3
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 163 ; ch3 freq low 0xa3
    db %00000010
    db 175 ; ch3 freq low 0xaf
    db %00000010
    db 187 ; ch3 freq low 0xbb
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 144 ; ch3 freq low 0x90
    db %00000010
    db 157 ; ch3 freq low 0x9d
    db %00000010
    db 170 ; ch3 freq low 0xaa
    db %00000010
    db 183 ; ch3 freq low 0xb7
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 121 ; ch3 freq low 0x79
    db %00000010
    db 135 ; ch3 freq low 0x87
    db %00000010
    db 149 ; ch3 freq low 0x95
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 94 ; ch3 freq low 0x5e
    db %00000010
    db 109 ; ch3 freq low 0x6d
    db %00000010
    db 124 ; ch3 freq low 0x7c
    db %00000010
    db 139 ; ch3 freq low 0x8b
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 61 ; ch3 freq low 0x3d
    db %00000010
    db 77 ; ch3 freq low 0x4d
    db %00000010
    db 93 ; ch3 freq low 0x5d
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 23 ; ch3 freq low 0x17
    db %00000010
    db 40 ; ch3 freq low 0x28
    db %00000010
    db 57 ; ch3 freq low 0x39
    db %00000010
    db 74 ; ch3 freq low 0x4a
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 232 ; ch3 freq low 0xe8
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 250 ; ch3 freq low 0xfa
    db %00000110
    db 12 ; ch3 freq low 0xc
    db 7 ; ch3 freq high 0x7
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 177 ; ch3 freq low 0xb1
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 196 ; ch3 freq low 0xc4
    db %00000010
    db 215 ; ch3 freq low 0xd7
    db %00000010
    db 234 ; ch3 freq low 0xea
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 111 ; ch3 freq low 0x6f
    db %00000010
    db 131 ; ch3 freq low 0x83
    db %00000010
    db 151 ; ch3 freq low 0x97
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 174 ; ch3 freq low 0xae
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 128 | 1 ; ch3 vol 0x2 + ch3 wave
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %00000011
    db 64 | 1 ; ch3 vol 0x1 + ch3 wave
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000010
    db 158 ; ch3 freq low 0x9e
    db %00000010
    db 166 ; ch3 freq low 0xa6
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 182 ; ch3 freq low 0xb6
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily detransform",romx
SFX_EmilyDetransform:
    db %00000111
    db 192 | $11 ; ch3 vol 0x3 + ch3 wave
    db 159 ; ch3 freq low 0x9f
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 189 ; ch3 freq low 0xbd
    db %00000010
    db 174 ; ch3 freq low 0xae
    db %00000010
    db 159 ; ch3 freq low 0x9f
    db %00000010
    db 144 ; ch3 freq low 0x90
    db %00000010
    db 129 ; ch3 freq low 0x81
    db %00000010
    db 114 ; ch3 freq low 0x72
    db %00000010
    db 99 ; ch3 freq low 0x63
    db %00000010
    db 84 ; ch3 freq low 0x54
    db %01000011
    db 192 | $d ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 89 ; ch3 freq low 0x59
    db 2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 144 ; ch3 freq low 0x90
    db 3
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 3
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 144 ; ch3 freq low 0x90
    db 2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 3
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 172 ; ch3 freq low 0xac
    db 2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 200 ; ch3 freq low 0xc8
    db 3
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 190 ; ch3 freq low 0xbe
    db 2
    db %01000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 214 ; ch3 freq low 0xd6
    db 3
    db %01000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 214 ; ch3 freq low 0xd6
    db 2
    db %01000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 214 ; ch3 freq low 0xd6
    db 3
    db %01000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 214 ; ch3 freq low 0xd6
    db 2
    db %01000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 214 ; ch3 freq low 0xd6
    db 3
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wav

section "SFX data - Emily werewolf howl",romx
SFX_EmilyWerewolfHowl:
    db %00000111
    db 192 | $11 ; ch3 vol 0x3 + ch3 wave
    db 110 ; ch3 freq low 0x6e
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 113 ; ch3 freq low 0x71
    db %00000010
    db 116 ; ch3 freq low 0x74
    db %00000010
    db 119 ; ch3 freq low 0x77
    db %00000010
    db 122 ; ch3 freq low 0x7a
    db %00000010
    db 127 ; ch3 freq low 0x7f
    db %00000010
    db 132 ; ch3 freq low 0x84
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %00000010
    db 142 ; ch3 freq low 0x8e
    db %00000010
    db 147 ; ch3 freq low 0x93
    db %00000010
    db 152 ; ch3 freq low 0x98
    db %00000010
    db 157 ; ch3 freq low 0x9d
    db %01000010
    db 162 ; ch3 freq low 0xa2
    db 23
    db %01000010
    db 161 ; ch3 freq low 0xa1
    db 5
    db %01000010
    db 160 ; ch3 freq low 0xa0
    db 5
    db %01000010
    db 159 ; ch3 freq low 0x9f
    db 5
    db %01000010
    db 158 ; ch3 freq low 0x9e
    db 5
    db %01000010
    db 157 ; ch3 freq low 0x9d
    db 5
    db %01000010
    db 156 ; ch3 freq low 0x9c
    db 5
    db %01000010
    db 155 ; ch3 freq low 0x9b
    db 5
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 155 ; ch3 freq low 0x9b
    db %00000010
    db 153 ; ch3 freq low 0x99
    db %00000010
    db 151 ; ch3 freq low 0x97
    db %00000010
    db 149 ; ch3 freq low 0x95
    db %00000010
    db 147 ; ch3 freq low 0x93
    db %00000010
    db 145 ; ch3 freq low 0x91
    db %00000010
    db 143 ; ch3 freq low 0x8f
    db %00000010
    db 141 ; ch3 freq low 0x8d
    db %00000010
    db 139 ; ch3 freq low 0x8b
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 155 ; ch3 freq low 0x9b
    db %00000010
    db 153 ; ch3 freq low 0x99
    db %00000010
    db 151 ; ch3 freq low 0x97
    db %00000010
    db 149 ; ch3 freq low 0x95
    db %00000010
    db 147 ; ch3 freq low 0x93
    db %00000010
    db 145 ; ch3 freq low 0x91
    db %00000010
    db 143 ; ch3 freq low 0x8f
    db %00000010
    db 141 ; ch3 freq low 0x8d
    db %00000010
    db 139 ; ch3 freq low 0x8b
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 155 ; ch3 freq low 0x9b
    db %00000010
    db 153 ; ch3 freq low 0x99
    db %00000010
    db 151 ; ch3 freq low 0x97
    db %00000010
    db 149 ; ch3 freq low 0x95
    db %00000010
    db 147 ; ch3 freq low 0x93
    db %00000010
    db 145 ; ch3 freq low 0x91
    db %00000010
    db 143 ; ch3 freq low 0x8f
    db %00000010
    db 141 ; ch3 freq low 0x8d
    db %00000010
    db 139 ; ch3 freq low 0x8b
    db %00000010
    db 137 ; ch3 freq low 0x89
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Throwing object",romx
SFX_EnemyThrow:
    db %00000111
    db 128 | 1 ; ch3 vol 0x2 + ch3 wave
    db 147 ; ch3 freq low 0x93
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 163 ; ch3 freq low 0xa3
    db %00000010
    db 179 ; ch3 freq low 0xb3
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 195 ; ch3 freq low 0xc3
    db %00000010
    db 211 ; ch3 freq low 0xd3
    db %00000010
    db 209 ; ch3 freq low 0xd1
    db %00000010
    db 207 ; ch3 freq low 0xcf
    db %00000010
    db 205 ; ch3 freq low 0xcd
    db %00000010
    db 203 ; ch3 freq low 0xcb
    db %00000010
    db 201 ; ch3 freq low 0xc9
    db %00000010
    db 199 ; ch3 freq low 0xc7
    db %00000010
    db 197 ; ch3 freq low 0xc5
    db %00000010
    db 195 ; ch3 freq low 0xc3
    db %00000010
    db 193 ; ch3 freq low 0xc1
    db %00000010
    db 191 ; ch3 freq low 0xbf
    db %00000010
    db 189 ; ch3 freq low 0xbd
    db %00000010
    db 187 ; ch3 freq low 0xbb
    db %00000010
    db 185 ; ch3 freq low 0xb9
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 183 ; ch3 freq low 0xb7
    db %00000010
    db 181 ; ch3 freq low 0xb5
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 179 ; ch3 freq low 0xb3
    db %00000010
    db 177 ; ch3 freq low 0xb1
    db %00000010
    db 175 ; ch3 freq low 0xaf
    db %10000001
    db 0 | 0  ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily coffee steam whistle",romx
SFX_EmilyCoffeeSteam:
    db %00111111
    db 128 | 1 ; ch3 vol 0x2 + ch3 wave
    db 191 ; ch3 freq low 0xbf
    db 7 ; ch3 freq high 0x7
    db 128 ; ch4 envelope 0x80
    db 1 ; ch4 freq 0x1
    db %00000010
    db 192 ; ch3 freq low 0xc0
    db %00000010
    db 193 ; ch3 freq low 0xc1
    db %00111011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 194 ; ch3 freq low 0xc2
    db 208 ; ch4 envelope 0xd0
    db 1 ; ch4 freq 0x1
    db %00000010
    db 195 ; ch3 freq low 0xc3
    db %00000010
    db 196 ; ch3 freq low 0xc4
    db %00000010
    db 197 ; ch3 freq low 0xc5
    db %00000010
    db 198 ; ch3 freq low 0xc6
    db %00000010
    db 199 ; ch3 freq low 0xc7
    db %00000010
    db 200 ; ch3 freq low 0xc8
    db %00111010
    db 201 ; ch3 freq low 0xc9
    db 176 ; ch4 envelope 0xb0
    db 1 ; ch4 freq 0x1
    db %00000010
    db 202 ; ch3 freq low 0xca
    db %00000010
    db 203 ; ch3 freq low 0xcb
    db %00000010
    db 204 ; ch3 freq low 0xcc
    db %00000010
    db 205 ; ch3 freq low 0xcd
    db %01111000
    db 144 ; ch4 envelope 0x90
    db 1 ; ch4 freq 0x1
    db 15
    db %01000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 8
    db %01000001
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 2
    db %10101001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 8 ; ch4 envelope 0x8

section "SFX - Emily coffee run",romx
SFX_EmilyCoffeeRun:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 165 ; ch3 freq low 0xa5
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 173 ; ch3 freq low 0xad
    db %00000010
    db 181 ; ch3 freq low 0xb5
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 189 ; ch3 freq low 0xbd
    db %00000010
    db 197 ; ch3 freq low 0xc5
    db %00000011
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 198 ; ch3 freq low 0xc6
    db %00000010
    db 206 ; ch3 freq low 0xce
    db %00000010
    db 214 ; ch3 freq low 0xd6
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily coffee bump into wall",romx
SFX_EmilyCoffeeBump:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 97 ; ch3 freq low 0x61
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 1 ; ch3 freq low 0x1
    db %00000110
    db 161 ; ch3 freq low 0xa1
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 209 ; ch3 freq low 0xd1
    db %00000110
    db 1 ; ch3 freq low 0x1
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 49 ; ch3 freq low 0x31
    db %00000010
    db 97 ; ch3 freq low 0x61
    db %00000010
    db 145 ; ch3 freq low 0x91
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Enemy stunned",romx
SFX_EnemyStun:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 129 ; ch3 freq low 0x81
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 120 ; ch3 freq low 0x78
    db %00000011
    db 0 | 1 ; ch3 vol 0x0 + ch3 wave
    db 120 ; ch3 freq low 0x78
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 171 ; ch3 freq low 0xab
    db %00000010
    db 175 ; ch3 freq low 0xaf
    db %10000001
    db 0 | 1 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Enemy bump",romx
SFX_EnemyBump:
    db %00000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 7 ; ch3 freq low 0x7
    db 6 ; ch3 freq high 0x6
    db %00000110
    db 8 ; ch3 freq low 0x8
    db 5 ; ch3 freq high 0x5
    db %00000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 8 ; ch3 freq low 0x8
    db %00000111
    db 192 | 0 ; ch3 vol 0x3 + ch3 wave
    db 88 ; ch3 freq low 0x58
    db 7 ; ch3 freq high 0x7
    db %00000110
    db 232 ; ch3 freq low 0xe8
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 120 ; ch3 freq low 0x78
    db %01000011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 120 ; ch3 freq low 0x78
    db 6
    db %00000111
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 88 ; ch3 freq low 0x58
    db 7 ; ch3 freq high 0x7
    db %00000110
    db 232 ; ch3 freq low 0xe8
    db 6 ; ch3 freq high 0x6
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Megaton walk",romx
SFX_MegatonWalk:
    db %01111000
    db 240 ; ch4 envelope 0xf0
    db 109 ; ch4 freq 0x6d
    db 5
    db %01111000
    db 32 ; ch4 envelope 0x20
    db 109 ; ch4 freq 0x6d
    db 5
    db %10101000
    db 0 ; ch4 envelope 0x0

section "SFX data - Megaton land",romx
SFX_MegatonLand:
    db %00111111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 150 ; ch3 freq low 0x96
    db 6 ; ch3 freq high 0x6
    db 240 ; ch4 envelope 0xf0
    db 93 ; ch4 freq 0x5d
    db %00000010
    db 38 ; ch3 freq low 0x26
    db %00000110
    db 182 ; ch3 freq low 0xb6
    db 5 ; ch3 freq high 0x5
    db %00010010
    db 70 ; ch3 freq low 0x46
    db 108 ; ch4 freq 0x6c
    db %00000110
    db 214 ; ch3 freq low 0xd6
    db 4 ; ch3 freq high 0x4
    db %00000010
    db 102 ; ch3 freq low 0x66
    db %01111011
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 102 ; ch3 freq low 0x66
    db 32 ; ch4 envelope 0x20
    db 20 ; ch4 freq 0x14
    db 3
    db %01111000
    db 64 ; ch4 envelope 0x40
    db 108 ; ch4 freq 0x6c
    db 3
    db %10101000
    db 0 ; ch4 envelope 0x8

section "SFX data - Megaton jump",romx
SFX_MegatonJump:
    db %00000111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 186 ; ch3 freq low 0xba
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 194 ; ch3 freq low 0xc2
    db %00000010
    db 202 ; ch3 freq low 0xca
    db %00000010
    db 210 ; ch3 freq low 0xd2
    db %00000010
    db 218 ; ch3 freq low 0xda
    db %00000010
    db 226 ; ch3 freq low 0xe2
    db %00000010
    db 234 ; ch3 freq low 0xea
    db %00000010
    db 242 ; ch3 freq low 0xf2
    db %00000010
    db 250 ; ch3 freq low 0xfa
    db %00000110
    db 2 ; ch3 freq low 0x2
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 10 ; ch3 freq low 0xa
    db %00000010
    db 18 ; ch3 freq low 0x12
    db %00000010
    db 26 ; ch3 freq low 0x1a
    db %00000010
    db 34 ; ch3 freq low 0x22
    db %00000010
    db 42 ; ch3 freq low 0x2a
    db %00000010
    db 50 ; ch3 freq low 0x32
    db %00000010
    db 58 ; ch3 freq low 0x3a
    db %00000010
    db 66 ; ch3 freq low 0x42
    db %00000011
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 28 ; ch3 freq low 0x1c
    db %00000010
    db 36 ; ch3 freq low 0x24
    db %00000010
    db 44 ; ch3 freq low 0x2c
    db %00000010
    db 52 ; ch3 freq low 0x34
    db %00000010
    db 60 ; ch3 freq low 0x3c
    db %00000010
    db 68 ; ch3 freq low 0x44
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 28 ; ch3 freq low 0x1c
    db %00000010
    db 36 ; ch3 freq low 0x24
    db %00000010
    db 44 ; ch3 freq low 0x2c
    db %00000010
    db 52 ; ch3 freq low 0x34
    db %00000010
    db 60 ; ch3 freq low 0x3c
    db %00000010
    db 68 ; ch3 freq low 0x44
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Megaton slam",romx
SFX_MegatonSlam:
    db %00111111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 19 ; ch3 freq low 0x13
    db 7 ; ch3 freq high 0x7
    db 240 ; ch4 envelope 0xf0
    db 76 ; ch4 freq 0x4c
    db %00000110
    db 163 ; ch3 freq low 0xa3
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 51 ; ch3 freq low 0x33
    db %00000110
    db 195 ; ch3 freq low 0xc3
    db 5 ; ch3 freq high 0x5
    db %00111010
    db 83 ; ch3 freq low 0x53
    db 224 ; ch4 envelope 0xe0
    db 93 ; ch4 freq 0x5d
    db %00000110
    db 227 ; ch3 freq low 0xe3
    db 4 ; ch3 freq high 0x4
    db %00000010
    db 115 ; ch3 freq low 0x73
    db %00000010
    db 3 ; ch3 freq low 0x3
    db %00111111
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 147 ; ch3 freq low 0x93
    db 3 ; ch3 freq high 0x3
    db 192 ; ch4 envelope 0xc0
    db 94 ; ch4 freq 0x5e
    db %00000010
    db 35 ; ch3 freq low 0x23
    db %00000110
    db 179 ; ch3 freq low 0xb3
    db 2 ; ch3 freq high 0x2
    db %00000010
    db 67 ; ch3 freq low 0x43
    db %00111110
    db 211 ; ch3 freq low 0xd3
    db 1 ; ch3 freq high 0x1
    db 160 ; ch4 envelope 0xa0
    db 95 ; ch4 freq 0x5f
    db %00000010
    db 99 ; ch3 freq low 0x63
    db %00000110
    db 243 ; ch3 freq low 0xf3
    db 0 ; ch3 freq high 0x0
    db %00000010
    db 131 ; ch3 freq low 0x83
    db %00111011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 19 ; ch3 freq low 0x13
    db 128 ; ch4 envelope 0x80
    db 94 ; ch4 freq 0x5e
    db %01000010
    db 1 ; ch3 freq low 0x1
    db 2
    db %01111010
    db 1 ; ch3 freq low 0x1
    db 96 ; ch4 envelope 0x60
    db 94 ; ch4 freq 0x5e
    db 3
    db %01111001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 64 ; ch4 envelope 0x40
    db 94 ; ch4 freq 0x5e
    db 4
    db %01111000
    db 32 ; ch4 envelope 0x20
    db 94 ; ch4 freq 0x5e
    db 4
    db %01111000
    db 16 ; ch4 envelope 0x10
    db 94 ; ch4 freq 0x5e
    db 4
    db %10101000
    db 0 ; ch4 envelope 0x8

section "SFX data - Bubble",romx
SFX_Bubble:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 210 ; ch3 freq low 0xd2
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 242 ; ch3 freq low 0xf2
    db %00000110
    db 18 ; ch3 freq low 0x12
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 50 ; ch3 freq low 0x32
    db %00000011
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 82 ; ch3 freq low 0x52
    db %00000010
    db 114 ; ch3 freq low 0x72
    db %00000010
    db 146 ; ch3 freq low 0x92
    db %00000010
    db 178 ; ch3 freq low 0xb2
    db %00000111
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 210 ; ch3 freq low 0xd2
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 242 ; ch3 freq low 0xf2
    db %00000110
    db 18 ; ch3 freq low 0x12
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 50 ; ch3 freq low 0x32
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily swim",romx
SFX_EmilySwim:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 36 ; ch3 freq low 0x24
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 4 ; ch3 freq low 0x4
    db %00000110
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db %00000110
    db 22 ; ch3 freq low 0x16
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 54 ; ch3 freq low 0x36
    db %00000010
    db 86 ; ch3 freq low 0x56
    db %00000010
    db 118 ; ch3 freq low 0x76
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %00000110
    db 246 ; ch3 freq low 0xf6
    db 6 ; ch3 freq high 0x6
    db %00000110
    db 22 ; ch3 freq low 0x16
    db 7 ; ch3 freq high 0x7
    db %00000010
    db 54 ; ch3 freq low 0x36
    db %00000010
    db 86 ; ch3 freq low 0x56
    db %00000010
    db 118 ; ch3 freq low 0x76
    db %00000010
    db 150 ; ch3 freq low 0x96
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily crab walk",romx
SFX_EmilyCrabWalk:
    db %00000111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 197 ; ch3 freq low 0xc5
    db 7 ; ch3 freq high 0x7
    db %00000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db %00000001
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db %00000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 212 ; ch3 freq low 0xd4
    db %00000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db %00000001
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db %00000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db %00000011
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 197 ; ch3 freq low 0xc5
    db %00000001
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db %00000001
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave

section "SFX data - Emily crab attack",romx
SFX_EmilyCrabAttack:
    db %01111000
    db 241 ; ch4 envelope 0xf1
    db 44 ; ch4 freq 0x2c
    db 6
    db %01010000
    db 76 ; ch4 freq 0x4c
    db 6
    db %10101000
    db 0 ; ch4 envelope 0x0

section "SFX data - Emily charge",romx
SFX_EmilyCharge:
    db %00111111
    db 192 | 1 ; ch3 vol 0x3 + ch3 wave
    db 22 ; ch3 freq low 0x16
    db 7 ; ch3 freq high 0x7
    db 128 ; ch4 envelope 0x80
    db 124 ; ch4 freq 0x7c
    db %00000010
    db 38 ; ch3 freq low 0x26
    db %00111010
    db 54 ; ch3 freq low 0x36
    db 112 ; ch4 envelope 0x70
    db 108 ; ch4 freq 0x6c
    db %00000010
    db 70 ; ch3 freq low 0x46
    db %00111010
    db 86 ; ch3 freq low 0x56
    db 96 ; ch4 envelope 0x60
    db 93 ; ch4 freq 0x5d
    db %00000010
    db 102 ; ch3 freq low 0x66
    db %00111010
    db 105 ; ch3 freq low 0x69
    db 80 ; ch4 envelope 0x50
    db 79 ; ch4 freq 0x4f
    db %00000010
    db 121 ; ch3 freq low 0x79
    db %00111010
    db 137 ; ch3 freq low 0x89
    db 96 ; ch4 envelope 0x60
    db 76 ; ch4 freq 0x4c
    db %00000010
    db 153 ; ch3 freq low 0x99
    db %00111010
    db 169 ; ch3 freq low 0xa9
    db 112 ; ch4 envelope 0x70
    db 62 ; ch4 freq 0x3e
    db %00000010
    db 185 ; ch3 freq low 0xb9
    db %00111010
    db 147 ; ch3 freq low 0x93
    db 128 ; ch4 envelope 0x80
    db 60 ; ch4 freq 0x3c
    db %00000010
    db 163 ; ch3 freq low 0xa3
    db %00111010
    db 179 ; ch3 freq low 0xb3
    db 144 ; ch4 envelope 0x90
    db 47 ; ch4 freq 0x2f
    db %00000010
    db 195 ; ch3 freq low 0xc3
    db %00101010
    db 211 ; ch3 freq low 0xd3
    db 8 ; ch4 envelope 0x8
    db %00000010
    db 227 ; ch3 freq low 0xe3
    db %10000001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
 
section "SFX data - Poof",romx
SFX_Poof:
    db %00111111
    db 192 | $10 ; ch3 vol 0x3 + ch3 wave
    db 161 ; ch3 freq low 0xa1
    db 7 ; ch3 freq high 0x7
    db 241 ; ch4 envelope 0xf1
    db 20 ; ch4 freq 0x14
    db %00000010
    db 129 ; ch3 freq low 0x81
    db %00000010
    db 97 ; ch3 freq low 0x61
    db %00000010
    db 65 ; ch3 freq low 0x41
    db %00000010
    db 33 ; ch3 freq low 0x21
    db %00000010
    db 1 ; ch3 freq low 0x1
    db %00000111
    db 128 | 0 ; ch3 vol 0x2 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db 6 ; ch3 freq high 0x6
    db %00000010
    db 193 ; ch3 freq low 0xc1
    db %00000010
    db 161 ; ch3 freq low 0xa1
    db %00000010
    db 129 ; ch3 freq low 0x81
    db %00000010
    db 97 ; ch3 freq low 0x61
    db %00000010
    db 65 ; ch3 freq low 0x41
    db %00000010
    db 33 ; ch3 freq low 0x21
    db %00000010
    db 1 ; ch3 freq low 0x1
    db %00000111
    db 64 | 0 ; ch3 vol 0x1 + ch3 wave
    db 225 ; ch3 freq low 0xe1
    db 5 ; ch3 freq high 0x5
    db %00000010
    db 193 ; ch3 freq low 0xc1
    db %10101001
    db 0 | 0 ; ch3 vol 0x0 + ch3 wave
    db 0 ; ch4 envelope 0x8
    

