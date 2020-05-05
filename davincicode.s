.data
count: .word 0
random_number: .word 0
guess_number: .word 0
lower_number: .word 0
upper_number: .word 100
start: .asciiz "Let's play a Da Vinci Code game \\(^^/)~~~\n"
sentence1: .asciiz "Please enter a number between "
sentence2: .asciiz " and "
wrong_range:  .asciiz "Wrong range QQ\n"
congrats1: .asciiz "Yeah~~~ you successfully guessed the number in "
congrats2: .asciiz " times (\\^^)/~"
too_many: .asciiz "You have only 10 chances. You Lose T-T"
next_line: .asciiz "\n"

.text

main:
    #  Print start
    li $v0, 4 # print string
    la $a0, start
    syscall
    
    j  Random
    
Random:
    # Generate a random number
    li $a1, 100  #Here you set $a1 to the max bound.
    li $v0, 42  #generates the random number.
    syscall
    sw $a0, random_number
    lw $t0, random_number # load randomnumber to $t0
    
    j Guess

Guess:
    lw $t0, count
    addi $t0, $t0, 1
    bgt $t0, 10, TooMany
    sw $t0, count
    
    lw $s1, lower_number
    lw $s2, upper_number

    #  Print sentence1
    li $v0, 4 # print string
    la $a0, sentence1
    syscall

    # Print  number1
    li $v0, 1       # print number
    move $a0, $s1   #  $integer to print
    syscall
    
    #  Print sentence2
    li $v0, 4 # print string
    la $a0, sentence2
    syscall
    
    # Print  number2
    li $v0, 1       # print number
    move $a0, $s2   #  $integer to print
    syscall
    
    #  Print next line
    li $v0, 4
    la $a0, next_line
    syscall
    
    # Read input number
    li	$v0, 5
    syscall
    sw $v0, guess_number  # store $v0 into guessnumber
    
    lw $t1, guess_number  # load guessnumber to $t1
    lw $t2, random_number # load randomnumber to $t2
    
    beq $t1, $t2, Equal
    blt $t1, $t2, Less
    bgt $t1, $t2, Greater
    
Less:
    blt $t1, $s1, Wrong
    sw $t1, lower_number
    j Guess
    
Greater:
    bgt $t1, $s2, Wrong
    sw $t1, upper_number
    j Guess

Wrong:
    #  Print sentence0
    li $v0, 4 # print string
    la $a0, wrong_range
    syscall
    j Guess

Equal:
    #  Print congrats1
    li $v0, 4 # print string
    la $a0, congrats1
    syscall
    
    # Print  number2
    li $v0, 1       # print number
    move $a0, $t0   #  $integer to print
    syscall
    
    #  Print congrats2
    li $v0, 4 # print string
    la $a0, congrats2
    syscall
    
    j Exit

TooMany:
    #  Print sentence0
    li $v0, 4 # print string
    la $a0, too_many
    syscall
    j Exit
# End Program
Exit:
    li $v0, 10
    syscall
