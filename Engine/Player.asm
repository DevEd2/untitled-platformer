; ==================
; Player RAM defines
; ==================

section "Player RAM",wram0
PlayerRAM:

Player_MovementFlags::      db
Player_MovementFlags2::     db
Player_XPos::               db  ; current X position
Player_XSubpixel::          db  ; current X subpixel
Player_YPos::               db  ; current Y position
Player_YSubpixel::          db  ; current Y subpixel
Player_XVelocity::          db  ; current X velocity
Player_XVelocityS::         db  ; current X fractional velocity
Player_XSpeedCap::          dw
Player_XSpeedCapNeg::       dw
Player_YVelocity::          db  ; current Y velocity
Player_YVelocityS::         db  ; current Y fractional velocity
Player_LastJumpY::          db  ; last Jump Y position (absolute)
Player_AnimPointer::        dw  ; pointer to current animation sequence
Player_AnimTimer::          db  ; time until next animation frame is displayed (if -1, frame will be displayed indefinitely)
Player_AnimLock::           db  ; if 1, current animation cannot be interrupted
Player_CurrentFrame::       db  ; current animation frame being displayed
Player_FramePointer::       db  ; pointer to current animation frame
Player_RunAnimSpeed::       db  ; current run animation speed

Player_XPosBuffer::         ds  8
Player_YPosBuffer::         ds  8

Player_DashSoundTimer::     db  ; timer for dash sound effect

PlayerRAM_End:
; the following are part of the player RAM but are not to be cleared after each level
Player_CoinCount::          dw	; actual coin count
Player_CoinCountHUD::		dw	; visible coin count
Player_LifeCount::          db

; initial player life count
PLAYER_LIVES                = 5

; player movement constants
Player_WalkSpeed            = $200
Player_DashSpeed            = $500
Player_WalkSpeedWater       = $e0
Player_KnockbackSpeed       = -$200
Player_Accel                = 24
Player_Decel                = 32
Player_DashAccel            = 10
Player_DashDecel            = 48
Player_SkidDecel            = 20
Player_Gravity              = $25

Player_JumpHeight           = -$400
Player_WaterJumpHeight      = -$240
Player_HighJumpHeight       = -$480
Player_KnockbackHeight      = -$1c0

Player_WallJumpHeight       = -$180
Player_HighWallJumpHeight   = -$400
Player_LowWallJumpHeight    = -$100

Player_TerminalVelocity     = $600
Player_HitboxWidth          = 6
Player_HitboxHeight         = 14
Player_HitboxHeightCrawl    = 6

Player_SpringStrength       = -$750

; Player_MovementFlags defines

bPlayerAccelerating             = 0
bPlayerIsUnderwater         = 1
bPlayerIsDead               = 2
bPlayerMaxSpeed             = 3
bPlayerHitEnemy             = 4
bPlayerJumpCancel           = 5
bPlayerStageEnd             = 6
bPlayerDirection            = 7

; Player_MovementFlags2 defines
bPlayerIsAirborne           = 0
bPlayerIsDashing            = 1
bPlayerDashMaxSpeed         = 2
bPlayerDashStun             = 3
bPlayerIsDucking            = 4
bPlayerDashSkid             = 5
bPlayerIsMoving             = 6

; ========================
; Player animation defines
; ========================

; ===============
; Player routines
; ===============

section "Player routines",rom0

InitPlayer:
    ; init RAM
    ld      hl,PlayerRAM
    ld      b,PlayerRAM_End-PlayerRAM
    xor     a
    call    _FillRAMSmall
    ; initialize animation timer
    ld      a,-1
    ld      [Player_AnimTimer],a
    ; load player palette
    ldfar   hl,Pal_Player
    ld      a,8
    call    LoadPal
    ld      a,9
    call    LoadPal
    ld      hl,Anim_Player_Idle
    call    Player_SetAnimation
    resbank
    ; init position buffers
    ld      a,[Player_XPos]
    ld      b,a
    ld      a,[Player_YPos]
    ld      c,a
    ld      a,8
    ld      hl,Player_XPosBuffer
    ld      de,Player_YPosBuffer
:   ld      [hl],b
    push    af
    ld      a,c
    ld      [de],a
    pop     af
    inc     hl
    inc     de
    dec     a
    jr      nz,:-
    
    ld      a,1
    ld      [sys_EnableHDMA],a
    ret

; ========

ProcessPlayer:
:   ld      a,[Player_MovementFlags]
    bit     bPlayerIsDead,a
    jr      z,.notdead
    
    ld      a,[Player_YVelocity]
    bit     7,a ; is player falling?
    jp      nz,.moveair2
    ld      a,[Player_YPos]
    and     $f0
    sub     16
    ld      b,a
    ld      a,[Engine_CameraY]
    and     $f0
    add     SCRN_Y
    cp      b
    jp      z,Player_Respawn
    jp      .moveair2
.notdead
    ld      a,[sys_btnRelease]
    bit     btnA,a
    jr      z,:+
    ld      a,[Player_YVelocity]
    bit     7,a
    jr      z,:+
    scf
    rra
    ld      [Player_YVelocity],a
    ld      a,[Player_YVelocityS]
    rra
    ld      [Player_YVelocityS],a
:
    
    ld      a,[sys_btnPress]
    bit     btnA,a
    call    nz,Player_Jump
    ld      a,[sys_btnHold]
    bit     btnB,a
    jr      z,.nodash
    ; do dash
    ld      a,low(Player_DashSpeed)
    ld      [Player_XSpeedCap],a
    ld      a,high(Player_DashSpeed)
    ld      [Player_XSpeedCap+1],a
    ld      a,low(-Player_DashSpeed)
    ld      [Player_XSpeedCapNeg],a
    ld      a,high(-Player_DashSpeed)
    ld      [Player_XSpeedCapNeg+1],a
    ld      hl,Player_MovementFlags2
    set     bPlayerIsDashing,[hl]
    jr      :+
.nodash
    ld      a,low(Player_WalkSpeed)
    ld      [Player_XSpeedCap],a
    ld      a,high(Player_WalkSpeed)
    ld      [Player_XSpeedCap+1],a
    ld      a,low(-Player_WalkSpeed)
    ld      [Player_XSpeedCapNeg],a
    ld      a,high(-Player_WalkSpeed)
    ld      [Player_XSpeedCapNeg+1],a
    ld      hl,Player_MovementFlags2
    res     bPlayerIsDashing,[hl]
