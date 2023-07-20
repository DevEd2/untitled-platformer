section "Level select RAM",wram0

section "Level select routines",rom0
GM_LevelSelect:
    call    ClearScreen

    ldfar   hl,Pal_DebugScreen
    xor     a
    call    LoadPal
    ld      a,8
    ld      hl,Pal_DebugScreen
    call    LoadPal
    call    CopyPalettes

    ldfar   hl,Font
    ld      de,$8000
    call    DecodeWLE

    ld      a,NUM_LEVEL_SELECT_ENTRIES-1
    ld      [Debug_MenuMax],a
    xor     a
    ld      [Debug_MenuPos],a
    ld      [sys_PauseGame],a
    ; farcall DSX_Stop

    ld      a,$18
    ld      [Debug_MenuOffset],a

    ld      a,LCDCF_ON | LCDCF_BG8000 | LCDCF_OBJON | LCDCF_BGON
    ldh     [rLCDC],a
    ld      a,IEF_VBLANK
    ldh     [rIE],a
    ei
    
    call    LevelSelect_DrawNames

LevelSelectLoop:
    ld      a,[sys_btnPress]
    bit     btnUp,a
    jr      z,.checkdown
    ld      hl,Debug_MenuPos
    dec     [hl]
    ld      a,[hl]
    cp      $ff
    jr      nz,:+
    ld      a,[Debug_MenuMax]
    ld      [hl],a
:   call    LevelSelect_DrawNames
    jr      .drawcursor
    
.checkdown
    bit     btnDown,a
    jr      z,.checkLeft
    ld      hl,Debug_MenuPos
    inc     [hl]
    ld      b,[hl]
    ld      a,[Debug_MenuMax]
    inc     a
    cp      b
    jr      nz,:+
    xor     a
    ld      [hl],a
:   call    LevelSelect_DrawNames
    jr      .drawcursor

.checkLeft
    bit     btnLeft,a
    jr      z,.checkRight
    ld      a,[Debug_MenuPos]
    sub     16
    jr      nc,:+
    xor     a
:   ld      [Debug_MenuPos],a
    call    LevelSelect_DrawNames
    jr      .drawcursor

.checkRight
    bit     btnRight,a
    jr      z,.checkA
    ld      a,[Debug_MenuPos]
    add     16
    cp      NUM_LEVEL_SELECT_ENTRIES-1
    jr      c,:+
    ld      a,NUM_LEVEL_SELECT_ENTRIES-1
:   ld      [Debug_MenuPos],a
    call    LevelSelect_DrawNames
    jr      .drawcursor

.checkA
    bit     btnA,a
    jr      z,.checkB
    ; TODO
    halt
    xor     a
    ldh     [rLCDC],a
    ld      a,PLAYER_LIVES
    ld      [Player_LifeCount],a
    xor     a
    ld      [Player_CoinCount],a
    ld      [Player_CoinCount+1],a
    ld      [Player_CoinCountHUD],a
    ld      [Player_CoinCountHUD+1],a
    ld      a,[Debug_MenuPos]
    jp      GM_Level

.checkB
    bit     btnB,a
    jr      z,.drawcursor
    halt
    xor     a
    ldh     [rLCDC],a
    jp      GM_DebugMenu

.drawcursor
    call    Debug_DrawCursor
    halt
    jp      LevelSelectLoop

LevelSelect_DrawNames:
    ld      hl,$9800
    ld      bc,$400
:   WaitForVRAM
    xor     a
    ld      [hl+],a
    dec     bc
    ld      a,b
    or      c
    jr      nz,:-

    ld      b,bank(LevelSelect_LevelNames)
    call    _Bankswitch
    ld      a,[Debug_MenuPos]
    and     $f0 
    ld      b,16
    ld      de,$9822
:   push    af
    ld      hl,LevelSelect_LevelNames
    add     a
    add     l
    ld      l,a
    jr      nc,:+
    inc     h
:   ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    push    de
    call    PrintString
    pop     de
    ld      a,e
    add     32
    ld      e,a
    jr      nc,:+
    inc     d
:   pop     af
    inc     a
    cp      NUM_LEVEL_SELECT_ENTRIES
    ret     z
    dec     b
    jr      nz,:---
    ret

section "Level names",romx
LevelSelect_LevelNames:
    dw       .0
NUM_LEVEL_SELECT_ENTRIES = (@-LevelSelect_LevelNames)/2
    
.0  db          "TEST MAP",0
