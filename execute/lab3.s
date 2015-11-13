.data
.text
# int main()
# {
# return comp(7, 8);
# }
.globl main
main:
addiu $sp,$sp,-24 #reserve space on the stack
sw $ra,20($sp) # save previous $ra
sw $fp,16($sp) # save previous $fp
move $fp,$sp # set $fp location
li $a0,7 # initialize 1st arg for call
li $a1,8 # initialize 2nd arg for
jal comp # call comp procedure
move $sp,$fp # reset $sp
lw $ra,20($sp) # restore registers saved in
lw $fp,16($sp)
addiu $sp,$sp,32 # restore the stack pointer (pop)
j $ra # return to caller
# Done, terminate program.
li $v0, 10
syscall # exit
.end main
# int comp(int m, int n)
# {
# int a = 1, b = 2;
# register int x = 5, y = 6;
# args6(a, b, m, n, x, y);
# return (x + y);
# }
.globl comp
comp:
addiu $sp,$sp,-48 # reserve space on the stack
sw $ra,44($sp) # save previous $ra
sw $fp,40($sp) # save previous $fp
sw $s1,36($sp) # save $s0, $s1 before using them
sw $s0,32($sp)
move $fp,$sp # set $fp location
sw $a0,48($fp) # save $a0, $a1 (2 arguments m, n of comp) in caller's frame
sw $a1,52($fp)
li $v0,1 # store local variables a, b in
sw $v0,24($fp)
li $v0,2
sw $v0,28($fp)
li $s0,5 # register variables x, y stored in $s0, $s1
li $s1,6
sw $s0,16($sp) # pass arguments 5, 6 (x, y) via
sw $s1,20($sp)
lw $a0,24($fp) # put 1st 4 (a,b, m, n) arguments
lw $a1,28($fp)
lw $a2,48($fp)
lw $a3,52($fp)
jal args6 # call args6 procedure
addu $v0,$s0,$s1 # put the sum of x+y into return
move $sp,$fp # set the stack pointer back to
lw $ra,44($sp) # restore registers saved in
lw $fp,40($sp)
lw $s1,36($sp)
lw $s0,32($sp)
addiu $sp,$sp,48 # restore the stack pointer (pop)
j $ra # return to the caller
.end comp
# int args6(int x, int y, int z, int a, int b, int c)
# {
# return (x + y + z + a + b + c);
# }
.globl args6
arg6:
addiu $sp,$sp,-8 # reserve space on the stack
sw $fp,0($sp) # save previous $fp
move $fp,$sp # set $fp location
sw $a0,8($fp) # back up 1st 4 arguments into
sw $a1,12($fp)
sw $a2,16($fp)
sw $a3,20($fp)
lw $v1,8($fp) # load and add the 1st 4 args and
lw $v0,12($fp)
addu $v0,$v1,$v0
lw $v1,16($fp)
addu $v0,$v0,$v1
lw $v1,20($fp)
addu $v0,$v0,$v1
lw $v1,24($fp) # load 5th argument from 24($fp) and add to $v0
addu $v0,$v0,$v1
lw $v1,28($fp) # load 6th argument from 28($fp) and add to $v0
addu $v0,$v0,$v1
move $sp,$fp # reset $sp to $fp
lw $fp,0($sp) # restore old value of $fp
addiu $sp,$sp,8 # restore the stack pointer (pop)
j $ra # return to caller
.end arg6