:   lb      bc,0,1
    ld      a,[sys_btnHold]
    bit     btnLeft,a
    jr      nz,.accelLeft
    bit     btnRight,a
    jr      nz,.accelRight
    ; if left or right aren't being held...
    ld      a,[Player_MovementFlags]
    res     0,a
    ld      [Player_MovementFlags],a
    ld      d,a
    jp      .noaccel
.accelLeft
    call    Player_AccelerateLeft
    jr      .continue
.accelRight
    call    Player_AccelerateRight
    
.continue
    ld      a,c
    or      e
    ld      d,a
    
    ld      hl,Player_MovementFlags2
    set     bPlayerIsMoving,[hl]
    
.noaccel
    res     1,d
    ; get tile underneath player
    ld      a,[Player_YPos]
    ld      l,a
    ld      a,[Player_XPos]
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    and     a               ; clear carry
    call    GetTileL        ; doesn't matter if we use GetTileL or GetTileR, the result is the same
    ; check if we're underwater
    cp      COLLISION_WATER ; are we touching a water tile?
    jr      nz,.checkcoin   ; if not, skip
    ld      a,[Player_MovementFlags]
    bit     bPlayerIsUnderwater,a             ; are we already underwater?
    jr      nz,:+           ; if not, skip playing splash sound
    ; PlaySFX splash          ; play splash sound
    
    call    Player_Splash
:    
    set     1,d             ; set player's "is underwater" flag
    jp      .decel
    
.checkcoin
    cp      COLLISION_COIN  ; are we touching a coin?
    jr      nz,.checkkill
    ; replace coin tile with "blank" tile
    ; TODO: Get tile from background
    push    de
    call    .removetile
    ; play sound effect
    ; PlaySFX coin
    ; increment coin count
    pop     de
    ld      a,[Player_CoinCount]
    add     1   ; inc a doesn't set carry
    ld      [Player_CoinCount],a
    jp      nc,.decel
    ld      a,[Player_CoinCount+1]
    add     1   ; inc a doesn't set carry
    ld      [Player_CoinCount+1],a
    jr      nc,.decel
    ld      a,$ff
    ld      [Player_CoinCount],a
    ld      [Player_CoinCount+1],a
    jr      .decel
    
.checkkill
    cp      COLLISION_KILL
    jr      nz,.checkspring
    call    KillPlayer
    jp      .moveair

.checkspring
    cp      COLLISION_SPRING
    jr      nz,.checkbreakable
    ; PlaySFX spring
    ld      a,high(Player_SpringStrength)
    ld      [Player_YVelocity],a
    ld      a,low(Player_SpringStrength)
    ld      [Player_YVelocityS],a
    jr      .donecollide

.checkbreakable
    cp      COLLISION_BREAKABLE
    jr      nz,.donecollide
    call    .removetile2
    ; TODO: sound effect + rubble
    jp      .nodecel

.removetile2
    ld      a,[Player_YPos]
    sub     16
    ld      l,a
    call    :+
.removetile
    ld      a,[Player_YPos]
    ld      l,a
:   ld      a,[Player_XPos]
    ld      h,a
	push	bc
    call    GetTileCoordinates
    pop		bc
	ld      e,a
    
    ld      hl,Engine_LevelData
    ld      a,[Engine_CurrentScreen]
    and     $f
    add     h
    ld      h,a
    ld      a,[Engine_CurrentScreen]
    and     $30
    swap    a
    add     2
    ldh     [rSVBK],a
    ld      l,e
	ld		a,b
	cp		$19	; is tile underground?
	jr		nz,.aboveground
	ld		a,6
	jr		:+
.aboveground
    ld      a,[hl]
    push    hl
    push    de
    and     a
    call    GetTileL    ; doesn't matter if we use GetTileL or GetTileR as long as carry is clear
    pop     de
    pop     hl
    cp      COLLISION_SOLID
    ret     z
    xor     a
:   ld      [hl],a
    ld      b,a
    ld      a,e
    swap    a
    jp      DrawMetatile
    
    
    
.donecollide
.decel
    ld      a,d
    ld      [Player_MovementFlags],a
    bit     0,a
    jp      nz,.nodecel
    
    bit     7,a
    jr      z,.decelRight
.decelLeft
;    ld      hl,Anim_Player_Left1
;    call    Player_SetAnimation
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    push    hl
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,[hl]
    pop     hl
    jr      z,:+
    ld      bc,Player_DashDecel
    jr      :++
:   ld      bc,Player_Decel
:   add     hl,bc
    bit     7,h
    jr      nz,:++   ; reset X speed to zero on overflow
:   ld      hl,0
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsMoving,a
    jr      z,:+
    push    af
    push    hl
    ld      hl,Anim_Player_Idle
    call    Player_SetAnimation
    pop     hl
    pop     af
    res     bPlayerIsMoving,a
    ld      [Player_MovementFlags2],a
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocityS],a
    jr      .nodecel
.decelRight
;    ld      hl,Anim_Player_Right1
;    call    Player_SetAnimation
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    push    hl
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,[hl]
    pop     hl
    jr      z,:+
    ld      bc,-Player_DashDecel
    jr      :++
:   ld      bc,-Player_Decel
:   add     hl,bc
    bit     7,h
    jr      z,:++    ; reset X speed to zero on overflow
:   ld      hl,0
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsMoving,a
    jr      z,:+
    push    af
    push    hl
    ld      hl,Anim_Player_Idle
    call    Player_SetAnimation
    pop     hl
    pop     af
    res     bPlayerIsMoving,a
    ld      [Player_MovementFlags2],a
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocity+1],a
    jr      .nodecel

    ; fall through
.nodecel
    ; Horizontal Movement
    ; Movement
    ld      a,[Player_XVelocity]
    ld      h,a
    ld      a,[Player_XVelocityS]
    ld      l,a
    ld      a,[Player_XPos]
    ld      d,a
    ld      a,[Player_XSubpixel]
    ld      e,a
    add     hl,de
    ld      a,h
    ld      [Player_XPos],a
    ld      a,l
    ld      [Player_XSubpixel],a
    ; Check Screen Crossing
    ld      a,[Player_XVelocity]
    bit     7,a
    jr      z,:+
    jp      c,.xMoveDone
    ; Left edge crossed, decrement current screen
    ld      a,[Engine_CurrentScreen]
    and     a
    jr      z,.leftedge
    and     $30
    ld      b,a
    ld      a,[Engine_CurrentScreen]
    and     $f
    sub     1
    jp      c,.xMoveDone
    or      b
    ld      [Engine_CurrentScreen],a
    jr      .xMoveDone
