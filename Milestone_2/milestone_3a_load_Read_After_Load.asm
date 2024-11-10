	.data	# Data Section
	# Starting address of data memory is 0x10010000
aArray:  .word 0xDEADBEEF, 0xBAADF00D, 0xBADDCAFE, 0xFACEFEED, 0xFEEDBABE, 
               0xF00DBABE, 0xBAAAAAAD, 0xFEEDC0DE

	.text	# Code Section
main:
        addi x10, x0, 0
	# la x5, aArray	# pseudo instruction, 
	addi x5, x0, 0
	lw   x10, 0(x5)
	addi x11, x10,  1						
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop				
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop		
