
; ================

section "End screen routines",rom0

GM_EndScreen:
	call    ClearScreen
    
	ldfar	hl,EndScreenTiles
	ld		de,$8000
	call	DecodeWLE

	ld		hl,EndScreenMap
	ld		de,sys_TilemapBuffer
	call	DecodeWLE
	ld		hl,sys_TilemapBuffer
	call	LoadTilemapScreen
    
    ld      a,1
    ldh     [rVBK],a
    
	ld		hl,EndScreenAttr
	ld		de,sys_TilemapBuffer
	call	DecodeWLE
	ld		hl,sys_TilemapBuffer
	call	LoadTilemapScreen
    
    xor     a
    ldh     [rVBK],a

	ldfar	hl,Pal_EndScreen
    ld      b,6
    xor     a
:   push    af
    push    bc
    call    LoadPal
    pop     bc
    pop     af
    inc     a
    dec     b
    jr      nz,:-
    call    ConvertPals
    call    PalFadeInWhite
    call	UpdatePalettes

	ld		a,LCDCF_ON | LCDCF_BG8000 | LCDCF_BGON
	ldh		[rLCDC],a
	ld		a,IEF_VBLANK
	ldh		[rIE],a
	ei

.loop
	halt
    ld      a,[sys_btnPress]
    and     a           ; are any buttons pressed?
    jr      nz,:+
    jr      .loop
:   call    PalFadeOutWhite
:   halt
    ld		a,[sys_FadeState]
	bit		0,a
    jr      nz,:-
	xor		a
	ldh		[rLCDC],a
    jp      GM_TitleAndMenus

; ================

section "End screen GFX",romx

EndScreenTiles:	incbin	"GFX/Screens/EndScreen.2bpp.wle"
EndScreenMap:	incbin	"GFX/Screens/EndScreen.til.wle"
EndScreenAttr:  incbin  "GFX/Screens/EndScreen.atr.wle"
Pal_EndScreen:  incbin  "GFX/Screens/EndScreen.pal"