.leftedge
    ld      a,[Player_XVelocity]
    ld      b,a
    xor     a
    ld      [Player_XVelocity],a
    ld      [Player_XVelocityS],a
    ld      a,[Player_XPos]
    sub     b
    ld      [Player_XPos],a
:
    jr      nc,.xMoveDone
    ; Right edge crosses, increment current screen
    ld      a,[Engine_NumScreens]
    ld      b,a
    ld      a,[Engine_CurrentScreen]
    ld      e,a
    and     $f
    cp      b
    ld      a,e
    jr      z,.rightedge
    and     $30
    ld      b,a
    ld      a,[Engine_CurrentScreen]
    and     $f
    push    af
    inc     a
    or      b
    ld      e,a
    pop     af
    ld      a,e
    jr      :+
.rightedge
    ld      a,[Player_XVelocity]
    ld      b,a
    xor     a
    ld      [Player_XVelocity],a
    ld      [Player_XVelocityS],a
    ld      a,-1
    ld      [Player_XPos],a
    jr      .xMoveDone    
:
    ld      [Engine_CurrentScreen],a
.xMoveDone:

    ; Horizontal Collision
    
    ld      a,[Player_XVelocity]
    bit     7,a
    jp      z,.rightCollision
    ; Check Left Collision
    ; Top Left
    ld      a,[Player_YPos]
    sub     Player_HitboxHeight
    jr      c,:+
    ld      l,a
    ld      a,[Player_XPos]
    sub     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileL
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable1
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jr      z,:++
.notbreakable1
    cp      COLLISION_SOLID
    jr      z,.solidL
    ; Bottom Left
:
    ld      a,[Player_YPos]
    add     Player_HitboxHeight
    jp      c,.xCollideEnd
    ld      l,a
    ld      a,[Player_XPos]
    sub     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileL
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable2
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jp      nz,.xCollideEnd
.notbreakable2
    cp      COLLISION_SOLID
    jr      z,.solidL
:   ; Center Left
    ld      a,[Player_YPos]
    ld      l,a
    ld      a,[Player_XPos]
    sub     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileL
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable3
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jp      nz,.xCollideEnd
.notbreakable3
    cp      COLLISION_SOLID
    jp      nz,.xCollideEnd
.solidL
    ; Collision with left wall
 
    ; check if we're dashing
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsDashing,a
    jr      z,:++
    ; check if we're at max speed
    push    hl
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      c,[hl]
    ld      b,a
    bit     7,b
    jr      z,:+
    ld      a,b
    cpl
    inc     a
    ld      b,a
:   ld      hl,Player_XSpeedCap
    ld      a,[hl+]
    ld      d,[hl]
    ld      e,a
    call    Compare16
    pop     hl
    jr      nz,:+
    ; knockback
    ld      a,high(-Player_KnockbackSpeed)
    ld      [Player_XVelocity],a
    ld      a,low(-Player_KnockbackSpeed)
    ld      [Player_XVelocityS],a
    ld      a,high(Player_KnockbackHeight)
    ld      [Player_YVelocity],a
    ld      a,low(Player_KnockbackHeight)
    ld      [Player_YVelocityS],a
    PlaySFX DashWall
    jr      .calcPenetrationDepthL
:   xor     a
    ld      [Player_XVelocity],a
    ld      [Player_XVelocityS],a
.calcPenetrationDepthL
    ld      a,[Player_XPos]
    ld      c,a
    sub     Player_HitboxWidth
    and     $f
    ld      b,a
    ld      a,16
    sub     b
    ; Push player out of tile
    add     c
    ld      [Player_XPos],a
    ; Check Screen Crossing
    jp      nc,.xCollideEnd
    ; Right edge crosses, increment current screen
    ld      a,[Engine_CurrentScreen]
    and     $30
    ld      b,a
    ld      a,[Engine_CurrentScreen]
    push    bc
    ld      b,a
    ld      a,[Engine_NumScreens]
    cp      b
    ld      a,b
    pop     bc
    jp      z,.xCollideEnd
    inc     a
    or      b
    ld      [Engine_CurrentScreen],a
    jp      .xCollideEnd
.rightCollision:
    ; Check Right Collision
    ; Top Right
    ld      a,[Player_YPos]
    sub     Player_HitboxHeight
    jr      c,:+
    ld      l,a
    ld      a,[Player_XPos]
    add     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileR
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable4
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jr      z,:++
.notbreakable4
    cp      COLLISION_SOLID
    jr      z,.solidR
    ; Bottom Right
:
    ld      a,[Player_YPos]
    add     Player_HitboxHeight
    jp      c,.xCollideEnd
    ld      l,a
    ld      a,[Player_XPos]
    add     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileR
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable5
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jp      nz,.xCollideEnd
.notbreakable5
    cp      COLLISION_SOLID
    jr      z,.solidR
:   ; Center Left
    ld      a,[Player_YPos]
    ld      l,a
    ld      a,[Player_XPos]
    add     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileR
    cp      COLLISION_BREAKABLE
    jr      nz,.notbreakable6
    push    af
    ld      a,[Player_MovementFlags2]
    ld      b,a
    pop     af
    bit     bPlayerDashMaxSpeed,b
    jp      nz,.xCollideEnd
.notbreakable6
    cp      COLLISION_SOLID
    jp      nz,.xCollideEnd
:   
.solidR
    ; Collision with right wall
    ; check if we're dashing
    
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsDashing,a
    jr      z,:++
    ; check if we're at max speed
    push    hl
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      c,[hl]
    ld      b,a
    bit     7,b
    jr      z,:+
    ld      a,b
    cpl
    inc     a
    ld      b,a
:   ld      hl,Player_XSpeedCap
    ld      a,[hl+]
    ld      d,[hl]
    ld      e,a
    call    Compare16
    pop     hl
    jr      nz,:+
    ; knockback
    ld      a,high(Player_KnockbackSpeed)
    ld      [Player_XVelocity],a
    ld      a,low(Player_KnockbackSpeed)
    ld      [Player_XVelocityS],a
    ld      a,high(Player_KnockbackHeight)
    ld      [Player_YVelocity],a
    ld      a,low(Player_KnockbackHeight)
    ld      [Player_YVelocityS],a
    PlaySFX DashWall
    jr      .calcPenetrationDepthR
