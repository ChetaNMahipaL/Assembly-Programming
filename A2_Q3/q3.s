.global findNearest

findNearest:
    pushq %rbp      # initialize stack bas pointer to store %rsp of function call
    movq %rsp, %rbp # move address in %rsp to %rbp
    movq $0, %rcx   # %rdi = array, %rsi = ans, %rdx = n, %rcx=index, %r8 = top
    movq $-1, %r8   # initialize top=(-1)
    jmp .L1         # jump to .L1
.L4:
    neg %r8         # %r8=(-%r8)
    movq -8(%rbp,%r8,8), %r9    # move stack[top] in %r9
    neg %r8         # %r8=(-%r8)
    movq (%rdi,%rcx,8), %r11    # move arr[i] in %r11
    movq %r11, (%rsi, %r9, 8)   # move arr[i] in ans[stack[top]]
    subq $1, %r8    # top=top-1
    popq %r9        # pop top of stack
.L3:
    cmpq $-1, %r8   # check if top = (-1)
    je .L2          # if equal goto .L2
    neg %r8         # %r8=(-%r8)
    movq -8(%rbp,%r8,8), %r9    # move stack[top] in %r9
    neg %r8         # %r8=(-%r8)
    movq (%rdi,%r9,8), %r11     # move arr[stack[top]] in %r11
    cmpq %r11, (%rdi,%rcx,8)    # compare arr[stack[top]] and arr[i]
    jg .L4                      # if greater goto .L4 for poping element as we found greater element than the index of stored number at top of stack
    jmp .L2         # else goto .L2
.L2:
    addq $1, %r8    # top=top+1 as we are pushing in stack
    pushq %rcx      # push index of element in stack
    addq $1, %rcx   # increase loop counter by 1
.L1:
    cmpq %rdx, %rcx # run loop till index is greater than equal to n
    jge .L5         # if greater break the loop and goto .L5
    jmp .L3         # else goto .L3
.L6:
    neg %r8         # %r8=(-%r8)
    movq -8(%rbp,%r8,8), %r9    # move stack[top] in %r9
    neg %r8         # %r8=(-%r8)
    movq $-1, (%rsi, %r9, 8)    # store (-1) in ans[stack[top]] as their is no greater element in right
    subq $1, %r8    # top=top-1
    popq %r9        # pop top of stack 
.L5:
    cmpq $-1, %r8   # check if top is -1
    je .L7          # if yes goto .L7 done
    jmp .L6         # else goto .L6
.L7:
    movq %rsi, %rax # movq int* ans to %rax
    movq %rbp,%rsp  # set the %rsp for function call
    popq %rbp       # pop base pointer
    ret
