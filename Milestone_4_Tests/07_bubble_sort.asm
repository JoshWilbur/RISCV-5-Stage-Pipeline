# Author: Sam Dubuc
# Bubble-sort program
# This program was taken from a MIPS bubble sort implementation
# and minor changes were made to convert it to a RISCV program

.data	# Data Section
iArray:	.word 1 9 2 8 5 6 7 64 16 48 32 512 256 128 
size:   .word 14 

	
		.text	# Code Section
main:
		addi t6, zero, 1 # set t6 to 1 for comparison with t4 and t1
				 # to know when inner/outer loops are done processing
		addi s0, ra, 0		# save return address
		
		la t0, size
		lw s1, 0(t0)         # $s1 <-- array size to $s1		

		# Pass Parameters and Call Procedure
		la a0, iArray		# load base address to $a0
		addi a1, s1, 0	# move size to $a1
		jal bub_sort		# Sorted array starts at $t0
		nop
				
		addi ra, s0, 0	# restore return address

		# load the memory value and check the correctness
		la t0, iArray		# load base address to $a0
		addi t4, s1, 0	# move size to $a1
loop_show:	lw t5, 0(t0)		# $t2=A[i]
		addi t0, t0, 4	# update current address of A[i]
		addi t4, t4, -1	# loop size decreases
		bne t4, t6, loop_show	# test,if not goto loop_show
		nop	

exit:		beq zero, zero, exit	# program stops here		
		nop
		
bub_sort:
		# begin your code
		# $s0 and $s1 are forbidden to use.
		addi t4, a1, 0	# move $a1 to $t4
loop3:				# outer loop
		addi t1, t4, 0	# Inner loop size	
		addi t0, a0, 0	# move $a0 to $t0
loop4:					
		lw t2, 0(t0)		# $t2=A[i]
		lw t3, 4(t0)		# $t3=A[i+1]
		ble t2, t3, skip1	# test for swapping memory elements	
		nop			# delay slot
		sw t2, 4(t0)
		sw t3, 0(t0)		# Completes Swap
skip1:
		addi t0, t0, 4		# update current address of A[i]
		lw t2, 0(t0)		# update A[i]
		addi t1, t1, -1		# Size decremented by 1
		bne t1, t6, loop4	# If not done, goto loop4
		nop			# delay slot
		addi t4, t4, -1		# outer loop size decreases
		bne t4, t6, loop3	# test,if not goto loop3
		nop

		addi t0, a0, 0	# Load base address
		addi t1, a1, 0	# load size of array
		slli  t1, t1, 2	# size*4
		add t1, t0, t1	# End address of the array
		lw  a0, -4(t1)		# Load Maximum to $v0
					
		jr ra			# Return to the caller
		nop