:   xor     a
    ld      [Player_XVelocity],a
    ld      [Player_XVelocityS],a
.calcPenetrationDepthR
    ld      a,[Player_XPos]
    push    af
    add     Player_HitboxWidth
    and     $f
    inc     a
    ld      b,a
    pop     af
    ; Push player out of tile
    sub     b
    ld      [Player_XPos],a
    ; Check Screen Crossing
    jr      nc,.xCollideEnd
    ; Left edge crossed, decrement current screen
    ld      a,[Engine_CurrentScreen]
    and     $30
    ld      b,a
    ld      a,[Engine_CurrentScreen]
    and     $f
    sub     1
    jr      c,.xCollideEnd
    or      b
    ld      [Engine_CurrentScreen],a
.xCollideEnd:
    
    ; Vertical Movement
    ; Gravity Acceleration
.moveair
    ld      a,[Player_MovementFlags]
    bit     bPlayerIsUnderwater,a
    jr      nz,.movewater
.moveair2
    ld      a,[Player_YVelocity]
    ld      h,a
    ld      a,[Player_YVelocityS]
    ld      l,a
    ld      de,Player_Gravity
    add     hl,de
    ld      a,h
    bit     7,a
    jr      nz,:+
    ld      b,h
    ld      c,l
    ld      de,Player_TerminalVelocity
    call    Compare16
    jr      c,:+
    ld      hl,Player_TerminalVelocity
:
    ld      a,h
    ld      [Player_YVelocity],a
    ld      a,l
    ld      [Player_YVelocityS],a
    ; Velocity
    ld      a,[Player_YPos]
    ld      b,a
    ld      a,[Player_YSubpixel]
    add     l
    ld      [Player_YSubpixel],a
    ld      a,[Player_YPos]
    adc     h
    ld      [Player_YPos],a
    call    Player_CheckSubscreenBoundary
    jr      .checkCollisionVertical
.movewater
    ld      a,[Player_YVelocity]
    ld      h,a
    ld      a,[Player_YVelocityS]
    ld      l,a
    ld      de,Player_Gravity/2
    add     hl,de
    ld      a,h
    bit     7,a
    jr      nz,:+
    ld      b,h
    ld      c,l
    ld      de,Player_TerminalVelocity/4
    call    Compare16
    jr      c,:+
    ld      hl,Player_TerminalVelocity/4
:
    ld      a,h
    ld      [Player_YVelocity],a
    ld      a,l
    ld      [Player_YVelocityS],a
    ; Velocity
    ld      a,[Player_YPos]
    ld      b,a
    ld      a,[Player_YSubpixel]
    add     l
    ld      [Player_YSubpixel],a
    ld      a,[Player_YPos]
    adc     h
    ld      [Player_YPos],a
    call    Player_CheckSubscreenBoundary
    ; fall through
 
.checkCollisionVertical   
    ld      a,[Player_MovementFlags]
    bit     bPlayerIsDead,a
    jp      nz,.yCollideEnd
    ; Vertical Collision
    ld      a,[Player_YVelocity]
    bit     7,a
    jr      z,.bottomCollision
    ; Check Top Collision
    ; Top Left
    ld      a,[Player_YPos]
    sub     Player_HitboxHeight
    jr      nc,:+
    ld      a,[Engine_CurrentScreen]
    and     $30
    jr      z,:++++             ; If this is the top of the level, ceiling should be solid
    jr      :++
:
    ld      l,a
    ld      a,[Player_XPos]
    sub     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileL
    cp      COLLISION_SOLID
    jr      z,:+++
:
    ; Top Right
    ld      a,[Player_YPos]
    sub     Player_HitboxHeight
    jr      nc,:+
    ld      a,[Engine_CurrentScreen]
    and     $30
    jr      z,:++
    jp      .yCollideEnd
:
    ld      l,a
    ld      a,[Player_XPos]
    add     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileR
    cp      COLLISION_SOLID
    jp      nz,.yCollideEnd
:
    ; Collision with ceiling
    ; Clear Velocity
    xor     a
    ld      [Player_YVelocity],a
    ld      [Player_YVelocityS],a
    ; Calculate penetration depth
    ld      a,[Player_YPos]
    ld      c,a
    sub     Player_HitboxHeight
    and     $f
    ld      b,a
    ld      a,16
    sub     b
    ; Push player out of tile
    add     c
    ld      [Player_YPos],a
    jr      .yCollideEnd
.bottomCollision:
    ; Check Bottom Collision
    ld      a,[Player_YPos]
    add     Player_HitboxHeight
    jr      c,:+
    ld      l,a
    ld      a,[Player_XPos]
    sub     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileL
    cp      COLLISION_TOPSOLID
    jr      nz,.nottopsolid1
    ld      b,a
    ld      a,[sys_btnHold]
    bit     btnDown,a
    ld      a,b
    jr      nz,.nottopsolid1
    jr      :++
.nottopsolid1
    cp      COLLISION_SOLID
    jr      z,:++
:
    ld      a,[Player_YPos]
    add     Player_HitboxHeight
    jr      c,.yCollideEnd
    ld      l,a
    ld      a,[Player_XPos]
    add     Player_HitboxWidth
    push    af
    ld      h,a
    call    GetTileCoordinates
    ld      e,a
    pop     af
    call    GetTileR
    cp      COLLISION_TOPSOLID
    jr      nz,.nottopsolid2
    ld      b,a
    ld      a,[sys_btnHold]
    bit     btnDown,a
    ld      a,b
    jr      nz,.nottopsolid2
    jr      :+
.nottopsolid2
    cp      COLLISION_SOLID
    jr      nz,.yCollideEnd
:
    ; Collision with floor
    ; Calculate penetration depth
    ld      a,[Player_YPos]
    push    af
    add     Player_HitboxHeight
    and     $f
    inc     a
    ld      b,a
    pop     af
    ; Push player out of tile
    sub     b
    ld      [Player_YPos],a
    ; Reset velocity
    xor     a
    ld      [Player_YVelocity],a
    ld      [Player_YVelocityS],a
    ; Reset airborne flag
    ld      a,[Player_MovementFlags2]
    res     bPlayerIsAirborne,a
    ld      [Player_MovementFlags2],a
    ; call    Player_Jump
