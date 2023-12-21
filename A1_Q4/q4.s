.global get_product_assembly

get_product_assembly:
    movq $1, %rax   # %rdi=head, %rax=product
    jmp .L1         # goto condition for loop
.L2:
    movq (%rdi), %rsi   # set %rsi=curr->data
    imulq %rsi          # multiply the product with curr->data %rax=%rax*%rsi
    movq 8(%rdi), %rdi  # goto next node curr=curr->next
.L1:
    testq %rdi, %rdi    # check if head or curr (%rdi) is null
    je .L3              # if yes goto exit loop
    jmp .L2             # otherwise goto execute loop section
.L3:
    ret;                # return product %rax
