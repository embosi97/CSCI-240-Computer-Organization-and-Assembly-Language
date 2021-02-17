.data
   bytes: .byte 5
   string1: .asciiz "Enter a string that's exactly 4-letters long: "

.text
     addi $v0,$0,4
     la $a0, string1
     syscall
     addi $v0,$0,8
     la $a0, bytes
     addi $a1,$0,5
     syscall
     jal stack
     addi $v0,$0,10
     syscall
stack:
     addi $sp,$sp,-16
     lb $t0,($a0)
     lb $t1,1($a0)
     lb $t2,2($a0)
     lb $t3,3($a0)
     sb $t0,($sp)
     sb $t1,4($sp)
     sb $t2,8($sp)
     sb $t3,12($sp)
     addi $v0,$0,11
     li $a0,10
     syscall
     lb $a0,12($sp)
    addi $v0,$0,11
     syscall
     lb $a0,8($sp)
    addi $v0,$0,11
     syscall
     lb $a0,4($sp)
     addi $v0,$0,11
     syscall
     lb $a0,0($sp)
     addi $v0,$0,11
     syscall
     addi $sp,$sp,16
     jr $ra