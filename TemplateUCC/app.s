.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	// Configurar GPIO 2 y 3 como output:
	mov X21,#0x240
	str w21,[x20,0] 		// Coloco 1 en Function Select 0 (base)
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)

mov w21, 0x4
str w21, [x20, 0x1C] 	// Apagar led verde

mov w21, 0x8
str w21, [x20, 0x1C] 	// Apagar led rojo

b inicio
inicio1:
//led
inicio:	
	mov w3, 0xFFFF    	// 0xFFFF = Blanco
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer
	
	mov x2,512         	// Tamaño en Y
fondo1:
	mov x1,512         	// Tamaño en X	
fondo2:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   	// Decrementar el contador X
	cbnz x1,fondo2	   	// Si no terminó la fila, volver a pintar
	sub x2,x2,1	   	// Decrementar el contador Y
	cbnz x2,fondo1	  	// Si no es la última fila, saltar

//dibujar el laberinto
	mov x4,220		// Inicio de la figura, argumento inicio x
	mov x5,512		// Posicion final x
	mov x6,0		// Posicion inicio y
	mov x7,20		// Posicion final y
	bl rectangulo		// Ir a la funcion rectangulo	

	mov x4,0
	mov x5,448
	mov x6,0
	mov x7,20
	bl rectangulo
	
	mov x4,492
	mov x5,512
	mov x6,0
	mov x7,512
	bl rectangulo
	
	mov x4,0
	mov x5,320
	mov x6,492
	mov x7,512
	bl rectangulo
	
	mov x4,384
	mov x5,512
	mov x6,492
	mov x7,512
	bl rectangulo
	
	mov x4,0
	mov x5,20
	mov x6,0
	mov x7,512
	bl rectangulo

	mov x4,0
	mov x5,84
	mov x6,320
	mov x7,340
	bl rectangulo
	
	mov x4,64
	mov x5,84
	mov x6,256
	mov x7,320
	bl rectangulo
	
	mov x4,64
	mov x5,148
	mov x6,256
	mov x7,276
	bl rectangulo
	
	mov x4,128
	mov x5,148
	mov x6,192
	mov x7,256
	bl rectangulo
	
	mov x4,64
	mov x5,276
	mov x6,192
	mov x7,212
	bl rectangulo
	
	
	mov x4,64
	mov x5,84
	mov x6,128
	mov x7,192
	bl rectangulo
	
	mov x4,256
	mov x5,276
	mov x6,128
	mov x7,192
	bl rectangulo
	
	mov x4,192
	mov x5,320
	mov x6,64
	mov x7,84
	bl rectangulo
	mov x4,64
	mov x5,384
	mov x6,64
	mov x7,84
	bl rectangulo
	
	
	mov x4,128
	mov x5,148
	mov x6,64
	mov x7,128
	bl rectangulo

	mov x4,384
	mov x5,404
	mov x6,64
	mov x7,340
	bl rectangulo
	
	mov x4,320
	mov x5,384
	mov x6,320
	mov x7,340
	bl rectangulo
	
	
	mov x4,448
	mov x5,468
	mov x6,0
	mov x7,320
	bl rectangulo
	
	mov x4,320
	mov x5,384
	mov x6,192
	mov x7,212
	bl rectangulo
	
	mov x4,320
	mov x5,340
	mov x6,256
	mov x7,320
	bl rectangulo
	
	mov x4,192
	mov x5,320
	mov x6,256
	mov x7,276
	bl rectangulo

	mov x4,192
	mov x5,212
	mov x6,256
	mov x7,340
	bl rectangulo
	
	mov x4,128
	mov x5,192
	mov x6,320
	mov x7,340
	bl rectangulo
	
	mov x4,128
	mov x5,148
	mov x6,320
	mov x7,468
	bl rectangulo
	
	mov x4,64
	mov x5,128
	mov x6,448
	mov x7,468
	bl rectangulo
	
	mov x4,64
	mov x5,84
	mov x6,384
	mov x7,448
	bl rectangulo
	
	mov x4,128
	mov x5,448
	mov x6,384
	mov x7,404
	bl rectangulo
	
	mov x4,256
	mov x5,276
	mov x6,320
	mov x7,384
	bl rectangulo
	
	mov x4,448
	mov x5,468
	mov x6,384
	mov x7,512
	bl rectangulo
	
	mov x4,192
	mov x5,384
	mov x6,448
	mov x7,468
	bl rectangulo
	
	mov x4,320
	mov x5,340
	mov x6,448
	mov x7,512
	bl rectangulo
	
	// Dibujar agujero negro
	mov x4,280
	mov x5,300
	mov x6,280
	mov x7,300
	bl agujeronegro
	
	
	// Dibujar al Personaje
	mov w3, 0x001F   	// 0x001F = Azul 
	mov x8,480		// Eje x del Personaje 
	mov x9,30             	// Eje y del Personaje 
	add x12,x8,3            // Final del eje x del Personaje
	add x13,x9,3		// Final del eje y del Personaje
	
Personaje:
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
	mov x14,1024    	 
	mov x15,2          	 
	mul x17,x9,x14      	// Ajustando offset de pixeles en Y para dibujar
	mul x5,x8,x15     	// Ajustando offset de pixeles en X para dibujar
	add x17,x17,x5		// Sumar ambos offset
	add x10,x10,x17    	// Ajusta el offset a X10
	add x7,x9,0		// Contador y
	
Personajeloopx:
	add x6,x8,0		// Contador x
	
