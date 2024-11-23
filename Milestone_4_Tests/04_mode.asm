    .data
array:  .word 1, 2, 3, 2, 4, 2, 5, 3, 3, 3, 3   # Example array
length: .word 11                     # Length of the array
counts: .space 80                 # Array to hold counts, adjust size as needed
maxNum: .word 20                   # Maximum number in the array

    .text
    .globl main
main:
    # Initialize pointers and counters
    la t0, array                    # Load address of array into t0
    la t1, counts                   # Load address of counts into t1
    lw t2, length                   # Load length of array into t2
    li s3, 0                        # Set mode count to 0
    li s4, 0                        # Set mode to 0
    li s8, 0                        # Counter for iterating through counts array

    # Iterate through array
loop:
    beqz t2, find_mode              # If t2 (array length counter) is 0, go to find_mode
    lw s5, 0(t0)                    # Load current array element into s5
    addi t0, t0, 4                  # Move to next array element

    # Calculate address for counts array based on current element
    slli s6, s5, 2                  # Multiply s5 by 4 (since we're dealing with words)
    add s6, s6, t1                  # Add base address of counts to s6
    lw s7, 0(s6)                    # Load current count
    addi s7, s7, 1                  # Increment count
    sw s7, 0(s6)                    # Store back the count

    # Decrease length counter and loop back
    addi t2, t2, -1
    j loop

    # Find mode
find_mode:
    lw s9, maxNum                   # Load maximum number
mode_loop:
    beqz s9, end                    # If all numbers are checked, jump to end
    lw s5, 0(t1)                    # Load current count
    bgt s5, s3, update_mode         # If current count is greater than max count, update mode
    skip_update:
    addi t1, t1, 4                  # Move to the next count
    addi s8, s8, 1                  # Increment number counter
    addi s9, s9, -1                 # Decrement remaining numbers counter
    j mode_loop

    update_mode:
    mv s3, s5                       # Update max count
    mv s4, s8                       # Update mode
    j skip_update

end:
deadloop:
    beq zero, zero, deadloop # program stops here		
    nop