.yCollideEnd:
    ld      a,[Player_YVelocity]
    and     a
    jr      z,:+
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsAirborne,[hl]
    jr      nz,:+
    set     bPlayerIsAirborne,[hl]
:   ld      a,[Player_XVelocity]
    bit     7,a
    jr      z,:+
    cpl
    inc     a
:   ld      b,a
    ld      a,7
    sub     b
    ld      [Player_RunAnimSpeed],a
    call    AnimatePlayer
    ; update position buffers
    ld      a,[sys_CurrentFrame]
    and     7
    ld      e,a
    ld      hl,Player_XPosBuffer
    add     l
    ld      l,a
    jr      nc,:+
    inc     h
:   ld      a,[Player_XPos]
    ld      [hl],a
    ld      a,e
    
    ld      hl,Player_YPosBuffer
    add     l
    ld      l,a
    jr      nc,:+
    inc     h
:   ld      a,[Player_YPos]
    ld      [hl],a
    ld      a,e
    
    ret
    
Player_Jump:
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsAirborne,a
    ret     nz
    set     bPlayerIsAirborne,a
    ld      [Player_MovementFlags2],a
    
    PlaySFX Jump
    
    ld      a,[Player_LastJumpY]
    add     7
    ld      b,a
    ld      a,[Player_YPos]
    add     7
    ld      [Player_LastJumpY],a
    push    af
    cp      b                       ; compare previous Jump Y with current Jump Y
    jr      nc,.skipcamtrack        ; if old Y < new Y, skip tracking
    ld      a,1
    ld      [Engine_CameraIsTracking],a
.skipcamtrack
    pop     af
.checkup
    sub     SCRN_Y / 2
    jr      nc,.checkdown
    xor     a
    jr      .setcamy
.checkdown
    cp      256 - SCRN_Y
    jr      c,.setcamy
    ld      a,256 - SCRN_Y
.setcamy
    and     %11110000
    ld      [Engine_BounceCamTarget],a

    ld      a,[Player_MovementFlags]
    bit     bPlayerIsUnderwater,a
    jr      nz,.water

    ld      a,high(Player_JumpHeight)
    ld      [Player_YVelocity],a
    ld      a,low(Player_JumpHeight)
    ld      [Player_YVelocityS],a
    ret
    
.water
    ld      a,high(Player_WaterJumpHeight)
    ld      [Player_YVelocity],a
    ld      a,low(Player_WaterJumpHeight)
    ld      [Player_YVelocityS],a
    ret
    
Player_WallJump:
    ret
;    ld      a,[Player_LastJumpY]
;    add     7
;    ld      b,a
;    ld      a,[Player_YPos]
;    add     7
;    ld      [Player_LastJumpY],a
;    push    af
;    cp      b                       ; compare previous Jump Y with current Jump Y
;    jr      nc,.skipcamtrack        ; if old Y < new Y, skip tracking
;    ld      a,1
;    ld      [Engine_CameraIsTracking],a
;.skipcamtrack
;    pop     af
;.checkup
;    sub     SCRN_Y / 2
;    jr      nc,.checkdown
;    xor     a
;    jr      .setcamy
;.checkdown
;    cp      256 - SCRN_Y
;    jr      c,.setcamy
;    ld      a,256 - SCRN_Y
;.setcamy
;    and     %11110000
;    ld      [Engine_BounceCamTarget],a

;    ld      a,[Player_MovementFlags]
;    bit     bPlayerIsUnderwater,a
;    jr      nz,.water

;    ld      a,[sys_btnHold]
;    bit     btnA,a
;    ret     z
;    ld      a,high(Player_HighWallJumpHeight)
;    ld      [Player_YVelocity],a
;    ld      a,low(Player_HighWallJumpHeight)
;    ld      [Player_YVelocityS],a
;    ret

;.water
;    ld      a,[sys_btnHold]
;    bit     btnA,a
;    jr      nz,.highJumpwater
;    bit     btnB,a
;    ret     nz
;.normalJumpwater
;    ld      a,high(Player_WallJumpHeight/2)
;    ld      [Player_YVelocity],a
;    ld      a,low(Player_WallJumpHeight/2)
;    ld      [Player_YVelocityS],a
;    ret
;.highJumpwater
;    ld      a,high(Player_HighWallJumpHeight/2)
;    ld      [Player_YVelocity],a
;    ld      a,low(Player_HighWallJumpHeight/2)
;    ld      [Player_YVelocityS],a
;    ret
    
; ========

Player_GetSpeedCapL:
    push    hl
    ld      hl,Player_XSpeedCapNeg
    ld      a,[hl+]
    ld      e,a
    ld      a,[hl]
    ld      d,a
    pop     hl
    ret

Player_GetSpeedCapR:
    push    hl
    ld      hl,Player_XSpeedCap
    ld      a,[hl+]
    ld      b,[hl]
    ld      c,a
    pop     hl
    ret

Player_GetSpeedCapL2:
    ld      hl,Player_XSpeedCapNeg
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    ret   

Player_GetSpeedCapR2:
    ld      hl,Player_XSpeedCap
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    ret

Player_AccelerateLeft:
    ld      a,[Player_MovementFlags]
    bit     bPlayerAccelerating,a
    jr      nz,:+
    ld      hl,Anim_Player_Run
    call    Player_SetAnimation
    set     bPlayerAccelerating,a
:   res     bPlayerMaxSpeed,a
    ld      [Player_MovementFlags],a
    bit     bPlayerIsUnderwater,a
    jp      nz,.accelLeftWater
    push    bc
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,a
    jr      nz,.dashleft
    ld      bc,-Player_Accel
    jr      :+
.dashleft
    ld      bc,-Player_DashAccel
:   ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    add     hl,bc
    ld      b,h
    ld      c,l
    call    Player_GetSpeedCapL
    call    Compare16
    jr      nc,:++
    ld      de,$8000
    call    Compare16
    jr      c,:++
    ld      hl,Player_MovementFlags
    set     bPlayerMaxSpeed,[hl]
;    ld      hl,Anim_Player_Left2
;    call    Player_SetAnimation
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,[hl]
    jr      z,:+
    ld      hl,Player_MovementFlags2
    set     bPlayerDashMaxSpeed,[hl]
    ld      a,[Player_DashSoundTimer]
    inc     a
    cp      6
    ld      [Player_DashSoundTimer],a
    jr      nz,:+
    xor     a
    ld      [Player_DashSoundTimer],a
    push    hl
    PlaySFX2 DashLoop
    pop     hl
