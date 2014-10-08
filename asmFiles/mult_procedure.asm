	org	0x0000	
	ori 	$sp, $0, 0xFFFC
	
	ori	$15, $0, 6
	ori	$14, $0, 5
	ori	$13, $0, 2
	push	$15
	push	$14
	push	$13

	jal 	mult
	jal	mult
	//pop	$10
	halt	
	
mult:	pop	$4	
	pop	$5
	ori	$3, $0, 0
	ori	$2, $0, 1
loop:	addu	$3,$3,$4
	subu	$5,$5,$2
	bne	$5,$0,loop
	push	$3
	jr	$31		

	
