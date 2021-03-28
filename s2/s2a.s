	.data

	.text
	.globl main
main:
	li $s1, 23 # Y
	li $s0, 8  # X

	li $t1, 1
	sllv $t1, $t1, $s0
	addiu $t1, $t1, -1
	xor $s1, $s1, $t1

	jr $ra
