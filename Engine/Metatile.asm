section "Metatile RAM defines",wram0,align[8]

Engine_TilesetPointer:  dw
Engine_TilesetBank:     db

; Collision constants

COLLISION_NONE                          = 0  ; no collision
COLLISION_SOLID                         = 1  ; solid to player and enemies
COLLISION_TOPSOLID                      = 2  ; solid to player and enemies only on top
COLLISION_WATER                         = 3  ; tile is underwater and has no collision
COLLISION_COIN                          = 4  ; player can collect tile; adds 1 to score
COLLISION_SPRING                        = 5  ; player bounces up when this tile is touched
COLLISION_KILL                          = 6  ; player is hurt when this tile is touched
COLLISION_BREAKABLE                     = 7  ; player can break this tile by dashing into it
COLLISION_BREAKABLE_COFFEE              = 8  ; player can break this tile with the coffee transformation
COLLISION_CLIMBABLE_LAMIA               = 9  ; player can climb up this tile with the lamia transformation
COLLISION_WATER_CURRENT_UP              = 10 ; tile is underwater and pushes player up
COLLISION_WATER_CURRENT_DOWN            = 11 ; tile is underwater and pushes player down
COLLISION_WATER_CURRENT_LEFT            = 12 ; tile is underwater and pushes player left
COLLISION_WATER_CURRENT_RIGHT           = 13 ; tile is underwater and pushes player right
COLLISION_SOLID_ENEMY                   = 14 ; tile is solid to enemies but not to the player
COLLISION_BREAKABLE_HEAVY               = 15 ; tile breaks when a heavy object touches it from above
COLLISION_BREAKABLE_ENEMY               = 16 ; player can break tile by throwing an enemy at it
COLLISION_WATER_STRONG_CURRENT_UP       = 17 ; tile is underwater and pushes player up a lot
COLLISION_WATER_STRONG_CURRENT_DOWN     = 18 ; tile is underwater and pushes player down a lot
COLLISION_WATER_STRONG_CURRENT_LEFT     = 19 ; tile is underwater and pushes player left a lot
COLLISION_WATER_STRONG_CURRENT_RIGHT    = 20 ; tile is underwater and pushes player right a lot
; add more as needed

section "Metatile routines",rom0

; Input:    H = Y pos
;           L = X pos
; Output:   A = Tile coordinates
; Destroys: B
GetTileCoordinates:
    ld      a,l
    and     $f0
    swap    a
    ld      b,a
    ld      a,h
    and     $f0
    add     b
    ret
    
; Input:    E = Tile coordinates
;       Carry = Subtract 1 from screen 
; Output:   A = Collision ID, B = Tile ID
; Destroys: HL, rROMB0

GetTileL:
    push    af
    ldh     a,[rSVBK]
    and     $7
    ldh     [sys_TempSVBK],a
    ld      a,[Engine_CurrentSubarea]
    and     $30
    swap    a
    add     2
    ldh     [rSVBK],a
    ld      a,[Engine_CurrentScreen]
    and     $f
    ld      hl,Engine_LevelData
    add     h
    ld      h,a
    pop     af
    jr      nc,.nocarry
    ld      a,[Engine_CurrentScreen]
    and     $f
    jr      z,.forcesolid
    dec     h
.nocarry
    ld      l,e
    ld      a,[hl]
	ld		b,a
	push	bc
	; get collision ID
	ld		e,a
	ld		a,[Engine_TilesetBank]
	ld		b,a
	call	_Bankswitch
	ld		hl,Engine_CollisionPointer
    ld		a,[hl+]
	ld		h,[hl]
	add		e
	ld		l,a
	jr		nc,:+
	inc		h
:	ld		a,[hl]
	pop		bc
	ret
.forcesolid
    ld      a,COLLISION_SOLID
    ret
    
; Input:    E = Tile coordinates
;       Carry = Subtract 1 from screen 
; Output:   A = Collision ID, B = Tile ID
; Destroys: B, HL, rROMB0
GetTileR:
    push    af
    ldh     a,[rSVBK]
    and     $7
    ldh     [sys_TempSVBK],a
    ld      a,[Engine_CurrentSubarea]
    and     $30
    swap    a
    add     2
    ldh     [rSVBK],a
    ld      a,[Engine_CurrentScreen]
    and     $f
    ld      hl,Engine_LevelData
    add     h
    ld      h,a
    pop     af
    jr      nc,.nocarry
    ld      a,[Engine_CurrentScreen]
    and     $f
    ld      b,a
    ld      a,[Engine_NumScreens]
    cp      b
    jr      z,.forcesolid
    inc     h
.nocarry
    ld      l,e
    ld      a,[hl]
	; get collision ID
	ld		e,a
	ld		a,[Engine_TilesetBank]
	ld		b,a
	call	_Bankswitch
	ld		hl,Engine_CollisionPointer
    ld		a,[hl+]
	ld		h,[hl]
	add		e
	ld		l,a
	jr		nc,:+
	inc		h
:	ld		a,[hl]
    ret
.forcesolid
    ld      a,COLLISION_SOLID
    ret

; Input:    A = Tile coordinates
;           B = Tile ID
; Output:   Metatile to screen RAM
; Destroys: BC, DE, HL
DrawMetatile:
    push    af
    ld      e,a
    and     $0f
    rla
    ld      l,a
    ld      a,e
    and     $f0
    ld      e,a
    rla
    rla
    and     %11000000
    or      l
    ld      l,a
    ld      a,e
    rra
    rra
    swap    a
    and     $3
    ld      h,a
    
    ld      de,_SCRN0
    add     hl,de
    ld      d,h
    ld      e,l
    ; get tile data pointer
    push    bc
    ld      a,[Engine_TilesetBank]
    ld      b,a
    call    _Bankswitch
    pop     bc
    ld      hl,Engine_TilesetPointer
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    ; skip collision pointer + gfx bank & pointer
    push    de
    ld      de,5
    add     hl,de
    pop     de
    ld      c,b
    ld      b,0
    add     hl,bc
    add     hl,bc
    add     hl,bc
    add     hl,bc
    add     hl,bc
    add     hl,bc
    add     hl,bc
    add     hl,bc
    ; write to screen memory
    xor     a
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    ld      a,1
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    inc     de
    
    xor     a
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    ld      a,1
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    ld      a,e
    add     $1f
    jr      nc,.nocarry3
    inc     d
.nocarry3
    ld  e,a
    
    xor     a
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    ld      a,1
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    inc     de
    
    xor     a
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    ld      a,1
    ldh     [rVBK],a
    WaitForVRAM
    ld      a,[hl+]
    ld      [de],a
    pop     af
    ret
