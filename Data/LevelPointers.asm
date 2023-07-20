NUM_LEVELS = 0

addlevel:       macro
include "Levels/\1.inc"
    levelptr    \1
endm

section fragment "Level pointers",rom0
levelptr:       macro
section fragment "Level pointers",rom0
MapID_\1 = NUM_LEVELS
    bankptr Map_\1
NUM_LEVELS = NUM_LEVELS + 1
endm

LevelParallaxFlags:
    ; test map
    db          0

LevelPointers:
    addlevel    TestMap
