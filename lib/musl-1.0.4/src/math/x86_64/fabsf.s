        .global fabsf
        .align 16, 0x90
        .type fabsf,@function
fabsf:
	mov $0x7fffffff,%eax
	movq %rax,%xmm1
	andps %xmm1,%xmm0
	#ret
        popq %rcx
        movl %ecx, %ecx
try:    movq %gs:0x1000, %rdi
__mcfi_bary_fabsf:
        cmpq %rdi, %gs:(%rcx)
        jne check
        jmpq *%rcx
check:
        movq %gs:(%rcx), %rsi
        testb $0x1, %sil
        jz die
        cmpl %esi, %edi
        jne try
die:
        leaq try(%rip), %rdi
        jmp __report_cfi_violation_for_return@PLT

        .section	.MCFIFuncInfo,"",@progbits
	.ascii	"{ fabsf\nY float!float@\nR fabsf\n}"
	.byte	0
