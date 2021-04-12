	# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
mat1: 	.space 120 #mat1[5][6]
mat4: 	.word 2,3,1,2,4,3
col:	.word 2

	.text 
	.globl main
main:
# Escriu aqui el programa principal
	addiu $sp,$sp,-4
	sw $ra, 0($sp)
	#Només hi ha una subrutina, realment no cal guardar aquest $ra
	la $a0, mat4
	lw $a1, 8($a0) #(0*3+2)*4
	la $a2, col
	lw $s1, 0($a2)
	
	jal subr
	
	la $t1, mat1 #mat1[4][3]
	sw $v0, 108($t1) #(4*6+3)*4=108
	
	la $a0, mat4 #no cal, perquè ja tenim @mat4 a $a0
	li $a1, 1
	li $a2, 1
	
	jal subr
	
	la $t1, mat1
	sw $v0, 0($t1) #guardem $v0 en mat1[0][0]
	
	#en cas d'haver de guardat $ra, el recuperem
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
subr:
# Escriu aqui el codi de la subrutina
	#calculem x[i][j]
	li $t0, 3 #columnes de x[][3]
	multu $t0, $a1 #(3+i)
	mflo $t0
	addu $t0, $t0, $a2 #(3+i+j)
	sll $t0, $t0, 2
	addu $t0, $a0, $t0
	lw $t0, 0($t0)
	#calculem mat1[j][5]
	li $t1, 6
	multu $t1, $a2
	mflo $t1
	addiu $t1, $t1, 5
	sll $t1, $t1, 2
	la $t2, mat1
	addu $t1, $t1, $t2 #@mat1 + (j6+5)4
	lw $t0, 0($t1)
	
	move $v0, $a1
	jr $ra

