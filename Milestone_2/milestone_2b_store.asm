	.data	# Data Section
	# Starting address of data memory is 0x10010000
aArray:  .word 0xDEADBEEF, 0xBAADF00D, 0xBADDCAFE, 0xFACEFEED, 0xFEEDBABE, 
               0xF00DBABE, 0xBAAAAAAD, 0xFEEDC0DE

	.text	# Code Section
main:
	#la x5, aArray	# pseudo instruction, 
	addi x5,  x0,  0	
	addi x10, x0,  0xF	
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	sw x10, 0(x5)
	sw x10, 0(x5)
	sw x10, 0(x5)
	sw x10, 0(x5)
	sw x10, 0(x5)
	sw x10, 4(x5)	
	sw x10, 8(x5)	
	sw x10, 12(x5)	
	sw x10, 16(x5)						
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