Personajeloop:   
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	add x6,x6,1	   	// Aumentar el contador X
	cmp x6,x12 
	b.ne Personajeloop	
	add x7,x7,1	   	// Aumentar el contador Y
	sub x4,x12,x8		
	mul x4,x4,x15		// Multiplicar por 2 para ajustar por pixeles
	sub x4,x14,x4		// Calcular la distancia al inicio de la próxima fila de la figura (en contador para pixeles)
	add x10,x10,x4      	
	cmp x7,x13
	b.ne Personajeloopx  	
	
agujeronegrocheck:
	add x10,x10,2    	// Asumiendo que x10 se mantiene despues del dibujo del Personaje
	ldurh w19,[x10]	   	// Tomar el color del pixel N
	mov w18,0x0000    	// Color del agujero
	cmp w18,w19
	b.eq inicio1    	// Reinicia el laberinto si el Personaje toca el agujero negro
	
	
controldemovimiento:
	bl inputRead       	// Leer botones presionados, guardar en x22 y volver
	and w23,w22,#0x4000  	// Filtrar solamente este valor de w22 y almacenarlo en w23 
	cmp w23,#0x4000   	
	b.eq moverarriba	
	and w23,w22,#0x8000  	
	cmp w23,#0x8000   	
	b.eq moverderecha	
	and w23,w22,#0x20000  	 
	cmp w23,#0x20000   	
	b.eq moverabajo	   	
	and w23,w22,#0x40000  	 
	cmp w23,#0x40000   	
	b.eq moverizquierda	
	b delay2      		// Si ninguno esta presionado no hay movimiento
	
moverarriba:
	add x18,x0,0	    	// x18 contiene la dirección base del framebuffer
	mov x14,1024       	
	mov x15,2          	
	sub x19,x9,5	    	// Guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14      	// Ajustando offset de pixeles en y para dibujar
	mul x5,x8,x15     	// Ajustando offset de pixeles en x para dibujar
	add x17,x17,x5		// Sumar ambos offset
	add x18,x18,x17    	// Ajusta el offset a X18
	ldurh w19,[x18]  	// Toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	mov w18,#0x07E0  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	sub x9,x9,5  		// Mueve el eje y del Personaje arriba
	sub x13,x13,5  		// Mueve el eje y del Personaje arriba
	b delay2
	
moverderecha:
	ldurh w18,[x10,#10]  	// Toma el valor del color en la direccion a la que se va a mover
	mov w19,#0x07E0  	// Guardar el valor de las paredes en w19
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	add x8,x8,5  		// Mueve el eje x del Personaje a la derecha
	add x12,x12,5  		// Mueve el eje x del Personaje a la derecha
	b delay2
	
moverizquierda:
	ldurh w18,[x10,#-10]  	
	mov w19,#0x07E0  		
	cmp w18,w19      	
	b.eq delay2    		
	sub x8,x8,5  		
	sub x12,x12,5  		
	b delay2	
	
moverabajo:
	add x18,x0,0	    	// x18 contiene la dirección base del framebuffer
	mov x14,1024       	 
	mov x15,2          	 
	add x19,x13,5	    	// Guardando en x19 la direccion a la que se quiere ir... porque no se puede aplicar el offset normalmente
	mul x17,x19,x14      	// Ajustando offset de pixeles en y para dibujar
	mul x5,x8,x15     	// Ajustando offset de pixeles en x para dibujar
	add x17,x17,x5		// Sumar ambos offset
	add x18,x18,x17    	// Ajusta el offset a X18
	ldurh w19,[x18]  	// Toma el valor del color en la direccion a la que se va a mover (deshaciendose del valor anterior)
	mov w18,#0x07E0  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	add x9,x9,5  		// Mueve el eje x del Personaje derecha
	add x13,x13,5  		// Mueve el eje x del Personaje a la derecha
	b delay2
	
delay2:
	
	// --- Delay loop ---
	movz x11, 0x10, lsl #16
	
delay1: 
	sub x11,x11,#1
	cbnz x11, delay1
	// ------------------	
		
	b Personaje
		
		
infloop:
	b infloop
	

//----definicion de registros----//
//x0: Direccion base de framebuffer (no borrar)
//x1: Tamaño en y de la pantalla
//x2: Tamaño en x de la pantalla
//w3: Donde va el color que se envia al framebuffer
//x4: En rectangulo, inicio x de la figura. Inusado fuera de eso 
//x5: En rectangulo, inicio y de la figura. Inusado fuera de eso
//x6: En rectangulo, final y de la figura. Inusado fuera de eso
//x7: En rectangulo, final x de la figura. Inusado fuera de eso
//x8: Auxiliar para rectangulo, eje x del Personaje despues
//x9: Auxiliar para rectangulo, eje y del Personaje despues
//x10: Direccion base del framebuffer MAS el offset en pixeles
//x11: Usado para delays
//x12: Auxiliar para rectangulo y despues para Personaje
//x13: Auxiliar para rectangulo y despues para Personaje
//x14: Auxiliar para rectangulo y despues para Personaje
//x15: Auxiliar para rectangulo y despues para Personaje
//w16: Usado para el refondo, donde se carga el valor del color en un pixel
//x17: Auxiliar para Personaje
//x18: Auxiliar de color
//x19: Auxiliar de color
//w20: Direccion de GPIO, no borrar
//x21:
//x22: Para GPIO
//x23: Auxiliar para GPIO
//x24:
//x25:
//x26:
//x27:
//x28:
//x29:
//x30: Para link, no borrar

//GPIO14=arriba, GPIO17=abajo, GPIO18=izquierda, GPIO15=derecha
//led rojo=GPIO3, led verde=GPIO2
//-----//

