#32 bit Assembly Project
#n floating point numbers (Use the "double" type. Do not use "float" type.)
# The program should output ((n) + 1/1) * ((n-1) + 1/2) * ((n-2) + 1/3) * ((n-3) + 1/4) * ... * (2 + 1/(n-1)) * (1 + 1/(n)).
# Example:
# The user inputs: 3
# The program outputs: sum=13.333
.intel_syntax noprefix          
.section .data
x: .int 0                       # Initialize variable x to 0
inputf: .asciz "%d"             # Define the input format string for scanf
outputd: .asciz "sum=%f"        # Define the output format string for printf       
one : .double 1.0               # Variable hole value on to use in registers
EbxTemp : .int 0                # Temperory Vars to hold values of registes Ebx ans Ecx
EcxTemp : .int 0
DEbx : .double 0.0              # Temperory Vars to hold double values of register Ebc and Ecx
DEcx : .double 0.0
Term : .double 0.0              # Term to Hold value of term like this  ((n) + 1/1)  
multiplication : .double 1.0    # Hold all multiplication 
.section .text 
.globl _main                    #Main function
_main:
push OFFSET x                   # Push the address of x onto the stack for scanf
push OFFSET inputf              # Push the address of inputf onto the stack for scanf
call _scanf                     # Call the scanf function
add ESP, 8                      # Adjust the stack pointer after printf for clean it
mov ECX, x                      # Load the address of x into ECX
mov EBX , 1                     # Load 1 to increment till n
loop1:
# Core loop 
mov DWORD PTR [EcxTemp], ECX    # GET VALUE FROM REGISTER ECX TO TEMP VAR
mov DWORD PTR [EbxTemp], EBX    # GET VALUE FROM REGISTER EBX TO TEMP VAR
FILD DWORD PTR EbxTemp          # Load integer value from memory to The fadd and fa instructions add the 64-bit, double-precision floating-point operand in floating-point register (FPR) FRA to the 64-bit, double-precision floating-point operand in FPR FRB.
FSTP QWORD PTR DEbx             # Save double value in DEbx

FILD DWORD PTR EcxTemp          # Load integer value from memory to floating-point register (FPR)
FSTP QWORD PTR DEcx             # Save double value in DEbx

FLD QWORD PTR one               # Calulate fraction
FDIV QWORD PTR DEbx             # Make 1 / DEbx
FADD QWORD PTR DEcx             # Add for the fraction term 
FSTP QWORD PTR Term             # Save it in term variable

FLD QWORD PTR multiplication    # Calculate multiplication
FMUL QWORD PTR Term             
FSTP QWORD PTR multiplication
# Update loop variable
# Loop check
sub ECX, 1                      # Decrement ECX (loop variable)
add EBX , 1                     # increment EBX by 1
cmp ECX, 0                      # Compare ECX with 0
jg loop1                        # Jump to loop1 if ECX is greater than 0

push [multiplication+4]
push [multiplication]           # Push the value of sum onto the stack for printf
push OFFSET outputd             # Push the address of outputd onto the stack for printf
call _printf                    # Call the printf function
add ESP, 12                     # Adjust the stack pointer after printf for clean it

ret                             # Return from the main function
