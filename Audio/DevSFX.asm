; ================================================================
; DevSFX sound effect engine
; Copyright (c) 2023 DevEd
;
; Permission is hereby granted, free of charge, to any person obtaining
; a copy of this software and associated documentation files (the
; "Software"), to deal in the Software without restriction, including
; without limitation the rights to use, copy, modify, merge, publish,
; distribute, sublicense, and/or sell copies of the Software, and to
; permit persons to whom the Software is furnished to do so, subject to
; the following conditions:
; 
; The above copyright notice and this permission notice shall be included
; in all copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
; ================================================================

; SFX format
; Byte 1 - Flags
;   Bit 0 - CH3 wave + volume
;   Bit 1 = CH3 frequency low
;   Bit 2 = CH3 frequency hi
;   Bit 3 = CH4 envelope
;   Bit 4 = CH4 frequency
;   Bit 5 = CH4 reset
;   Bit 6 = delay > 1 tick
;   Bit 7 = sequence ends
; IF BIT 0: CH3 waveform + volume (1 byte)
;   VVWWWWWW - VV = Volume (0-3)   WWWWWW = Waveform (up to $3E, $3F = no change)
; IF BIT 1: CH3 frequency low byte
; IF BIT 2: CH3 frequency high byte
; IF BIT 3: CH4 volume envelope (raw NR42 envelope value; 1 byte)
; IF BIT 4: CH4 frequency (raw NR43 value; 1 byte)
; IF BIT 6: Delay (1 byte)

section "DevSFX RAM",wram0
DSFX_Flags:         db
DSFX_Delay:         db
DSFX_CH3LastFreqHi: db
DSFX_Bank:          db
DSFX_Pointer:       dw

DSFX_CH3        = 0
DSFX_CH4        = 1
DSFX_PLAYING    = 7

DSFX_CH3WAVEVOL = 0
DSFX_CH3FREQLO  = 1
DSFX_CH3FREQHI  = 2
DSFX_CH4ENV     = 3
DSFX_CH4FREQ    = 4
DSFX_CH4RESET   = 5
DSFX_DELAY      = 6
DSFX_END        = 7

section "DevSFX routines",rom0

; INPUT: hl = pointer
;         b = bank
DSFX_PlaySFX:
    ld      a,b
    ld      [DSFX_Bank],a
    xor     a
    ld      [DSFX_CH3LastFreqHi],a
    inc     a
    ld      [DSFX_Delay],a
    ld      a,1<<DSFX_PLAYING
    ld      [DSFX_Flags],a
    ld      a,l
    ld      [DSFX_Pointer],a
    ld      a,h
    ld      [DSFX_Pointer+1],a
    ret

DSFX_Update:    
    ld      a,[DSFX_Flags]
    bit     DSFX_PLAYING,a
    ret     z
    ld      hl,DSFX_Delay
    dec     [hl]
    ret     nz
    inc     [hl]
    ld      a,[DSFX_Bank]
    ld      b,a
    rst     Bankswitch
    
    ld      hl,DSFX_Pointer
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a

    ld      a,[hl+]
    ld      e,a
    
    rr      e
    call    c,.ch3wavevol
    rr      e
    call    c,.ch3freqlo
    rr      e
    call    c,.ch3freqhi
    rr      e
    call    c,.ch4env
    rr      e
    call    c,.ch4freq
    rr      e
    call    c,.ch4reset
    rr      e
    call    c,.setdelay
    rr      e
    call    c,.end
    resbank
    ld      a,l
    ld      [DSFX_Pointer],a
    ld      a,h
    ld      [DSFX_Pointer+1],a
    ret

.ch3wavevol
    ld      a,[hl+]
    ld      d,a
    and     $3f
    jr      z,.skipwave
    dec     a
    push    hl
    ld      l,a
    ld      h,0
    add     hl,hl   ; x2
    add     hl,hl   ; x4
    add     hl,hl   ; x8
    add     hl,hl   ; x16
    ld      b,h
    ld      c,l
    ld      hl,DSFX_Waves
    add     hl,bc
    ldh     a,[rNR51]
    and     %10111011
    ldh     [rNR51],a
    xor     a
    ld      [rNR30],a
    def     n = 0
    rept    16
    ld      a,[hl+]
    ld      [$ff30+n],a
    def     n = n + 1
    endr
    ld      a,%10000000
    ldh     [rNR30],a
    or      %01111111
    ldh     [rNR51],a
    ld      a,[DSFX_CH3LastFreqHi]
    set     7,a
    ldh     [rNR34],a
    pop     hl
