.global binarySearch

binarySearch:
    cmpq %rdx, %rsi # %rdi=arr, %rsi=l, %rdx=r, %rcx=x, %r8=mid
    jg .L1          # if left > right goto .L1
    movq %rdx, %r8  # move right index to %r8
    subq %rsi, %r8  # mid=(right-left)
    shrq $1, %r8    # %mid/2=(right-left)/2
    addq %rsi, %r8  # add mid=mid+left
    cmpq (%rdi,%r8,8), %rcx # compare arr[mid] with x
    je .L2          # if equal goto .L2
    jg .L3          # if (x > arr[mid]) goto .L3
    movq %r8, %rdx  # move mid in place of right for argument for next function call
    subq $1, %rdx   # subtract mid=mid-1
    call binarySearch       # call binarySearch function with arguments %rdi, %rsi, %rdx, %rcx
    ret

.L3:
    movq %r8, %rsi  # move mid in place of left for argument in next function call
    addq $1, %rsi   # add mid=mid+1
    call binarySearch       # call binarySearch function with arguments %rdi, %rsi, %rdx, %rcx
    ret

.L2:
    movq %r8, %rax  # move %r8(mid) to %rax to return ans
    ret

.L1:
    movq $-1, %rax  # move -1 to %rax to return as number not found
    ret
    