:   call    Player_GetSpeedCapL2
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocityS],a
    pop     bc
    ld      e,%10000000
    
    ; skid sound check
    ld      a,[Player_MovementFlags]
    bit     bPlayerDirection,a
    ret     nz
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsDashing,a
    ret     z
    ld      a,[Player_XVelocity]
    bit     7,a
    ret     nz
    cp      high(Player_DashSpeed-1)
    ret     c
    PlaySFX Skid
    ret
.accelLeftWater
    push    bc
    ld      bc,-Player_Accel/2
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    add     hl,bc
    ld      b,h
    ld      c,l
    ld      de,-Player_WalkSpeedWater
    call    Compare16
    jr      nc,:+
    ld      de,$8000
    call    Compare16
    jr      c,:+
    ld      hl,Player_MovementFlags
    set     bPlayerMaxSpeed,[hl]
;    ld      hl,Anim_Player_Left2
;    call    Player_SetAnimation
    ld      hl,-Player_WalkSpeedWater
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocityS],a
    pop     bc
    ld      e,%10000000
    ret

Player_AccelerateRight:
    ld      a,[Player_MovementFlags]
    bit     bPlayerAccelerating,a
    jr      nz,:+
    ld      hl,Anim_Player_Run
    call    Player_SetAnimation
    set     bPlayerAccelerating,a
:   res     bPlayerMaxSpeed,a
    ld      [Player_MovementFlags],a
    bit     bPlayerIsUnderwater,a
    jp      nz,.accelRightWater
    push    bc
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,a
    jr      nz,.dashright
    ld      bc,Player_Accel
    jr      :+
.dashright
    ld      bc,Player_DashAccel
:   ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    add     hl,bc
    ld      d,h
    ld      e,l
    call    Player_GetSpeedCapR
    call    Compare16
    jr      nc,:++
    ld      bc,$8000
    call    Compare16
    jr      c,:++
    ld      a,[Player_MovementFlags]
    set     bPlayerMaxSpeed,a
    ld      [Player_MovementFlags],a
;    ld      hl,Anim_Player_Right2
;    call    Player_SetAnimation
    ld      hl,Player_MovementFlags2
    bit     bPlayerIsDashing,[hl]
    jr      z,:+
    ld      hl,Player_MovementFlags2
    set     bPlayerDashMaxSpeed,[hl]
    ld      a,[Player_DashSoundTimer]
    inc     a
    cp      6
    ld      [Player_DashSoundTimer],a
    jr      nz,:+
    xor     a
    ld      [Player_DashSoundTimer],a
    push    hl
    PlaySFX2 DashLoop
    pop     hl
:   call    Player_GetSpeedCapR2
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocityS],a
    pop     bc
    ld      e,%00000000
    
    
    ; skid sound check
    ld      a,[Player_MovementFlags]
    bit     bPlayerDirection,a
    ret     z
    ld      a,[Player_MovementFlags2]
    bit     bPlayerIsDashing,a
    ret     z
    ld      a,[Player_XVelocity]
    bit     7,a
    ret     z
    cp      -(high(Player_DashSpeed-1))
    ret     nc
    PlaySFX Skid
    ret
.accelRightWater
    push    bc
    ld      bc,Player_Accel/2
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      l,[hl]
    ld      h,a
    add     hl,bc
    ld      d,h
    ld      e,l
    ld      bc,Player_WalkSpeedWater
    call    Compare16
    jr      nc,:+
    ld      bc,$8000
    call    Compare16
    jr      c,:+
    ld      a,[Player_MovementFlags]
    set     bPlayerMaxSpeed,a
    ld      [Player_MovementFlags],a
;    ld      hl,Anim_Player_Right2
;    call    Player_SetAnimation
    ld      hl,Player_WalkSpeedWater
:   ld      a,h
    ld      [Player_XVelocity],a
    ld      a,l
    ld      [Player_XVelocityS],a
    pop     bc
    ld      e,%00000000
    ret
    

; ========
    
DrawPlayer:
    ; load correct frame in player VRAM area
    ld      a,[sys_CurrentBank]
    push    af
    ld      a,[Player_CurrentFrame]
    ld      e,a
    ld      d,0
    ldfar   hl,SpritePointers
    add     hl,de
    add     hl,de
    add     hl,de
    
    ld      a,[hl+]
    ld      b,a
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a

    ld      a,[Engine_CameraX]
    ld      d,a
    ld      a,[Player_XPos]
    sub     d
    add     10
    xor     $80
    ld      d,a
    ld      a,[Engine_CameraY]
    ld      e,a
    ld      a,[Player_YPos]
    add     15
    sub     e
    xor     $80
    ld      e,a
    
    push    bc
    ld      c,0
    ld      a,[Player_MovementFlags]
    bit     bPlayerDirection,a
    jr      z,:+
    inc     c
:   call    DrawMetasprite
    pop     bc
    
    
    ld      a,[Player_MovementFlags2]
    bit     bPlayerDashMaxSpeed,a
    jp      z,.notrail
    bit     bPlayerIsDashing,a
    jp      z,.notrail
    
    ; check if we're at max speed
    push    hl
    ld      hl,Player_XVelocity
    ld      a,[hl+]
    ld      c,[hl]
    ld      b,a
    bit     7,b
    jr      z,:+
    ld      a,b
    cpl
    inc     a
    ld      b,a
:   ld      hl,Player_XSpeedCap
    ld      a,[hl+]
    ld      d,[hl]
    ld      e,a
    call    Compare16
    pop     hl
    jp      nz,.notrail
    
.trail1
    ld      a,[sys_CurrentFrame]
    and     1
    jr      nz,.skiptrail1
    jr      .trail2
.skiptrail1

.trail2
    ld      a,[sys_CurrentFrame]
    and     3
    jr      nz,.skiptrail2
    jr      .trail3
.skiptrail2

.trail3
    ld      a,[sys_CurrentFrame]
    and     7
    jr      nz,.skiptrail3
    jr      .donetrail
.skiptrail3
    jr      .donetrail

.notrail
;    xor     a
;    rept    4*8
;    ld      [hl+],a
;    endr
    ld      hl,Player_MovementFlags2
    res     bPlayerDashMaxSpeed,[hl]

.donetrail
    ld      a,[Metasprite_OAMPos]
    ld      [Sprite_NextSprite],a
    pop     bc
    rst     Bankswitch
    ret

