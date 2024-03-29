
; Monster Mansion
; Music Data

MusicPointers:
    dw  Mus_Intro

; ================================================================

Ins_PulseEcho1:
    dw  Vol_Echo,DSX_DummyTable,Pulse_Square,DSX_DummyTable
    dw  Vol_EchoR,0,0,0
Ins_Lead1:
    dw  Vol_Lead1,DSX_DummyTable,Pulse_Lead1,Vib_Lead1
    dw  Vol_Lead1R,0,0,0
Ins_WaveBass1:
    dw  Vol_WaveBass1,DSX_DummyTable,Wave_Bass1,DSX_DummyTable
    dw  0,0,0,0
Ins_WaveBass1Hold:
    dw  Vol_WaveBass1Hold,DSX_DummyTable,Wave_Bass1,DSX_DummyTable
    dw  0,0,0,0
Ins_WaveBass1Long:
    dw  Vol_WaveBass1Long,DSX_DummyTable,Wave_Bass1,DSX_DummyTable
    dw  0,0,0,0
Ins_SoftKick:
    dw  Vol_Kick,Arp_SoftKick,Noise_SoftKick,DSX_DummyTable
    dw  0,0,0,0
Ins_Kick:
    dw  Vol_Kick,Arp_Kick,Noise_Kick,DSX_DummyTable
    dw  0,0,0,0
Ins_Snare:
    dw  Vol_Snare,Arp_Snare,Noise_Snare,DSX_DummyTable
    dw  0,0,0,0
Ins_CHH:
    dw  Vol_CHH,Arp_CHH,Noise_CHH,DSX_DummyTable
    dw  0,0,0,0
Ins_OHH:
    dw  Vol_OHH,Arp_OHH,Noise_OHH,DSX_DummyTable
    dw  0,0,0,0
Ins_Cymbal:
    dw  Vol_Cymb,Arp_Cymb,Noise_Cymb,DSX_DummyTable
    dw  0,0,0,0
Ins_CymbR:
    dw  Vol_CymbR,Arp_CymbR,Noise_OHH,DSX_DummyTable
    dw  0,0,0,0

; ----------------

Vol_Lead1:
    db  12,12,11,seq_wait,3,10,seq_wait,4,9,seq_end
Vol_Lead1R:
    db  8,seq_wait,10
    db  7,seq_wait,10
    db  6,seq_wait,10
    db  5,seq_wait,10
    db  4,seq_wait,10
    db  3,seq_wait,10
    db  2,seq_wait,10
    db  1,seq_wait,10
    db  0,seq_end
Vol_Echo:
    db  15,13,12,10,9,8,7,7,6,6,5,5,5,4,4,3,3,3,2,seq_wait,3,1,seq_wait,3,0,seq_end
Vol_EchoR:
    db  $85,seq_end
Vol_WaveBass1:
    db  $20,seq_wait,4,$40,$40,$60,0,0,$60,seq_end
Vol_WaveBass1Hold:
    db  $20,seq_end
Vol_WaveBass1Long:
    db  $20,seq_wait,47,$40,seq_wait,23,$60,seq_wait,23,seq_end
Vol_Kick:
    db  $f1,seq_wait,3,$10,$42,seq_end
Vol_Snare:
    db  $c1,seq_end
Vol_CHH:
    db  $61,$30,$30,$24,seq_end
Vol_OHH:
    db  $62,seq_wait,6,seq_end
Vol_Cymb:
    db  $87,seq_end
Vol_CymbR:
    db  $18,seq_end
    
; ----------------

Arp_Kick:
    db  19,15,15,15,36,36,42,seq_end
Arp_SoftKick:
    db  18,18,43,seq_end
Arp_Snare:
    db  29,23,20,35,seq_end
Arp_CHH:
    db  43,seq_end
Arp_Cymb:
    db  26
    ; fall through
Arp_OHH:
Arp_CymbR:
    db  41,seq_end

; ----------------

Pulse_Square:
    db  2,seq_end
Pulse_Lead1:
    db  2,0,seq_wait,2
:   db  1,seq_wait,11
    db  0,seq_wait,11
    db  1,seq_wait,11
    db  2,seq_wait,11
    db  seq_loop,(:- -@) -1
    db  0
    ; fall through
