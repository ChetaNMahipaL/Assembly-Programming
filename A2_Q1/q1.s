.global is_balanced

is_balanced:
    pushq %rbp          # intialize stack
    movq %rsp, %rbp     # store %rsp into %rbp
    movq $0, %rcx       # intialize index or loop counter
    movq %rdi, %rdx     # move n to %rdx
    movq $-1, %r8       # %rdi=n, %rsi=arr, %r8=top
    movq $0, %r9        # %r9=index
    jmp .L1             # goto .L1

.L9:
    movq $0, %rax       # move 0 to %rax to return false as not balanced
    movq %rbp, %rsp     # restore %rsp at base of function call
    popq %rbp           # pop base pointer
    ret

.L8:
    subq $1, %r8        # top=top-1
    movzbq %cl, %rcx    # move value in %cl to %rcx
    popq %rcx           # pop top of stack
    jmp .L7             # goto .L7

.L3:
    addq $1, %r8        # top=top+1
    movzbq %dil, %rcx   # move value in %dil to %rcx 
    pushq %rcx          # push the brackett in stack
    jmp .L7             # goto .L7

.L4:
    cmpq $-1, %r8       # if stack top == (-1)
    je .L9              # if equal goto .L9
    neg %r8             # %r8=(-%r8)
    movb -8(%rbp,%r8,8), %cl    # move stack top in %cl
    neg %r8             # %r8=(-%r8)
    cmpb $'(', %cl      # compare '(' and %cl
    je .L8              # if equal goto .L8
    jmp .L9             # goto .L9

.L5:
    cmpq $-1, %r8       # if stack top == (-1)
    je .L9              # if equal goto .L9
    neg %r8             # %r8=(-%r8)
    movb -8(%rbp,%r8,8), %cl    # move stack top in %cl
    neg %r8             # %r8=(-%r8)
    cmpb $'{', %cl      # compare '{' and %cl
    je .L8              # if equal goto .L8
    jmp .L9             # goto .L9

.L6:
    cmpq $-1, %r8       # if stack top == (-1)
    je .L9              # if equal goto .L9
    neg %r8             # %r8=(-%r8)
    movb -8(%rbp,%r8,8), %cl    # move stack top in %cl
    neg %r8             # %r8=(-%r8)
    cmpb $'[', %cl      # compare '[' and %cl
    je .L8              # if equal goto .L8
    jmp .L9             # goto .L9

.L2:
    movb (%rsi,%r9,1), %dil     # mov element from array in %dil
    cmpb $'(', %dil     # compare '(' with arr[i]
    je .L3              # if equal goto .L3
    cmpb $'{', %dil     # compare '{' with arr[i]
    je .L3              # if equal goto .L3
    cmpb $'[', %dil     # compare '[' with arr[i]
    je .L3              # if equal goto .L3
    cmpb $')', %dil     # compare ')' with arr[i]
    je .L4              # if equal goto .L4
    cmpb $'}', %dil     # compare '}' with arr[i]
    je .L5              # if equal goto .L5
    cmpb $']', %dil     # compare ']' with arr[i]
    je .L6              # if equal goto .L6
    jmp .L7             # else goto .L7

.L7:
    addq $1, %r9        # increment loop counter

.L1:
    cmpq %rdx, %r9      # check if index >= string length
    jge .L10            # if yes goto .L10
    jmp .L2             # else goto .L2

.L10:
    cmpq $-1, %r8       # if top = (-1)
    jne .L9             # if not equal goto .L9
    movq $1, %rax       # otherwise move %rax=1
    movq %rbp, %rsp     # set %rsp to base of function call
    popq %rbp           # pop base pointer
    ret
