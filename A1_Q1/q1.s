.global get_sum

get_sum:
    movq $0, %r9    # initialize sum=0
    movq $0, %rcx   # initialize index=0
    jmp .L1         # check loop condition
.L2:
    movq (%rdi,%rcx,8), %rax;   # move element from array
    movq $3, %r8    # store three in %r8
    cqto
    idivq %r8       # divide first element by 3
    cmpq $0, %rdx # move remainder into %rax
    jne .L3         # check if remainder is not equal to 0 then goto >L3
    addq (%rdi,%rcx,8), %r9 # add elements in sum and store result in sum
.L3:
    addq $1, %rcx   # increment index
.L1:
    cmpq %rcx, %rsi # check n > index
    jle .L4          # if index >= n, then exit
    jmp .L2         # goto loop section
    rep;
.L4:
    movq %r9, %rax  # move result to %rax
    ret             # return

