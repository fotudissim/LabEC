# PRACTICA 1 #######################

	.data
	A: .word 3, 5,7
	punter: .word 0
	.text
	.globl main
main:
	

	la $t0, A
	la $t1, punter
	addiu $t2, $t0, 8
	sw $t2, 0($t1)
	
	la $s2, punter
	lw $s3 , 0($s2)
	lw $s3, 0($s3)
	addi $s0, $s3, 2
	
	la $s2 , punter
	lw $s2, 0($s2)
	lw $s3, -8($s2)
	add $s0,$s3,$s0
	
	la $s3 , A

	sw $s0,4($s3) 
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	
	
	
	
	




	jr $ra		# main retorna al codi de startup