Wave_Bass2:
    db  1,seq_end
Noise_Kick:
    db  1
    ; fall through
Noise_Snare:
    db  1
    ; fall through
Noise_SoftKick:
    db  1
    ; fall through
Noise_Cymb:
    db  1
    ; fall through
Wave_Bass1:
Noise_CHH:
Noise_OHH:
    db  0,seq_end
 
; ----------------

Vib_Lead1:
    db  9
:   db  2,4,4,2,0,-2,-4,-4,-2,0
    db  pitch_loop,(:- -@) -1

; ================================================================

DSX_DefaultWave:
DSX_Wavetables:
    db  $8A,$BE,$FF,$FF,$FF,$B6,$20,$00,$8F,$FF,$D8,$30,$00,$00,$00,$35 ; bass 1

; ================================================================

DSX_Songs:
Mus_Intro:
    db  6,6
    dw  Mus_Intro_CH1
    dw  Mus_Intro_CH2
    dw  Mus_Intro_CH3
    dw  Mus_Intro_CH4
    
NUM_SONGS = (@ - DSX_Songs) / 10

; ================================================================

Mus_Intro_CH1:
    sound_instrument Ins_PulseEcho1
    rest    4
    note    D#,5,1
    release 1
    note    A#,4,1
    release 1
    note    F#,5,1
    release 1
    note    A#,4,1
    release 1
    note    D#,5,1
    release 1
    note    A#,4,1
    release 1
    note    F_,5,1
    release 1
    note    F#,5,1
    release 1
    note    F_,5,1
    release 1
    note    C#,5,1
    release 1
    note    F#,5,1
    release 1
    note    C#,5,1
    release 1
    note    F_,5,1
    release 1
    note    F#,5,1
    release 1
    note    F_,5,1
    release 1
    note    C#,5,1
    release 1
    sound_set_speed 5,5
    sound_call .block1
    sound_volume 8
    sound_call .block1
    sound_volume 4
    sound_call .block1
    sound_volume 2
    sound_call .block1
    sound_volume 1
    sound_call .block1
    rest 1
    sound_end
.block1
    note    G#,4,1
    note    A#,4,1
    note    C#,5,1
    note    D#,5,1
    sound_ret

; ----------------

Mus_Intro_CH2:
    sound_instrument Ins_Lead1
    rest 4
    note D#,4,2
    note F_,4,2
    note F#,4,2
    note A#,4,4
    note D#,4,2
    note C#,4,2
    note D#,4,2
    note F_,4,4
    note F#,4,4
    note F_,4,2
    note C#,4,2
    note G#,3,2
    note A#,3,6
    release 16
    sound_end

; ----------------

Mus_Intro_CH3:
    sound_instrument Ins_WaveBass1Hold
    note G_,3,0
    sound_slide_down 15
    wait 4
    sound_instrument Ins_WaveBass1
    note D#,2,2
    note D#,3,2
    note D#,2,1
    note D#,3,2
    note D#,2,1
    note D#,3,2
    note D#,2,1
    note D#,3,2
    note D#,2,1
    note D#,3,1
    note D#,2,1
    note C#,2,2
    note C#,3,2
    note C#,2,1
    note C#,3,2
    note C#,2,1
    note F#,3,2
    note F#,2,1
    note F#,3,2
    note F#,2,1
    note F#,3,1
    note F#,2,1
    sound_instrument Ins_WaveBass1Long
    note B_,2,20
    rest 1
    sound_end

; ----------------

Mus_Intro_CH4:
    sound_call .block1
    sound_call .block2
    sfixins Ins_OHH,2
    sound_call .block2
    sfix 1
    sfix 1
    sfixins Ins_Cymbal,16
    sound_end

.block1
    sfixins Ins_Snare,2
    sfix 1
    sfix 1
    sound_ret

.block2
    sfixins Ins_SoftKick,1
    sfixins Ins_CHH,1
    sfixins Ins_OHH,2
    sfixins Ins_Snare,2
    sfixins Ins_OHH,2
    sfixins Ins_SoftKick,1
    sfixins Ins_CHH,1
    sfixins Ins_OHH,1
    sfixins Ins_SoftKick,1
    sfixins Ins_Snare,2
    sound_ret

; ================================================================