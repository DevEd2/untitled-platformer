if DebugMode

section fragment "WRAM defines",wram0
Debug_MusicID:  db
Debug_SFXID:    db

section "Sound test menu routines",rom0

GM_SoundTest:
    ldh     a,[rLCDC]
    bit     7,a
    jr      z,:+
    rst     WaitVBlank
    xor     a
    ldh     [rLCDC],a

    ; clear VRAM
    ld      hl,_VRAM
    ld      bc,_SRAM-_VRAM
    call    _FillRAM

:   ldfar   hl,Font
    ld      de,_VRAM8000
    call    DecodeWLE

    ldfar   hl,str_SoundTest_Music
    ld      de,$9820
    call    PrintString
    ; ld      hl,str_SoundTest_SFX
    ld      de,$9840
    call    PrintString
    
    ld      a,LCDCF_ON | LCDCF_BG8000 | LCDCF_OBJON | LCDCF_BGON
    ldh     [rLCDC],a
    ld      a,IEF_VBLANK
    ldh     [rIE],a
    
    ld      hl,Debug_MusicID
    xor     a
    ld      [hl+],a
    ld      [hl+],a
    ld      [Debug_MenuPos],a
    inc     a
    ld      [Debug_MenuMax],a
    ld      a,$18
    ld      [Debug_MenuOffset],a
    
    farcall    DSX_Init
    
    ei
    
SoundTestLoop:
    ld      a,[sys_btnPress]
    ld      e,a
    bit     btnSelect,e
    jr      z,.checkleft
    ld      a,[Debug_MenuPos]
    xor     1
    ld      [Debug_MenuPos],a
.checkleft
    bit     btnLeft,e
    jr      z,.checkright
    ld      a,[Debug_MenuPos]
    and     a
    jr      nz,.l1sfx
.l1music
    ld      hl,Debug_MusicID
    dec     [hl]
    jr      .checkright
.l1sfx
    ld      hl,Debug_SFXID
    dec     [hl]
    ; fall through
.checkright
    bit     btnRight,e
    jr      z,.checkup
    ld      a,[Debug_MenuPos]
    and     a
    jr      nz,.r1sfx
.r1music
    ld      hl,Debug_MusicID
    inc     [hl]
    jr      .checkup
.r1sfx
    ld      hl,Debug_SFXID
    inc     [hl]
    ; fall through
.checkup
    bit     btnUp,e
    jr      z,.checkdown
    ld      a,[Debug_MenuPos]
    and     a
    jr      nz,.u16sfx
.u16music
    ld      a,[Debug_MusicID]
    add     16
    ld      [Debug_MusicID],a
    jr      .checkdown
.u16sfx
    ld      a,[Debug_SFXID]
    add     16
    ld      [Debug_SFXID],a
    ; fall through
.checkdown
    bit     btnDown,e
    jr      z,.checka
    ld      a,[Debug_MenuPos]
    and     a
    jr      nz,.d16sfx
.d16music
    ld      a,[Debug_MusicID]
    sub     16
    ld      [Debug_MusicID],a
    jr      .checka
.d16sfx
    ld      a,[Debug_SFXID]
    sub     16
    ld      [Debug_SFXID],a
    ; fall through
.checka
    bit     btnA,e
    jr      z,.checkb
    ld      a,[Debug_MenuPos]
    and     a
    jr      nz,.playsfx
.playmusic
    farcall DSX_Init
    ld      a,[Debug_MusicID]
    ld      l,a
    ld      h,0
    add     hl,hl
    ld      b,h
    ld      c,l
    ld      hl,SoundTest_MusicPointers
    add     hl,bc
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    call    DSX_PlaySong
    jr      .checkb
.playsfx
    ld      a,[Debug_SFXID]
    ld      l,a
    ld      h,0
    push    de
    ld      d,h
    ld      e,l
    add     hl,hl
    ld      b,h
    ld      c,l
    ld      hl,SoundTest_SFXPointers
    add     hl,bc
    add     hl,de
    pop     de
    ld      a,[hl+]
    ld      b,a
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    call    DSFX_PlaySFX
.checkb
    bit     btnB,e
    jr      z,.continue
    call    DSX_Init
    rst     WaitVBlank
    xor     a
    ldh     [rLCDC],a
    ld      [DSFX_Flags],a
    jp      GM_DebugMenu
.continue    
    ld      a,[Debug_MusicID]
    ld      hl,$9828
    call    PrintHex
    ld      a,[Debug_SFXID]
    ld      hl,$9848
    call    PrintHex
    
    call    Debug_DrawCursor
    rst     WaitVBlank
    jp      SoundTestLoop

SoundTest_MusicPointers:
    dw      Mus_Intro

SoundTest_SFXPointers:
    bankptr SFX_Test
    bankptr SFX_Jump
    bankptr SFX_DashLoop
    bankptr SFX_Skid
    bankptr SFX_DashWall
    
section "Sound test text",romx

str_SoundTest_Music:    db    "  MUSIC ??",0
str_SoundTest_SFX:      db    "  SFX   ??",0

endc