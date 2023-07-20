section "Sprite viewer RAM",wram0
SpriteView_CurrentSprite:   db

section "Sprite viewer routines",rom0
GM_SpriteViewer:

    call    ClearScreen

    ldfar   hl,Pal_DebugScreen
    xor     a
    call    LoadPal
    ldfar   hl,Pal_Player
    ld      a,8
    call    LoadPal
    ld      a,9
    call    LoadPal
    call    CopyPalettes

    ldfar   hl,Font
    ld      de,$8000
    call    DecodeWLE

    ld      [sys_PauseGame],a
    farcall DSX_Init

    ld      a,LCDCF_ON | LCDCF_BG8000 | LCDCF_OBJON | LCDCF_BGON | LCDCF_OBJON
    ldh     [rLCDC],a
    
    ld      hl,SpriteView_CurrentSprite
    ld      [hl],0
    call    SpriteViewLoop.drawname

    ld      a,1
    ld      [sys_EnableHDMA],a
    ld      a,IEF_VBLANK
    ldh     [rIE],a
    ei
    
SpriteViewLoop:
    xor     a
    ldh     [rSCX],a
    ldh     [rSCY],a

    ld      a,[sys_btnPress]
    ld      hl,SpriteView_CurrentSprite
    bit     btnLeft,a
    call    nz,.dec
    bit     btnRight,a
    call    nz,.inc
    bit     btnB,a
    jr      nz,.exit
    call    .drawname
     
    
    halt
    jr      SpriteViewLoop
.dec
    dec     [hl]
    ret
.inc
    inc     [hl]
    ret
.drawname
    xor     a
    ldh     [rVBK],a
    push    hl
    ld      hl,.strBlank
    ld      de,_SCRN0+$20
    call    PrintString
    pop     hl
    ld      a,[hl]
    ldfar   hl,SpriteNamePointers
    ld      c,a
    ld      b,0
    add     hl,bc
    add     hl,bc
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    ld      b,bank(SpriteNames)
    rst     Bankswitch
    ld      de,_SCRN0+$20
    call    PrintString
    
    ld      a,[SpriteView_CurrentSprite]
    ld      l,a
    ld      h,0
    ld      e,a
    ld      d,0
    add     hl,hl   ; x2
    add     hl,de   ; x3
    ldfar   de,SpritePointers
    add     hl,de
    ld      a,[hl+]
    ld      b,a
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    
    lb      de,SCRN_X-40,SCRN_Y-56
    ld      c,0
    call    DrawMetasprite
    
    ret
.exit
    halt
    xor     a
    ld      [sys_EnableHDMA],a
    ldh     [rLCDC],a
    jp      GM_DebugMenu
.strBlank:
    ds  20," "
    db  0