; ====

KillPlayer:
    ld      hl,Player_MovementFlags
    bit     bPlayerIsDead,[hl]
    ret     nz
    push    bc
    xor     a
    ld      [Player_XVelocity],a
    ld      [Player_XVelocityS],a
    ld      [Player_YVelocityS],a
    ld      a,-4
    ld      [Player_YVelocity],a
    set     bPlayerIsDead,[hl]
    ld      a,1
    ld      [Engine_LockCamera],a
;    ld      hl,Anim_Player_Hurt
;    call    Player_SetAnimation
    ; PlaySFX death
    call    Player_SeeingStars
    pop     bc
    ret
    
Player_Respawn:
    call    PalFadeOutWhite
    ld      a,2
;    farcall ; DSX_Fade
;:   halt
;	ld		a,[sys_FadeState]
;    and     a
;    jr      nz,:-
    call    AllPalsWhite
    call    UpdatePalettes
:   halt
	; ld	  a,[; DSX_FadeType]
    ; and     a
    ; jr      nz,:-
    ; halt
    xor     a
    ldh     [rLCDC],a
    ld      a,[Player_LifeCount]
    and     a
    jr      nz,:+
    jp      GM_GameOver
:   dec     a
    ld      [Player_LifeCount],a
    ; restore stack
    pop     hl
    pop     hl
    ld      a,[Engine_LevelID]
    jp      GM_Level

Player_RollCoinCounter:
	ld		hl,Player_CoinCount
	ld		a,[hl+]
	ld		b,[hl]
	ld		c,a
	ld		hl,Player_CoinCountHUD
	ld		a,[hl+]
	ld		h,[hl]
	ld		l,a
	ld		d,h
	ld		e,l
	call	Compare16
	ret		z
	
	jr		c,.rolldown
.rollup
	inc		hl
	jr		:+
.rolldown
	dec		hl
:	ld		a,l
	ld		[Player_CoinCountHUD],a
	ld		a,h
	ld		[Player_CoinCountHUD+1],a
	ret
   
Player_Splash:
    ; left splash particle
    call    GetParticleSlot
    ld      [hl],4
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    sub     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],32
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high(-$0020)
    
    ld      a,low(-$0020)
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],a
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0240)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0240)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY
    
    ; right splash particle
    call    GetParticleSlot
    ld      [hl],4
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    add     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],32
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high($0020)
    
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],low($0020)
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0240)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0240)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1 | OAMF_XFLIP | OAMF_YFLIP
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY

    ret

Player_SeeingStars:
    ; bottom left star particle
    call    GetParticleSlot
    ld      [hl],6
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    sub     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],64
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high(-$0020)
    
    ld      a,low(-$0020)
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],a
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0480)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0480)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY
    
    ; bottom right star particle
    call    GetParticleSlot
    ld      [hl],6
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    add     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],64
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high($0020)
    
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],low($0020)
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0480)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0480)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1 | OAMF_XFLIP
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY

    ; top left star particle
    call    GetParticleSlot
    ld      [hl],8
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    sub     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],64
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high(-$0038)
    
    ld      a,low(-$0038)
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],a
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0500)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0500)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY
    
    ; top right star particle
    call    GetParticleSlot
    ld      [hl],8
    
    ld      hl,Particle_XPosition
    add     hl,bc
    ld      a,[Player_XPos]
    add     4
    ld      [hl],a
    
    ld      hl,Particle_YPosition
    add     hl,bc
    ld      a,[Player_YPos]
    ld      [hl],a
    
    ld      hl,Particle_Lifetime
    add     hl,bc
    ld      [hl],64
    
    ld      hl,Particle_XVelocity
    add     hl,bc
    ld      [hl],high($0038)
    
    ld      hl,Particle_XVelocityS
    add     hl,bc
    ld      [hl],low($0038)
    
    ld      hl,Particle_YVelocity
    add     hl,bc
    ld      [hl],high(-$0500)
    
    ld      hl,Particle_YVelocityS
    add     hl,bc
    ld      [hl],low(-$0500)
    
    ld      hl,Particle_Attribute
    add     hl,bc
    ld      [hl],OAMF_BANK1 | OAMF_XFLIP
    
    ld      hl,Particle_Flags
    add     hl,bc
    ld      [hl],1<<PARTICLE_FLAG_GRAVITY
    ret

; INPUT: a = current Y position
;        b = previous Y position
Player_CheckSubscreenBoundary:
    ld      hl,Player_MovementFlags
    bit     bPlayerStageEnd,[hl]
    ret     nz
	bit		bPlayerIsDead,[hl]
	ret		nz
    ld      e,a
    ld      a,[Player_YVelocity]
    bit     7,a
    ld      a,e
    jr      nz,.up
.down
    cp      b
    ret     nc
    jp      Level_TransitionDown
.up
    cp      b
    ret     z
    ret     c
    jp      Level_TransitionUp
    
; ===================
; Animation constants
; ===================

C_SetAnim       = $80
C_ToggleLock    = $81C_AnimSpeed     = $ff

; ================
; Animation macros
; ================

NUM_ANIMS       =   0   ; no touchy!

defanim:        macro
AnimID_\1       = NUM_ANIMS
NUM_ANIMS       =   NUM_ANIMS+1
Anim_\1:
    endm

; ==================
; Animation routines
; ==================

Player_SetAnimation:
    ld      a,[Player_AnimLock]
    and     a
    ret     nz
    ld      a,l
    ld      [Player_AnimPointer],a
    ld      a,h
    ld      [Player_AnimPointer+1],a
    ld      a,1
    ld      [Player_AnimTimer],a
    ret

AnimatePlayer:
    ld      a,[Player_AnimTimer]
    cp      -1
    ret     z   ; return if current frame time = -1
    dec     a
    ld      [Player_AnimTimer],a
    ret     nz  ; return if anim timer > 0

    ; get anim pointer
    ld      a,[Player_AnimPointer]
    ld      l,a
    ld      a,[Player_AnimPointer+1]
    ld      h,a
    
    ; get frame / command number
.getEntry
    ld      a,[hl+]
    bit     7,a
    jr      nz,.cmdProc
    ld      [Player_CurrentFrame],a
    ld      a,[hl+]
    cp      C_AnimSpeed
    jr      nz,:+
    ld      a,[hl+]
    push    hl
    ld      h,[hl]
    ld      l,a
    ld      a,[hl]
    pop     hl
    inc     hl
