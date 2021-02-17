.data
# Emiljano Bodaj
Prompt: .asciiz "\n Input a value for the float N = "
result1: .asciiz "\n The sum of the integers from 1 to N is "
result2: .asciiz "\n The converted N is an integer of the value "
.text
li $v0, 4 # system call code for Print String
la $a0, Prompt # loads address of prompt into $a0
syscall # print the message in Prompt
li $v0, 6 # System call code for Read Float
syscall # read whatever you input float as 
mfc1 $t1, $f0 # Stores the float value into the $t1
srl $t2, $t1, 23  # srl by 23 to leave out the biased exponent and store it in $t2
add $s3, $t2, -127 # Subtract 127 to get the exponent
sll $t4, $t1, 9 # Shift left and right by 9 to remove the exponent
srl $t5, $t4, 9 
addi $t6, $t5, 8388608 # Add the implied bit (2^24)
add $t7, $s3, 9 # Add 9 to the exponent value
sllv $s4, $t6, $t7 # Shifts the fractional part of the number to 2^32 (32nd bit)
################################################################
rol $s5, $t6, $t7 # rotate to the left by whatever the exponent + 9 is to get the integer part of the number to the first few bits #E010010111
sll $s5, $s5, 1
srl $s5, $s5, 1 # Now I have the integer
add $s6, $zero, $s5 #add the integer value $s5 into $s6 for the loop

blez $s6, end 		 # go to end: if $v0 < = 0
li $t0, 0		 # make this register zero so we can use it for the loop
	
loop:
	add $t0, $t0, $s6 	# sum of integers in register $t0
	addi $s6, $s6, -1 	# summing integers in reverse order
	bnez $s6, loop 		# branch to loop if $v0 is != zer0
	
	li $v0, 4 		# system call code for Print String
	la $a0, result1 		# load address of message into $a0
	syscall 		# print the string 

	li $v0, 1 		# system call code for Print Integer
	move $a0, $t0 		# move value to be printed to $a0
	syscall 		# print sum of integers
end:
li $v0, 4 # Tells computer to get ready to print a .asciiz number
la $a0, result2
syscall
li $v0, 1 # Tells computer to get ready to print the converted integer number
move $a0, $s5 # Moves the contents of $s5 to %a0 so it can be called
syscall # Returns the integer
