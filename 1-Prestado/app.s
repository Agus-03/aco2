.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.	

	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
		
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
	mov x12,1			//set 1 en x12
loop2:
	mov x2,512         	// Tamaño en Y
loop1:
	mov x1,512         	// Tamaño en X
	mov w3, 0x001F   	// 0xF800 = ROJO
	mov x11,4			//estado paleta de color
loop0:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   		// Decrementar el contador X
	bl	color
vuelta:
	cbnz x1,loop0	   	// Si no terminó la fila, saltar
	sub x2,x2,1	   		// Decrementar el contador Y
	cbnz x2,loop1	  	// Si no es la última fila, saltar
	
	// --- Infinite Loop ---	
InfLoop: 
	b InfLoop

color:
	cmp x11,0
	beq tramo0
	cmp x11,1
	beq tramo1
	cmp x11,2
	beq tramo2
	cmp x11,3
	beq tramo3
	cmp x11,4
	beq tramo4
	b   tramo5

tramo0:
	add w3,w3,0b0000000000100000
	mov x13,0b10000000000000000
	cmp w3,w13
	bne vuelta
	mov w3,0b1111011111100000
	b   incremento
tramo1:
	sub w3,w3,0b0000100000000000
	cmp w3,-32
	bne vuelta
	mov w3,0b0000011111100001
	b   incremento
tramo2:
	add w3,w3,0b0000000000000001
	cmp w3,0b0000100000000000
	bne vuelta
	mov w3,0b0000011111011111
	b   incremento
tramo3:
	sub w3,w3,0b0000000000100000
	cmp w3,-1
	bne vuelta
	mov w3,0b0000100000011111
	b   incremento
tramo4:
	add w3,w3,0b0000100000000000
	mov w13,0b10000000000000000
	add w13,w13,0b11111
	cmp w3,w13
	bne vuelta
	mov w3,0b1111100000011110
	b   incremento
tramo5:
	sub w3,w3,0b0000000000000001
	mov w13,0b1111011111111111
	cmp w3,w13
	bne vuelta
	mov w3,0b1111100000100000
	b   incremento
incremento:
	add x11,x11,1
	cmp x11,6
	bne vuelta
	mov x11,0
	b vuelta
	