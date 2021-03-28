	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
    #a0 = &w; a1 = 31
    addiu $sp, $sp, -44 #On 40 bytes son pel vector com en v.local i 4 son per guardar el ra de tornada
    #int histo[10]: 0(sp), int k: s0, char max: s1;; ra: 40(sp), a1: no cal, a2: no cal
    #sw $a0, 40($sp) no cal guardar 
    #sw $a1, 44($sp) no cal guardar (2)
    sw $ra, 40($sp)
for1:
    move $t1, $sp
    addiu $t2, $t1, 40
    bgeu $t1, $t2, end1
loop1:
    sw $zero, 0($t1)
    addiu $t1, $t1, 4
    bltu $t1, $t2, loop1
end1:
#final del primer for, on tots els elements de histo son equivalents a 0
    
    move $s0, $a0 #guardem &w en a0 (també anomenat: &vec, IMPORTANT: vec / w és char)
    move $s1, $a1 #guardem 31 en a1
    li $s2, '0' #guardem '0' en s2 ---> s2 és el nostre char max, llavors no cal guardar a memòria
    li $s3, 0 #guardem 0 a s3 ----> s3 és el nostre int k, llavors no cal guardar a memòria

#nou loop for on haurem d'entrar a una altre funció (8)
for2:
    bgeu $s3, $s1, endfor
loop2:
    #preparem els paràmetres nous: a0 = &histo (fem un move $a0, $sp), 
    move $a0, $sp
    #w[k]-'0' --> (&vec + k) - '0'
    addu $a1, $s0, $s3
    lb $a1, 0($a1)
    addiu $a1, $a1, -48
    #max-'0'
    addiu $a2, $s2, -48
    
    #crida a la funció update
    jal update
    #havent tornat de update, hem recuperat s0, s1, s2
    addiu $s2, $v0, 48 #max = update + '0'
    addiu $s3, $s3, 1 #k++
    bltu $s3, $s1, loop2

endfor:
    #guardem max a v0 per fer el return (1)
    move $v0, $s2
    #load word de l'antic ra
    lw $ra, 40($sp)
    #destrucció del b.activació
    addiu $sp, $sp, 44
    jr $ra


update:
#en aquesta funció, tenim 3 paràmetres: a0 = &histo, a1 = char i, a2 = char imax
#compte! el vector histo, o int h, es passa com a punter, és a dir, que tot canvi s'ha de guardar
#guardar registres segurs i expandir el $sp
    addiu $sp, $sp, -16 #perquè volem guardar a s0-s2 els tres paràmetres a0-a1 i el ra a main
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $ra, 12($sp)

    #guardem ses registres: a0, a1, a2 a s0, s1, s2
    move $s0, $a0 #histo[] en s0
    move $s1, $a1 #i en s1
    move $s2, $a2 #imax en s2

    jal nofares

    #h[i]++ ---> vector h (&h en s0 and char i en s1)
    sll $t0, $s1, 2 #char i * 4 == int i
    addu $t0, $s0, $t0 #&h + i --> t0
    lw $t1, 0($t0) #t1 = h[i]
    addiu $t1, $t1, 1 #contingut de h[i] + 1 guardat a t1
    sw $t1, 0($t0) #h[i] = h[i] + 1 = t1 (es guarda al vector, i com es descriu al enunciat, es pasa per referència)
    

#preparar imax per el if(2)
    sll $t2, $s2, 2 #char imax * 4 == int char imax
    addu $t2, $s0, $t2 #&h + imax ---> t2
    lw $t2, 0($t2) #t2 = h[imax]


if:
    bleu $t1, $t2, else #si t1 <= t2, llavors fem branch a endif //t1 = h[i]; t2 = h[imax]
    move $v0, $s1
    b endif #preparem el return
else:
    move $v0, $s2

endif:
    #recuperem els registres guardats
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    #tanquem el bloc d'activació
    addiu $sp, $sp, 16
    #tornem a moda
    jr $ra






	


