# PRACTICA 1 #######################

	.data
	cadena: .byte -1, -1, -1, -1, -1, -1
	vec: .word 5, 6, 8, 9, 1
	.text
	.globl main
main:
	li $s0, 0
while:	li $t0, 5
	bge $s0, $t0, fi
	la $t0, vec
	li $t1, 4
	subu $t1, $t1, $s0
	sll $t1, $t1, 2
	addu $t0, $t0, $t1
	lw $t0, 0($t0) # $t0 = vec[4-1]
	addiu $t0, $t0, '0'
	la $t1, cadena
	addu $t1, $t1, $s0
	sb $t0, 0($t1)
	
	addiu $s0, $s0, 1
	b while
fi:
	la $t0, cadena
	sb $zero, 5($t0)
	
	li $v0, 4
	la $a0, cadena
	syscall
	
	jr $ra
	