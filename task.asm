section .bss
    buffer resb 100       
section .data
    input db "Enter your string: ", 0
    length_in equ $ - input
    output db "Reversed: ", 0
    length_out equ $ - output
     nl db 10

section .text
    global _start

_start:
    ; Вывод "Enter your string: "
    mov eax, 4          
    mov ebx, 1          
    mov ecx, input
    mov edx, length_in
    int 0x80

    ; Считываем строку с клавиатуры
    mov eax, 3          
    mov ebx, 0          
    mov ecx, buffer     
    mov edx, 100        
    int 0x80

    mov esi, eax        
    dec esi             

    ; Выводим "Reversed: "
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, length_out
    int 0x80

print_loop:
    dec esi             
    mov al, [buffer + esi]
    mov [buffer + esi + 1], al 
    mov eax, 4
    mov ebx, 1
    lea ecx, [buffer + esi]
    mov edx, 1
    int 0x80
    cmp esi, 0
    jne print_loop

    ; Выводим перевод строки
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Завершение программы
    mov eax, 1
    xor ebx, ebx
    int 0x80


