# PRACTICA 1 #######################

	.data
A: 	.word 3, 5,7
punter: .word 0
	.text
	.globl main
main:
	

	la $t0, punter
	la $t1, A
	addiu $t1, $t1, 8
	sw $t1, 0($t0)
	
	#la $s2, punter  -- sobra
	#lw $s3 , 0($s2)  -- sobra
	lw $s0, 0($t1) #t1 és A
	addiu $s0, $s0, 2
	
	#la $s2 , punter -- sobra
	#lw $s2, 0($s2) -- sobra
	lw $t2, -8($t1)
	addu $s0,$s0,$t2
	

	sw $s0, -4($t1) 
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	
	jr $ra		# main retorna al codi de startup

