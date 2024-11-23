    .data
# Assume these arrays are already defined and initialized
array_a: .word 1, 2, 3       # Example array a
array_b: .word 4, 5, 6       # Example array b
array_c: .space 24           # Allocate space for array c (assuming 6 elements)

    .text
    .globl main

main:
    # Load base addresses of the arrays
    la a0, array_a            # Address of array a
    la a1, array_b            # Address of array b
    la a2, array_c            # Address of array c (destination)

    # Load array lengths (assuming we know these)
    li t0, 3                  # Length of array a
    li t1, 3                  # Length of array b

    # Copy array a to array c
    mv t2, t0                 # Set counter for array a
copy_a_to_c:
    beqz t2, copy_b           # If counter is 0, start copying array b
    lw t3, 0(a0)              # Load word from array a
    sw t3, 0(a2)              # Store word in array c
    addi a0, a0, 4            # Move to the next word in array a
    addi a2, a2, 4            # Move to the next word in array c
    addi t2, t2, -1           # Decrement counter
    j copy_a_to_c

    # Copy array b to array c
copy_b:
    mv t2, t1                 # Set counter for array b
copy_b_to_c:
    beqz t2, deadloop         # If counter is 0, we are done
    lw t3, 0(a1)              # Load word from array b
    sw t3, 0(a2)              # Store word in array c
    addi a1, a1, 4            # Move to the next word in array b
    addi a2, a2, 4            # Move to the next word in array c
    addi t2, t2, -1           # Decrement counter
    j copy_b_to_c

deadloop:
    beq zero, zero, deadloop # program stops here		
    nop
