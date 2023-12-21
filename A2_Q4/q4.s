.global special_op

special_op:
    movq 8(%rsp), %rax  # move %rax=x7
    addq %rdi, %rax     # add %rax=%rax+x1
    addq %rsi, %rax     # add %rax=%rax+x2
    addq %rdx, %rax     # add %rax=%rax+x3
    addq %rcx, %rax     # add %rax=%rax+x4
    addq %r8, %rax      # add %rax=%rax+x5
    addq %r9, %rax      # add %rax=%rax+x6
    movq 16(%rsp), %rdi # movq %rdi = y
    subq %rdi, %rax     # subq %rax=%rax-y
    ret
