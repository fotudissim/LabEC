	# Sessio 3

	.data 
mat:	.word 0,0,2,0,0,0
	.word 0,0,4,0,0,0
	.word 0,0,6,0,0,0
	.word 0,0,8,0,0,0
resultat:	.word 0
	.text 
	.globl main
main:
# Escriu aqui el teu codi del mai
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, mat
	jal suma_col
	
	la $t0, resultat
	sw $v0, 0($t0)
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	

suma_col:
# Escriu aqui el teu codi de la subrutina
	li $v0, 0
	li $t1, 4
	addiu $t0, $a0, 8
	
for:
	ble $t1, $zero, end
	lw $t2, 0($t0)
	addu $v0, $v0, $t2
	addiu $t0, $t0, 24 #la distància entre cada fila és de 24 bytes
	addiu $t1, $t1, -1
	b for
end:
	jr $ra



