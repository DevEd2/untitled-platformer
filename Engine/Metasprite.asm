; Metasprite utility routines

section "Metasprite RAM",wram0
Metasprite_OAMPos:  db

section "Metasprite routines",rom0

; INPUT: hl = pointer to metasprite definition
;         b = bank of metasprite definition
;         d = X coordinate
;         e = Y coordinate
;         c = horizontal flip? (0 = no, 1 = yes)
DrawMetasprite:
    push    de
    push    bc
    rst     Bankswitch
    ; get transfer size
    ld      a,[hl+]
    ld      c,a
    ; get GFX bank
    ld      a,[hl+]
    ld      b,a
    ; get GFX pointer
    push    hl
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    rst     Bankswitch
    ld      a,[hl+]
    ld      h,[hl]
    ld      l,a
    ; setup DMA transfer
    ld      a,1
    ldh     [rVBK],a
    ld      a,l
    ldh     [sys_HDMA2],a
    ld      a,h
    ldh     [sys_HDMA1],a
    xor     a
    ldh     [sys_HDMA4],a
    or      $82
    ldh     [sys_HDMA3],a
    ld      a,c
    ldh     [sys_HDMA5],a
    ld      a,[sys_CurrentBank]
    ldh     [sys_HDMABank],a
    
    pop     hl
    inc     hl
    inc     hl
    pop     de
    rr      e
    jr      nc,.right
    ; transfer to OAM
.left
    pop     bc
    ld      de,OAMBuffer
:   ; TODO: Horizontal flip
    ld      a,[hl+]
    and     a
    jr      z,.done
    add     c
    ld      [de],a
    inc     e
    ld      a,[hl+]
    cpl
    sub     8
    add     b
    ld      [de],a
    inc     e
    ld      a,[hl+]
    ld      [de],a
    inc     e
    ld      a,[hl+]
    set     5,a
    ld      [de],a
    inc     e
    jr      :-
.right
    pop     bc
    ld      de,OAMBuffer
:   ; TODO: Horizontal flip
    ld      a,[hl+]
    and     a
    jr      z,.done
    add     c
    ld      [de],a
    inc     e
    ld      a,[hl+]
    add     b
    ld      [de],a
    inc     e
    ld      a,[hl+]
    ld      [de],a
    inc     e
    ld      a,[hl+]
    ld      [de],a
    inc     e
    jr      :-
    
.done
    ld      a,[Metasprite_OAMPos]
    and     a
    jr      z,:++
    cp      e
    ret     z
    ld      b,a
    ld      a,e
    ld      [Metasprite_OAMPos],a
    sub     b
:   ld      [hl],0
    inc     l
    dec     b
    jr      nz,:-
    ret
:   ld      a,e
    ld      [Metasprite_OAMPos],a
    
    ret