.skipwave
    ld      a,d ; A = VV??????
    swap    a   ; A = ????VV??
    rra         ; A = ?????VV?
    rra         ; A = ??????VV
    and     3   ; A = 000000VV
    push    hl
    ld      hl,.wavevols
    add     l
    ld      l,a
    jr      nc,:+
    inc     hl
:   ld      a,[hl]
    pop     hl
    ldh     [rNR32],a
    and     a
    ld      a,[DSFX_Flags]
    jr      nz,:+
    res     DSFX_CH3,a
    ld      [DSFX_Flags],a
    ret
:   or      1<<DSFX_CH3
    ld      [DSFX_Flags],a
    ret
.wavevols
    db      $00,$60,$40,$20
    
.ch3freqlo
    ld      a,[hl+]
    ldh     [rNR33],a
    ld      a,[DSFX_Flags]
    or      1<<DSFX_CH3
    ld      [DSFX_Flags],a
    ret

.ch3freqhi
    ld      a,[hl+]
    and     $7
    ld      [DSFX_CH3LastFreqHi],a
    ldh     [rNR34],a
    ld      a,[DSFX_Flags]
    or      1<<DSFX_CH3
    ld      [DSFX_Flags],a
    ret

.ch4env
    ld      a,[hl+]
    ldh     [rNR42],a
    and     a
    ld      a,[DSFX_Flags]
    jr      nz,:+
    res     DSFX_CH4,a
    ld      [DSFX_Flags],a
    ret
:   or      1<<DSFX_CH4
    ld      [DSFX_Flags],a
    ret

.ch4freq
    ld      a,[hl+]
    ldh     [rNR43],a
    ld      a,[DSFX_Flags]
    or      1<<DSFX_CH4
    ld      [DSFX_Flags],a
    ret

.ch4reset
    ld      a,%10000000
    ldh     [rNR44],a
    ld      a,[DSFX_Flags]
    or      1<<DSFX_CH4
    ld      [DSFX_Flags],a
    ret

.setdelay
    ld      a,[hl+]
    ld      [DSFX_Delay],a
    ret

.end
    ld      hl,DSFX_Flags
    ld      [hl],0
    ld      a,1
    ld      [DSX_ForceWaveReload],a
    ret

DSFX_Waves:
    db  $8B,$EF,$FF,$FF,$FF,$FF,$FE,$B8,$63,$00,$00,$00,$00,$00,$00,$36
    db  $11,$11,$11,$11,$11,$11,$11,$11,$00,$00,$00,$00,$00,$00,$00,$00
    db  $22,$22,$22,$22,$22,$22,$22,$22,$00,$00,$00,$00,$00,$00,$00,$00
    db  $33,$33,$33,$33,$33,$33,$33,$33,$00,$00,$00,$00,$00,$00,$00,$00
    db  $44,$44,$44,$44,$44,$44,$44,$44,$00,$00,$00,$00,$00,$00,$00,$00
    db  $55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00,$00
    db  $66,$66,$66,$66,$66,$66,$66,$66,$00,$00,$00,$00,$00,$00,$00,$00
    db  $77,$77,$77,$77,$77,$77,$77,$77,$00,$00,$00,$00,$00,$00,$00,$00
    db  $88,$88,$88,$88,$88,$88,$88,$88,$00,$00,$00,$00,$00,$00,$00,$00
    db  $99,$99,$99,$99,$99,$99,$99,$99,$00,$00,$00,$00,$00,$00,$00,$00
    db  $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$00,$00,$00,$00
    db  $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BB,$00,$00,$00,$00,$00,$00,$00,$00
    db  $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC,$00,$00,$00,$00,$00,$00,$00,$00
    db  $DD,$DD,$DD,$DD,$DD,$DD,$DD,$DD,$00,$00,$00,$00,$00,$00,$00,$00
    db  $EE,$EE,$EE,$EE,$EE,$EE,$EE,$EE,$00,$00,$00,$00,$00,$00,$00,$00
    db  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
    db  $04,$8C,$FF,$FC,$CA,$86,$42,$20,$00,$00,$00,$00,$00,$00,$00,$00

include "Audio/SFXData.asm"

