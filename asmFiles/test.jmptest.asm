	org	0x0000
	ori	$1, $zero, 0xBEEF
	ori	$2, $zero, 0xDEAD
	j	jone
	ori	$30, $zero, 0xEEEE
jone:	ori	$3, $zero, 0xAAAA
	ori	$4, $zero, 0xBBBB
	jal	jtwo
	ori	$6, $zero, 0xCCCC
	halt
jtwo:	ori	$5, $zero, 0x5555
	jr	$31
	ori	$30, $zero, 0xFFFF
