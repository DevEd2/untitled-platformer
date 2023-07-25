; ===============
; Project defines
; ===============

; Hardware defines
include "hardware.inc/hardware.inc"

; ================
; Global constants
; ================

sys_DMG         equ 0
sys_GBP         equ 1
sys_SGB         equ 2
sys_SGB2        equ 3
sys_GBC         equ 4
sys_GBA         equ 5

btnA            equ 0
btnB            equ 1
btnSelect       equ 2
btnStart        equ 3
btnRight        equ 4
btnLeft         equ 5
btnUp           equ 6
btnDown         equ 7

_A              equ 1
_B              equ 2
_Select         equ 4
_Start          equ 8
_Right          equ 16
_Left           equ 32
_Up             equ 64
_Down           equ 128

; ==========================
; Project-specific constants
; ==========================

; TODO: Remove this
TILESET_TEST    equ 0

; ======
; Macros
; ======

; Copy a tileset to a specified VRAM address.
; USAGE: CopyTileset [tileset],[VRAM address],[number of tiles to copy]
macro CopyTileset
    ld      bc,$10*\3       ; number of tiles to copy
    ld      hl,\1           ; address of tiles to copy
    ld      de,$8000+\2     ; address to copy to
    call    _CopyRAM
endm
    
; Same as CopyTileset, but waits for VRAM accessibility.
macro CopyTilesetSafe
    ld      bc,$10*\3       ; number of tiles to copy
    ld      hl,\1           ; address of tiles to copy
    ld      de,$8000+\2     ; address to copy to
    call    _CopyTilesetSafe
endm
    
; Copy a 1BPP tileset to a specified VRAM address.
; USAGE: CopyTileset1BPP [tileset],[VRAM address],[number of tiles to copy]
macro CopyTileset1BPP
    ld      bc,$10*\3       ; number of tiles to copy
    ld      hl,\1           ; address of tiles to copy
    ld      de,$8000+\2     ; address to copy to
    call    _CopyTileset1BPP
endm

; Same as CopyTileset1BPP, but waits for VRAM accessibility.
macro CopyTileset1BPPSafe
    ld      bc,$10*\3       ; number of tiles to copy
    ld      hl,\1           ; address of tiles to copy
    ld      de,$8000+\2     ; address to copy to
    call    _CopyTileset1BPPSafe
endm

; Loads a DMG palette.
; USAGE: SetPal <rBGP/rOBP0/rOBP1>,(color 1),(color 2),(color 3),(color 4)
macro SetDMGPal
    ld      a,(\2 + (\3 << 2) + (\4 << 4) + (\5 << 6))
    ldh     [\1],a
endm
    
; Defines a Game Boy Color RGB palette.
; USAGE: RGB    <red>,<green>,<blue>
macro RGB
    dw      \1+(\2<<5)+(\3<<10)
endm

; Wait for VRAM accessibility.
macro WaitForVRAM
    ldh     a,[rSTAT]
    and     STATF_BUSY
    jr      nz,@-4
endm
    
macro string
    db      \1,0
endm

; Loads appropriate ROM bank for a block of data and loads its pointer into a given register.
; Trashes B.
macro ldfar
    ld      b,bank(\2)
    rst     Bankswitch
    ld      \1,\2
endm
    
; Loads appropriate ROM bank for a routine and executes it.
; Trashes B.
macro farcall
    ld      b,bank(\1)
    rst     Bankswitch
    call    \1
endm
    
macro resbank
    ldh     a,[sys_LastBank]
    ldh     [sys_CurrentBank],a
    ld      [rROMB0],a
endm

macro bankptr
    db		bank(\1)
	dw		\1
	endm
    
macro djnz
    dec     b
    jr      nz,\1
endm
    
macro lb
    ld      \1,\2<<8 | \3
endm
    
macro dbp
.str\@
    db      \1
.str\@_end
    rept    \2-(.str\@_end-.str\@)
        db  \3
    endr
endm

macro dbw
    db      \1
    dw      \2
endm

macro dwb2
    db      bank(\1)
    dw      \1
    db      bank(\2)
    dw      \2
endm

macro dwb3
    db      bank(\1)
    dw      \1
    db      bank(\2)
    dw      \2
    db      bank(\3)
    dw      \3
endm

if DebugMode
macro debugmsg
    ld      d,d
    jr      .\@
    dw      $6464
    dw      0
    db      \1,0
    dw      0
    dw      0
.\@
endm
endc

macro const_def
const_value = 0
endm

macro const
if "\1" != "skip"
\1  equ const_value
endc
const_value = const_value + 1
ENDM

macro PlaySFX
    push    hl
    ld      b,bank(SFX_\1)
    ld      hl,SFX_\1
    call    DSFX_PlaySFX
    pop     hl
endm

macro PlaySFX2
    push    hl
    ld      b,bank(SFX_\1)
    ld      hl,SFX_\1
    call    DSFX_PlaySFX2
    pop     hl
endm

tmcoord:    macro
    ld      hl,sys_TilemapBuffer + ((\2*20) | \1)
endm
    
; === Project-specific macros ===

; =========
; Variables
; =========

section "Variables",wram0,align[8]

OAMBuffer:          ds  40*4    ; 40 sprites, 4 bytes each
.end

sys_GBType:             db  ; 0 = DMG, 1 = GBC, 2 = GBA
sys_ResetTimer:         db
sys_CurrentFrame:       db  ; incremented each frame, used for timing
sys_btnPress:           db  ; buttons pressed this frame
sys_btnHold:            db  ; buttons held
sys_btnRelease:         db  ; buttons released this frame

sys_VBlankFlag:         db
sys_LCDCFlag:           db
sys_TimerFlag:          db
sys_SerialFlag:         db
sys_JoypadFlag:         db

sys_PauseGame:          db
sys_SleepModeTimer:     db
sys_SecondsUntilSleep:  db

sys_EmuCheck:           db

sys_EnableParallax:     db
sys_EnableHDMA:         db
sys_TilemapBuffer:      ds  20*18
sys_StringBuffer:       ds  32

; project-specific

section "Zeropage",hram

OAM_DMA:                ds  16
tempAF:                 dw
tempBC:                 dw
tempDE:                 dw
tempHL:                 dw
tempSP:                 dw
sys_CurrentBank:        db
sys_LastBank:           db
sys_TempBank1:          db
sys_TempBank2:          db
sys_TempBank3:          db
sys_TempCounter:        db
sys_TempSVBK:           db
sys_HDMA1:              db
sys_HDMA2:              db
sys_HDMA3:              db
sys_HDMA4:              db
sys_HDMA5:              db
sys_HDMABank:           db
