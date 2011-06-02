.section .data
  filename:
    .asciz "elf.txt"
.section .bss
  .lcomm header,52
  .lcomm hprogram,32
  .lcomm filehandle,4
.section .text

.globl _start

_start:

  movl $5,%eax #abrir arquivo
  movl $filename,%ebx
  movl $0102,%ecx
  movl $0644,%edx
  int $0x80
  

  movl $header,%ebx
  

  movl $0x7f,0(%ebx) #magic number
  movl $0x45,1(%ebx) #E
  movl $0x4c,2(%ebx) #L
  movl $0x46,3(%ebx) #F
  movl $1,4(%ebx) #adress size
  movl $1,5(%ebx) #little-endian
  movl $1,6(%ebx) #header version
  movl $0,7(%ebx) #pad
  movl $0,8(%ebx) #pad
  movl $0,9(%ebx) #pad
  movl $0,10(%ebx) #pad
  movl $0,11(%ebx) #pad
  movl $0,12(%ebx) #pad
  movl $0,13(%ebx) #pad
  movl $0,14(%ebx) #pad
  movl $0,15(%ebx) #pad
  movl $2,16(%ebx) #file type
  movl $3,18(%ebx) #arch type
  movl $1,20(%ebx) #file version
  movl $1,24(%ebx) #entry point, if executable 
  movl $0,28(%ebx) #file position of program header or 0 
  movl $0,32(%ebx) #file position of section header or 0 
  movl $0,36(%ebx) #architecture specific flags, usually 0 
  movl $0,40(%ebx) #size of this ELF header 
  movl $0,42(%ebx) #size of an entry in program header 
  movl $0,44(%ebx) #number of entries in program header or 0 
  movl $1,46(%ebx) #size of an entry in section header 
  movl $0,48(%ebx) #number of entries in section header or 0 
  movl $0,50(%ebx) #section number that contains section name strings 

  test %eax,%eax
  js badfile
  movl %eax,filehandle
  
  movl $4, %eax #escrever
  movl filehandle, %ebx
  movl $header, %ecx
  movl $52, %edx
  int $0x80
  test %eax, %eax
  js badfile
  
  
  movl $4, %eax
  movl filehandle, %ebx
  movl $hprogram, %ecx
  movl $32, %edx
  int $0x80
  test %eax, %eax
  js badfile

  movl $6, %eax #fechar arquivo
  movl filehandle, %ebx
  int $0x80

 badfile:
  movl %eax, %ebx
  movl $1, %eax
  int $0x80


  
