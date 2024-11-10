//--- --- --- --- --- --- DEFINICION DE FUNCIONES
	.global inputRead
	//lee botones en el GPIO

	.global paredes
	//dibuja las paredes del laberinto

	.global trigger
	//dibuja los triggers de cambio
//--- --- --- --- --- --- FIN DEFINICION DE FUNCIONES

inputRead:
	ldr w22,[x20,GPIO_GPLEV0]	//Leer registro GPIO Pin Level 0 y guardar en X22
	br x30						//Volver a la instruccion link

paredes:
	add x10,x0,0				//guardar en X10 la dir base del fb
	//Offsets
	mov x14,1024				//ancho del framebuffer
	mov x15,2					//2 bytes x pixel
	mul x26,x6,x14				//offset y
	mul x12,x4,x15				//offset x
	add x26,x26,x12
	add x10,x10,x26
	
	add x12,x6,0				//count y
wall1:
	add x26,x4,0					//count x
wall2:
	sturh w3,[x10]				//pinto el pixel actual
	add x10,x10,2				//siguiente pixel
	add x26,x26,1					//x++
	cmp x26,x5					//termine el x?
	b.ne wall2
	add x12,x12,1				//y++
	sub x13,x5,x4				//diferencia entre fin e inicio de x
	mul x13,x13,x15				//diferencia*2 para ajustar por pixeles
	sub x13,x14,x13				//calcular distancia al inicio de la prox fila (cont pixeles)
	add x10,x10,x13				//sumar la distancia -> corregir dibujo
	cmp x12,x7					//termine el y?
	b.ne wall1
 
	br x30						//volver a la instrucciòn link

trigger:
	mov x26,512
	mul x26,x5,x26				//yi * 512
	add x26, x4,x26				//xi + yi * 512
	add x26,x26,x26				//2 * x26

	add x10, x0, x26				// x10 = x0 + 2 * (Xo + (Yo * 512))  -> Fórmula del enunciado
	add x10, x10, 12			// Desplazo a x10 unos 6 pixeles para que dibuje bien
	mov x12, 6					// contador de Y = 6
	mov w3, 0xFDE1				// color amarillo para el trigger
trig1:
	mov x13, 4					// x13 = contador de X = 4  (es por la forma de la mina)
	mov x15, 6					// x15 = 6
	sub x15, x15, x12			// x15 = 6 - Y
	add x15, x15, x15			// x15 = 2 * (6 - Y)
	add x13, x13, x15				// x13 = contador de X = 4 + 2 * (6 - Y)
	mov x16, 511				// x16 = número de pixeles por línea - 1
	sub x16, x16, x13			// x16 = números de pixeles restantes para pasar a la siguiente línea
	add x16, x16, x16			// x16 = cantidad de bytes que sumo para llegar a ese pixel que quiero.
trig0:
	sturh w3, [x10]				// Pintar el pixel
	add x10, x10, 2				// Paso al siguiente pixel
	sub x13, x13, 1				// X--
	cbnz x13, trig0				// Si x != 0 pasa a repetirse
	sub x12, x12, 1				// Y--
	add x10, x10, x16			// Aca paso a la siguiente fila
	cbnz x12, trig1				// Si Y != 0 pasa a repetirse
// Aca simplemente calculamos cuatro líneas fijas
	//add x10, x10, 996			// aca pasamos a la dirección que corresponde
	mov x12, 4					// Contador de Y = 4
trig3:
	mov x13, 16					// Contador de X = 16
trig2:
	sturh w3, [x10]			// Pinto
	add x10, x10, 2				// Paso al siguiente pixel
	sub x13, x13, 1				// X--
	cbnz x13, trig2				// Si x != 0 pasa a repetirse
	SUB x12, x12, 1				// Y--
	add x10, x10, 992			// Paso a la siguiente fila
	cbnz x12, trig3				// Si Y != 0 pasa a repetirse
// Aca pintamos el rombo para abajo
	add x10, x10, 2				// Paso al siguiente pixel
	mov x12, 6					// x12 = contador de Y = 6
trig5:
	mov x13, 4					// x13 = contador de X = 4  (es por la forma de la mina)
	sub x15, x12, 1				// x15 = (Y - 1)
	add x15, x15, x15			// x15 = 2 * (Y - 1)
	add x13, x13, x15				// X = 4 + 2 * (Y - 1)
	mov x16, 513				// x16 = número de pixeles por línea + 1
	sub x16, x16, x13			// x16 = números de pixeles restantes para pasar a la siguiente línea
	add x16, x16, x16			// x16 = cantidad de bytes que sumo para llegar a ese pixel que quiero.
trig4:
	sturh w3, [x10]			// cargo el color negro
	add x10, x10, 2				// Paso al siguiente pixel
	sub x13, x13, 1				// X--
	cbnz x13, trig4				// Si x != 0 pasa a repetirse
	sub x12, x12, 1				// Y--
	add x10, x10, x16			// Aca paso a la siguiente fila
	cbnz x12, trig5				// Si Y != 0 pasa a repetirse

	br x30						// vuelvo a la instruccion link
