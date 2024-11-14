.data
array:  .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
# A program to zero the above array 

.text
.globl main
main:  	la   $s0, array     # put base address of array in $s0 
	li   $s1, 16        # put array size in $s1

	move $t0, $zero       # i = 0
loop: 	add  $t1 ,$t0, $t0    # $t1 = i * 2
	add  $t1, $t1, $t1    # $t1 = i * 4
	add  $t2, $s0, $t1    # $t2 = &array[i]
	sw   $zero, 0($t2)    # array[i] = 0
	addi $t0, $t0, 1      # i = i + 1
	slt  $t3, $t0, $s1    # $t3 = (i < array size)
	bne  $t3, $zero, loop # if () go to loop
	nop
             
exit:	j exit			# dead loop; program stops here
	nop 

# end of program
