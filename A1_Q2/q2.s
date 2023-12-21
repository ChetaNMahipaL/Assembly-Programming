.global calculate

calculate:
    movq %rcx, %r8  # %rdi=a, %rsi=x, %rdx=b, %rcx=y
    movq $0, %r9    # set %r9=0
    cmpq $0, %rsi   # check if x>=0
    jge .L2         # goto .L2 for multiplication
    cmpq $0, %rdi   # check if a>=0
    jge .L4         # goto .L4 for division of negative numbers
    subq %rsi, %r9  # convert x into positive for division
    movq %r9, %rcx  # set value of %rcx for shift operations
    movq $0, %r9    # set %r9=0
    subq %rdi, %r9  # convert a to positive for rounding down
    sarq %rcx, %r9  # division by 2^x
    movq $0, %rdi   # set %rdi=0
    subq %r9, %rdi  # convert a/2^x to negative again
    jmp .end        # goto next part calculation of b.2^y
.L2:
    movq %rsi, %rcx # set value of %rcx for shift operations
    salq %rcx, %rdi # multiplication by 2^x
    jmp .end        # goto next part calculation of b.2^y
.L4:
    subq %rsi, %r9  # convert x into positive for division
    movq %r9, %rcx  # set value of %rcx for shift operations
    sarq %rcx, %rdi # division by 2^x
    jmp .end        # goto next part for calculation of b.2^y
.end:
    cmpq $0, %r8    # check if y>=0
    jge .L3         # goto .L3 for multiplication
    cmpq $0, %rdx   # check if b>=0
    jge .L5         # goto .L5 for division of negative numbers
    movq $0, %r9    # set %r9+0
    subq %r8, %r9   # convert y into positive for division
    movq %r9, %rcx  # set %rcx for shift operations
    movq $0, %r9    # set %r9=0
    subq %rdx, %r9  # convert b to positive for division
    sarq %rcx, %r9  # division by 2^y
    movq $0, %rdx   # set %rdx=0
    subq %r9, %rdx  # convert b.2^y into negative again
    jmp .add        # goto next part for final calculation of result
.L3:
    movq %r8, %rcx  # set value of %rcx for shift operations
    salq %rcx, %rdx # multiplication by 2^y
    jmp .add        # goto next part for final calculation of result
.L5:
    movq $0, %r9    # set %r9=0
    subq %r8, %r9   # convert y to positive for division
    movq %r9, %rcx  # set %rcx for division
    sarq %rcx, %rdx # division by 2^y
    jmp .add        # goto next part for final calculation of result
.add:
    movq %rdi, %rax # set %rax=%rdi
    addq %rdx, %rax # %rax=%rax+%rdx
    ret             # return result

