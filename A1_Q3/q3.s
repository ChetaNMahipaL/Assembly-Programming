.global divide

divide:
    movq $0, %rcx   # m=%rdi, n=%rsi, arr=%rdx, rem=%rcx, quotient=%r8
    movq $0, %r8    # set quotient(%r8)=0
    movq %rdi, %rax # moving numerator in %rax for division
    movq %rsi, %r9  # moving denominator in %r9
    cmpq $0, %rsi   # compare for denominator=0
    je .L1          # if yes goto .L1
    cmpq $0, %rax   # compare for numerator is positive or negative
    jl .L8          # if negative goto .L8
    jmp .L11        # else goto .L11
.L8:
    movq $0, %rdi   # set% rdi=0
    subq %rax, %rdi # %rdi=%rdi-%rax to make numerator positive
    movq %rdi, %rax # copy numerator to %rax for division
    cmpq $0, %rsi   # compare denominator for negative or positive
    jl .L10         # if negative goto .L10
    jmp .L5         # else goto .L5
.L6:
    subq %rsi, %rax # subtract denominator from numerator
    addq $1, %r8    # add 1 to quotient
.L5:
    cmpq $0, %rax   # check for numerator positive or negative
    jg .L6          # if positive goto .L6 loop section
    jmp .L7         # else goto .L7
    rep;
.L10:
    movq $0, %rdi   # set %rdi=0
    subq %rsi, %rdi # %rdi=%rdi-%rsi to make denominator positive
    movq %rdi, %rsi # %rsi to be denominator
    jmp .L5         # goto .L5
.L9:
    movq $0, %rdi   # set %rdi=0
    subq %rax, %rdi # make remainder +ve
    movq %rdi, %rax # store remainder in %rax
    movq %rax, %rcx # store remainder in %rcx
    movq $0, %r9    # set %r9=0 for array indexing
    movq $1, %rdi   # set %rdi=0 for array indexing
    movq %r8, (%rdx,%r9,8)  # store quotient
    movq %rcx, (%rdx,%rdi,8)# store remainder
    ret

.L7:
    cmpq $0, %r9    # check for denominator to be negative or positive
    jl .L9          # if negative goto .L9
    movq $0, %rdi   # set %rdi=0
    subq %rax, %rdi # make remainder positive
    movq %rdi, %rax # store remainder in %rax
    movq %rax, %rcx # store remainderin %rcx
    movq $0, %rdi   # set %rdi=0
    subq %r8, %rdi  # make quotient negative
    movq %rdi, %r8  # store quotient in %r8
    movq $0, %r9    # set %r9=0 for array indexing
    movq $1, %rdi   # set %rdi=0 for array indexing 
    movq %r8, (%rdx,%r9,8) # store quotient
    movq %rcx, (%rdx,%rdi,8)# store remiander
    ret

.L12:
    movq $0, %rdi   # set %rdi=0
    subq %rsi, %rdi # make denominator positive
    movq %rdi, %rsi # store denominator in %rsi
    jmp .L2         # goto .L2
.L11:
    cmpq $0, %rsi   # comapare denominator for positive or negative
    jl .L12         # if negative goto .L12
    jmp .L2         # else goto .L2
.L3:
    subq %rsi, %rax # subtract denominator from numerator
    addq $1, %r8    # add 1 to quotient
.L2:
    cmpq %rsi, %rax # compare %rsi and %rax
    jge .L3          # if %rax > %rsi goto loop section
    jmp .L4         # else goto .L4
    rep;
.L13:
    movq $0, %rdi   # set %rdi=0
    subq %r8, %rdi  # make quotient negative
    movq %rdi, %r8  # store quotient in %r8
    movq %rax, %rcx # store remainder in %rcx
    movq $0, %r9    # set %r9=0 for array indexing
    movq $1, %rdi   # set %rdi=1 for array indexing
    movq %r8, (%rdx,%r9,8)# store quotient
    movq %rcx, (%rdx,%rdi,8)# store remiander
    ret

.L4:
    cmpq $0, %r9    # comapare denominator for negative and positive
    jl .L13         # if negative goto .L13
    movq %rax, %rcx # store remainder in %rcx
    movq $0, %r9    # set %r9=0 for array indexing
    movq $1, %rdi   # set %rdi=1 for array indexing
    movq %r8, (%rdx,%r9,8)# store quotient
    movq %rcx, (%rdx,%rdi,8)# set remainder
    ret

.L1:
    movq $0, %r8            # set %r8=0 for array indexing
    movq $1, %r9            # set %r9=1 for array indexing
    movq $(-1), (%rdx,%r8,8)# set quotient=(-1)
    movq $(-1), (%rdx,%r9,8)# set remainder=(-1)
    ret                     

