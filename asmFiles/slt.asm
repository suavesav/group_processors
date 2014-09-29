ORG 0x0000
ORI $sp,$0,0xFFFC
LUI $2,2
PUSH $2
LUI $2,6
PUSH $2

JAL sltt
HALT

sltt: POP $2
      POP $3
      SLT $27,$3,$2
      SLT $28,$2,$3
      SLTU $29,$3,$2
      SLTU $30,$2,$3
      JR $31

