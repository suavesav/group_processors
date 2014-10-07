	org	0x0000	
	ori 	$sp, $0, 0xFFFC
	
	lui	$15,6
	lui	$14,5
	lui	$13,2
	push	$15
	push	$14
	push	$13

	jal 	mult
	jal	mult
	//pop	$10
	halt	
	
mult:	pop	$4	
	pop	$5
	lui	$3,0
	lui	$2,1
loop:	addu	$3,$3,$4
	subu	$5,$5,$2
	bne	$5,$0,loop
	push	$3
	jr	$31		

	
