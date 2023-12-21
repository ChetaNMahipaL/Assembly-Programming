.global get_address_smallest

get_address_smallest:
    movq $0, %rcx      #% rcx=index, %rdx=min
    movq (%rdi,%rcx,8), %rdx   # %rdi = arr*, %rsi =n
    movq %rdi, %r8     # store address of first element
    jmp .L1
.L2:
    addq $8, %rdi
    movq (%rdi) , %rax;   # move element from array
    cmpq %rax, %rdx # check for min
    jle .L3         # check if min is to not to be changed goto .L3
    movq (%rdi), %rdx # store new min
    movq %rdi, %r8   # store address in %r8 of that min element
.L3:
    addq $1, %rcx   # increment index
.L1:
    cmpq %rcx, %rsi # check n > index
    jle .L4          # if index >= n, then exit
    jmp .L2         # goto loop section
    rep;
.L4:
    movq %r8, %rax;
    ret
