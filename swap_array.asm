#Wei Yee Goh 8260606
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        
.data
incorrect:
        .asciiz "---TEST FAILED---\n"
before:
        .asciiz "Before:\n"
after:
        .asciiz "After:\n"
comma:
        .asciiz ", "
newline:
        .asciiz "\n"
        
expectedMyArray:
        .word 29 28 27 26 25 24 23 22 21
        
myArray:
        .word 21 22 23 24 25 26 27 28 29

.text

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
# unsigned int* p1 = expectedMyArray
# unsigned int* p2 = myArray
# unsigned int* limit = expectedMyArray + 9
#
# while (p1 < limit) {
#   if (*p1 != *p2) {
#     return 0                  
#   }
#   p1++                        
#   p2++
# }
# return 1                      
checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 36

checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        la $a0, before
        li $v0, 4
        syscall

        jal printArray

        jal doSwap

        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
        li $v0, 10
        syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS
        # assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 0
        # unsigned int y = 8
        #
        # while (x != 4) {
        #   int temp = myArray[x]
        #   myArray[x] = myArray[y]
        #   myArray[y] = temp
        #   x++
        #   y--
        # }
	


        # TODO: fill in the code
	li $t0, 0   
	li $t1, 8
	li $t7, 4

	bne $t0, $t7, loop
loop:
	la $t2, myArray

	li $t3, 4
	mult $t0, $t3
	mflo $t3
	addu $t3, $t3, $t2
	
	li $t4, 4
	mult $t1, $t4
	mflo $t4
	addu $t4, $t4, $t2
	
	lw $t5, 0($t3)
	lw $t6, 0($t4)
	sw $t6, 0($t3)
	sw $t5, 0($t4)

	addi $t0, $t0, 1
	addi $t1, $t1, -1

	bne $t0, $t7, loop
	
        
        # do not remove this line
        jr $ra