:   ld      [Player_AnimTimer],a
.doneEntry
    ld      a,l
    ld      [Player_AnimPointer],a
    ld      a,h
    ld      [Player_AnimPointer+1],a
    ret
    
.cmdProc
    push    hl
    ld      hl,.cmdProcTable
    add     a
    add     l
    ld      l,a
    jr      nc,.nocarry
    inc     h
.nocarry
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    jp      hl
    
.cmdProcTable:
    dw      .setAnim
    dw      .toggleLock
    
.setAnim
    pop     hl
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    jr      .getEntry

.toggleLock
    pop     hl
    ld      a,[Player_AnimLock]
    xor     1
    ld      [Player_AnimLock],a
    jr      .getEntry

; ==============
; Animation data
; ==============

; Animation format:
; XX YY
; XX = Frame ID / command (if bit 7 set)
; YY = Wait time (one byte) / command parameter (can be more than one byte)

   defanim Player_Idle
   db   F_Player_Idle1,8
   db   F_Player_Idle2,8
   db   F_Player_Idle3,8
   db   F_Player_Idle4,8
   db   F_Player_Idle5,8
   db   F_Player_Idle6,8
   db   F_Player_Idle7,8
   db   F_Player_Idle8,8
   dbw  C_SetAnim,Anim_Player_Idle
   
   defanim Player_Run
   db   F_Player_Run1,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed)
   db   F_Player_Run2,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed)
   db   F_Player_Run3,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed)
   db   F_Player_Run4,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed)
   db   F_Player_Run5,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed) 
   db   F_Player_Run6,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed) 
   db   F_Player_Run7,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed) 
   db   F_Player_Run8,C_AnimSpeed,low(Player_RunAnimSpeed),high(Player_RunAnimSpeed)
   dbw  C_SetAnim,Anim_Player_Run
   
   defanim Player_IdleEscape
   db   F_Player_IdleEscape1,4
   db   F_Player_IdleEscape2,4
   db   F_Player_IdleEscape3,4
   db   F_Player_IdleEscape2,4
   db   F_Player_IdleEscape1,4
   db   F_Player_IdleEscape2,4
   db   F_Player_IdleEscape4,4
   db   F_Player_IdleEscape2,4
   dbw  C_SetAnim,Anim_Player_IdleEscape
   
   defanim Player_CoffeeSteam
   db   F_Player_CoffeeSteam1,2
   db   F_Player_CoffeeSteam2,2
   db   F_Player_CoffeeSteam3,2
   db   F_Player_CoffeeSteam4,2
   db   F_Player_CoffeeSteam5,2
   dbw  C_SetAnim,Anim_Player_IdleEscape
   
; ================================

PLAYER_NUM_SPRITES = 0

macro defsprite
section fragment "Player sprite graphics - \1",romx
SpriteGFX_Player_\1:
    dw SpriteGFX_Player_\1_Start
section fragment "Player sprite graphics - \1",romx,align[8]
SpriteGFX_Player_\1_Start:
    incbin "GFX/Player/\1.2bpp"
SpriteGFX_Player_\1_End:
;section "Player sprite definition - \1",romx
SpriteDef_Player_\1:
    db  ((SpriteGFX_Player_\1_End-SpriteGFX_Player_\1_Start)/$10)-1
    db  bank(SpriteGFX_Player_\1)
    dw  SpriteGFX_Player_\1
    include "GFX/Player/\1.sdef"
    const F_Player_\1
if DebugMode
section fragment "Sprite name pointers",romx
    dw  SpriteName_\1
section fragment "Sprite names",romx
SpriteName_\1:
    db  strupr("\1")
    db  0
section fragment "Sprite pointers",romx
    db  bank(SpriteDef_Player_\1)
    dw  SpriteDef_Player_\1
endc
PLAYER_NUM_SPRITES = PLAYER_NUM_SPRITES + 1
endm

if DebugMode
section fragment "Sprite pointers",romx
SpritePointers:

section fragment "Sprite names",romx
SpriteNames:

section fragment "Sprite name pointers",romx
SpriteNamePointers:
endc

section "Player GFX",romx,align[8]
PlayerSprites:
    const_def
    defsprite Idle1
    defsprite Idle2
    defsprite Idle3
    defsprite Idle4
    defsprite Idle5
    defsprite Idle6
    defsprite Idle7
    defsprite Idle8
    defsprite Run1
    defsprite Run2
    defsprite Run3
    defsprite Run4
    defsprite Run5
    defsprite Run6
    defsprite Run7
    defsprite Run8
;    defsprite Jump
;    defsprite Fall1
;    defsprite Fall2
;    defsprite Fall3
;    defsprite Fall4
;    defsprite Dash1
;    defsprite Dash2
;    defsprite Dash3
;    defsprite Dash4
    defsprite IdleEscape1
    defsprite IdleEscape2
    defsprite IdleEscape3
    defsprite IdleEscape4
    defsprite CoffeeSteam1
    defsprite CoffeeSteam2
    defsprite CoffeeSteam3
    defsprite CoffeeSteam4
    defsprite CoffeeSteam5
;    defsprite CoffeeRun1
;    defsprite CoffeeRun2
;    defsprite CrabIdle
;    defsprite CrabWalk
;    defsprite CrabAttack
;    defsprite LamiaIdle
;    defsprite LamiaSlither
;    defsprite LamiaJump
;    defsprite LamiaAttack
;    defsprite LamiaClimb
;    defsprite WerewolfIdle1
;    defsprite WerewolfIdle2
;    defsprite WerewolfIdle3
;    defsprite WerewolfIdle4
;    defsprite WerewolfIdle5
;    defsprite WerewolfIdle6
;    defsprite WerewolfIdle7
;    defsprite WerewolfIdle8
;    defsprite WerewolfWalk1
;    defsprite WerewolfWalk2
;    defsprite WerewolfWalk3
;    defsprite WerewolfWalk4
;    defsprite WerewolfWalk5
;    defsprite WerewolfWalk6
;    defsprite WerewolfWalk7
;    defsprite WerewolfWalk8
;    defsprite WerewolfDash1
;    defsprite WerewolfDash2
;    defsprite WerewolfDash3
;    defsprite WerewolfDash4
;    defsprite WerewolfJump
;    defsprite WerewolfFall
    

; ================================
