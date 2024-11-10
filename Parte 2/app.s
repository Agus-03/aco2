.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov x21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	// Configurar GPIO 2 y 3 como output:
	ldr w21, [x20, #0]              // Leer el valor actual de GPFSEL0 (Function Select 0)
    
    // Configurar GPIO2 como salida (bits 6-8 en GPFSEL0)
    orr w21, w21, #(1 << 6)        // Setear bit 6 en 1
    bic w21, w21, #(1 << 7)        // Limpiar bit 7
    bic w21, w21, #(1 << 8)        // Limpiar bit 8

    // Configurar GPIO3 como salida (bits 9-11 en GPFSEL0)
    orr w21, w21, #(1 << 9)        // Setear bit 9 en 1
    bic w21, w21, #(1 << 10)       // Limpiar bit 10
    bic w21, w21, #(1 << 11)       // Limpiar bit 11

    // Escribir el valor actualizado de vuelta en GPFSEL0
    str w21, [x20, #0]             // Escribir en Function Select 0 para configurar GPIO2 y GPIO3 como salida
	
	// Inicializar coordenadas iniciales del personaje
    mov x24, #20                    // Inicializar coordenada X del personaje a 20
    mov x25, #20                    // Inicializar coordenada Y del personaje a 20

	//mov x27,#0						// Inicializar variable de enfriamiento en cero
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)

mov w21, 0x8
str w21, [x20, 0x28] 	// Apagar led verde

mov w21, 0x4
str w21, [x20, 0x28] 	// Apagar led rojo

mov x28,#0 //aux en 0 indica tablero rosa, led rojo
add x10, x0, 0		// X10 Contiene la dirección base del framebuffer

laberinto: //------------------------------------------------------------------------------------------------------------------------------
	// Encender led rojo y apagar led verde
	mov w21, #0x04
	str w21, [x20, #0x1C] //enciendo rojo

	mov w21, 0x08
	str w21, [x20, 0x28] //apago verde
	
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

	mov w3,0xFA52         // Setear color de paredes, fucsia

	//tope de tablero
	mov x4,0		// Inicio de la figura, argumento inicio x
	mov x5,512		// Posicion final x
	mov x6,0		// Posicion inicio y
	mov x7,16		// Posicion final y
	bl paredes		// Ir a la funcion paredes	
	//izq tablero
	mov x4,0
	mov x5,16
	mov x6,0
	mov x7,512
	bl paredes
	//base tablero
	mov x4,0
	mov x5,512
	mov x6,496
	mov x7,512
	bl paredes
	//der tablero
	mov x4,496
	mov x5,512
	mov x6,0
	mov x7,512
	bl paredes
	
	mov x4,32
	mov x5,48
	mov x6,16
	mov x7,112
	bl paredes
	
	mov x4,16
	mov x5,48
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,144
	mov x7,336
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,336
	mov x7,352
	bl paredes
	
	mov x4,48
	mov x5,64
	mov x6,320
	mov x7,336
	bl paredes
	
	mov x4,16
	mov x5,64
	mov x6,352
	mov x7,368
	bl paredes
	
	mov x4,32
	mov x5,64
	mov x6,368
	mov x7,416
	bl paredes
	
	mov x4,32
	mov x5,48
	mov x6,416
	mov x7,480
	bl paredes
	
	mov x4,48
	mov x5,224
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,64
	mov x5,192
	mov x6,432
	mov x7,448
	bl paredes
	
	mov x4,176
	mov x5,192
	mov x6,368
	mov x7,432
	bl paredes
	
	mov x4,160
	mov x5,176
	mov x6,368
	mov x7,384
	bl paredes
	
	mov x4,240
	mov x5,256
	mov x6,416
	mov x7,480
	bl paredes

	mov x4,256
	mov x5,384
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,400
	mov x5,464
	mov x6,464
	mov x7,480
	bl paredes
	
	mov x4,448
	mov x5,464
	mov x6,240
	mov x7,464
	bl paredes
	
	mov x4,464
	mov x5,480
	mov x6,240
	mov x7,256
	bl paredes
	
	mov x4,432
	mov x5,448
	mov x6,352
	mov x7,368
	bl paredes
	
	mov x4,480
	mov x5,496
	mov x6,272
	mov x7,496
	bl paredes

	mov x4,48
	mov x5,208
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,112
	mov x7,304
	bl paredes

	mov x4,80
	mov x5,128
	mov x6,272
	mov x7,288
	bl paredes

	mov x4,80
	mov x5,96
	mov x6,288
	mov x7,384
	bl paredes

	mov x4,80
	mov x5,112
	mov x6,384
	mov x7,416
	bl paredes
	
	mov x4,128
	mov x5,144
	mov x6,224
	mov x7,416
	bl paredes

	mov x4,112
	mov x5,128
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,144
	mov x5,160
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,368
	mov x5,400
	mov x6,336
	mov x7,416
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,336
	mov x7,352
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,336
	mov x7,400
	bl paredes

	mov x4,272
	mov x5,352
	mov x6,336
	mov x7,352
	bl paredes

	mov x4,272
	mov x5,352
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,352
	mov x7,400
	bl paredes

	mov x4,272
	mov x5,320
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,272
	mov x5,432
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,368
	mov x7,432
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,320
	mov x7,448
	bl paredes

	mov x4,160
	mov x5,288
	mov x6,304
	mov x7,320
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,320
	mov x7,352
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,64
	mov x5,240
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,64
	mov x5,240
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,320
	mov x5,480
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,288
	mov x5,480
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,48
	mov x7,144
	bl paredes

	mov x4,256
	mov x5,304
	mov x6,80
	mov x7,96
	bl paredes

	mov x4,288
	mov x5,400
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,112
	mov x5,208
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,256
	mov x5,304
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,336
	mov x5,368
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,112
	mov x5,144
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,160
	mov x5,272
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,112
	mov x5,160
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,192
	mov x5,272
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,448
	mov x5,480
	mov x6,80
	mov x7,160
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,160
	mov x7,224
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,96
	mov x7,192
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,256
	mov x7,336
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,112
	mov x7,240
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,288
	mov x7,320
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,144
	mov x7,208
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,288
	mov x7,320
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,16
	mov x7,32
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,160
	mov x7,240
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,256
	mov x7,288
	bl paredes

	mov x4,288
	mov x5,304
	mov x6,48
	mov x7,80
	bl paredes

	mov x4,288
	mov x5,304
	mov x6,160
	mov x7,256
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,16
	mov x7,64
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,208
	mov x7,256
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,224
	mov x7,256
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,208
	mov x7,288
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,192
	mov x7,288
	bl paredes

	mov x4,224
	mov x5,304
	mov x6,272
	mov x7,288
	bl paredes

	mov x4,304
	mov x5,352
	mov x6,304
	mov x7,320
	bl paredes

	mov x4,336
	mov x5,416
	mov x6,256
	mov x7,272
	bl paredes

	mov x4,336
	mov x5,384
	mov x6,224
	mov x7,240
	bl paredes

	mov x4,416
	mov x5,448
	mov x6,208
	mov x7,240
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,128
	mov x7,256
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,112
	mov x5,128
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,240
	mov x7,256
	bl paredes
	
	// Color del Personaje
//	mov w3, 0x0000   	// Color negro
//	add x10,x0,0
	mov x8,x24
	mov x9,x25
	b cont

evil_laberinto: //----------------------------------------------------------------------------------------------------------------------------------------
	mov w21, #0x08
	str w21, [x20, #0x1C] //enciendo verde

	mov w21, 0x04
	str w21, [x20, 0x28] //apago rojo
	
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer

	mov x28,#1          // aux en 1 indica tablero celeste, led verde
	mov w3, 0x0000    	// 0x000 = Negro
	add x10, x0, 0		// X10 Contiene la dirección base del framebuffer
	
	mov x2,512         	// Tamaño en Y
efondo1:
	mov x1,512         	// Tamaño en X	
efondo2:
	sturh w3,[x10]	   	// Setear el color del pixel N
	add x10,x10,2	   	// Siguiente pixel
	sub x1,x1,1	   	// Decrementar el contador X
	cbnz x1,efondo2	   	// Si no terminó la fila, volver a pintar
	sub x2,x2,1	   	// Decrementar el contador Y
	cbnz x2,efondo1	  	// Si no es la última fila, saltar

	mov w3,0x8DF9         // Setear color de paredes, celeste

//dibujar el laberinto lado b
	//tope de tablero
	mov x4,0		// Inicio de la figura, argumento inicio x
	mov x5,512		// Posicion final x
	mov x6,0		// Posicion inicio y
	mov x7,16		// Posicion final y
	bl paredes		// Ir a la funcion paredes	
	//izq tablero
	mov x4,0
	mov x5,16
	mov x6,0
	mov x7,512
	bl paredes
	//base tablero
	mov x4,0
	mov x5,512
	mov x6,496
	mov x7,512
	bl paredes
	//der tablero
	mov x4,496
	mov x5,512
	mov x6,0
	mov x7,512
	bl paredes

	mov x4,288
	mov x5,320
	mov x6,320
	mov x7,352
	bl paredes

	mov x4,304
	mov x5,320
	mov x6,352
	mov x7,384
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,352
	mov x7,384
	bl paredes

	mov x4,272
	mov x5,304
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,64
	mov x5,288
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,336
	mov x7,448
	bl paredes

	mov x4,80
	mov x5,176
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,384
	mov x7,432
	bl paredes

	mov x4,96
	mov x5,160
	mov x6,384
	mov x7,400
	bl paredes

	mov x4,128
	mov x5,144
	mov x6,352
	mov x7,416
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,96
	mov x5,128
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,336
	mov x7,400
	bl paredes

	mov x4,160
	mov x5,208
	mov x6,352
	mov x7,368
	bl paredes

	mov x4,192
	mov x5,240
	mov x6,416
	mov x7,432
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,368
	mov x7,416
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,352
	mov x7,464
	bl paredes

	mov x4,32
	mov x5,160
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,464
	mov x7,496
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,480
	mov x7,496
	bl paredes

	mov x4,192
	mov x5,240
	mov x6,448
	mov x7,464
	bl paredes

	mov x4,208
	mov x5,224
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,416
	mov x7,480
	bl paredes

	mov x4,272
	mov x5,384
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,272
	mov x5,336
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,352
	mov x5,432
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,432
	mov x7,448
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,464
	mov x7,496
	bl paredes

	mov x4,416
	mov x5,480
	mov x6,464
	mov x7,480
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,208
	mov x7,464
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,80
	mov x7,192
	bl paredes

	mov x4,464
	mov x5,480
	mov x6,16
	mov x7,64
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,16
	mov x7,32
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,400
	mov x5,464
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,16
	mov x7,48
	bl paredes

	mov x4,224
	mov x5,384
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,48
	mov x7,160
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,48
	mov x7,80
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,240
	mov x5,272
	mov x6,96
	mov x7,128
	bl paredes

	mov x4,288
	mov x5,320
	mov x6,64
	mov x7,96
	bl paredes

	mov x4,352
	mov x5,400
	mov x6,80
	mov x7,112
	bl paredes

	mov x4,368
	mov x5,384
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,320
	mov x5,352
	mov x6,80
	mov x7,96
	bl paredes

	mov x4,416
	mov x5,448
	mov x6,80
	mov x7,112
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,112
	mov x7,176
	bl paredes

	mov x4,448
	mov x5,464
	mov x6,160
	mov x7,176
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,96
	mov x7,272
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,192
	mov x7,272
	bl paredes

	mov x4,416
	mov x5,432
	mov x6,192
	mov x7,208
	bl paredes

	mov x4,432
	mov x5,448
	mov x6,288
	mov x7,416
	bl paredes

	mov x4,400
	mov x5,416
	mov x6,320
	mov x7,432
	bl paredes

	mov x4,368
	mov x5,384
	mov x6,320
	mov x7,416
	bl paredes

	mov x4,384
	mov x5,400
	mov x6,320
	mov x7,336
	bl paredes

	mov x4,272
	mov x5,368
	mov x6,400
	mov x7,416
	bl paredes

	mov x4,320
	mov x5,432
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,272
	mov x5,288
	mov x6,368
	mov x7,384
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,320
	mov x7,384
	bl paredes

	mov x4,320
	mov x5,400
	mov x6,240
	mov x7,256
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,256
	mov x7,272
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,128
	mov x7,144
	bl paredes

	mov x4,352
	mov x5,368
	mov x6,208
	mov x7,224
	bl paredes

	mov x4,368
	mov x5,384
	mov x6,128
	mov x7,224
	bl paredes

	mov x4,336
	mov x5,352
	mov x6,176
	mov x7,224
	bl paredes

	mov x4,320
	mov x5,336
	mov x6,112
	mov x7,192
	bl paredes

	mov x4,288
	mov x5,320
	mov x6,112
	mov x7,128
	bl paredes

	mov x4,256
	mov x5,304
	mov x6,144
	mov x7,160
	bl paredes

	mov x4,32
	mov x5,160
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,48
	mov x7,64
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,80
	mov x7,96
	bl paredes

	mov x4,144
	mov x5,176
	mov x6,64
	mov x7,96
	bl paredes

	mov x4,16
	mov x5,128
	mov x6,64
	mov x7,80
	bl paredes

	mov x4,16
	mov x5,32
	mov x6,96
	mov x7,272
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,256
	mov x7,336
	bl paredes

	mov x4,32
	mov x5,48
	mov x6,112
	mov x7,128
	bl paredes

	mov x4,48
	mov x5,64
	mov x6,112
	mov x7,240
	bl paredes

	mov x4,80
	mov x5,96
	mov x6,96
	mov x7,240
	bl paredes

	mov x4,112
	mov x5,128
	mov x6,96
	mov x7,240
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,96
	mov x7,112
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,224
	mov x7,240
	bl paredes

	mov x4,128
	mov x5,176
	mov x6,112
	mov x7,128
	bl paredes

	mov x4,144
	mov x5,208
	mov x6,144
	mov x7,160
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,16
	mov x7,144
	bl paredes

	mov x4,144
	mov x5,160
	mov x6,160
	mov x7,256
	bl paredes

	mov x4,160
	mov x5,176
	mov x6,208
	mov x7,224
	bl paredes

	mov x4,64
	mov x5,80
	mov x6,256
	mov x7,304
	bl paredes

	mov x4,80
	mov x5,128
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,96
	mov x5,112
	mov x6,272
	mov x7,288
	bl paredes

	mov x4,96
	mov x5,272
	mov x6,256
	mov x7,272
	bl paredes

	mov x4,144
	mov x5,288
	mov x6,288
	mov x7,304
	bl paredes

	mov x4,224
	mov x5,304
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,288
	mov x5,304
	mov x6,192
	mov x7,288
	bl paredes

	mov x4,304
	mov x5,320
	mov x6,208
	mov x7,224
	bl paredes

	mov x4,32
	mov x5,160
	mov x6,32
	mov x7,48
	bl paredes

	mov x4,192
	mov x5,208
	mov x6,176
	mov x7,256
	bl paredes

	mov x4,256
	mov x5,272
	mov x6,208
	mov x7,256
	bl paredes

	mov x4,224
	mov x5,240
	mov x6,208
	mov x7,240
	bl paredes

	mov x4,240
	mov x5,256
	mov x6,208
	mov x7,224
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,176
	mov x7,192
	bl paredes

	mov x4,176
	mov x5,192
	mov x6,240
	mov x7,256
	bl paredes

	// Color del Personaje
//	mov w3, 0xFFFF   	// Color blanco 
//	add x10,x0,0
	mov x8,x24
	mov x9,x25

cont: //------------------------------------------------------------------------------------------------------------------
	// Dibujar triggers--
	mov x4,80
	mov x5,240
	bl trigger

	mov x4,144
	mov x5,304
	bl trigger

	mov x4,160
	mov x5,480
	bl trigger

	mov x4,256
	mov x5,400
	bl trigger

	mov x4,416
	mov x5,352
	bl trigger

	mov x4,288
	mov x5,288
	bl trigger

	mov x4,272
	mov x5,256
	bl trigger	

	mov x4,208
	mov x5,176
	bl trigger

	mov x4,240
	mov x5,144
	bl trigger

	mov x4,400
	mov x5,80
	bl trigger

	// Meta- verde
	mov w3,0x3D4C
	mov x4,240
	mov x5,256
	mov x6,224
	mov x7,240
	bl paredes

	cbnz x28,pjn
	mov w3,0x0000
	b dibu
pjn:
	mov w3,0xFFFF
dibu:
	// Dibujar al Personaje
	mov x8,x24
	mov x9,x25
	add x12,x8,8            // Final del eje x del Personaje
	add x13,x9,8		// Final del eje y del Personaje

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
	
triggercheck:
	cbnz x27, cool //chequeo si el aux de enfriamiento esta activo

	add x10,x10,2    	// Asumiendo que x10 se mantiene despues del dibujo del Personaje
	ldurh w19,[x10]	   	// Tomar el color del pixel N
	mov w18,0xFDE1    	// Color del trigger- amarillo
	cmp w18,w19
	b.ne ver_meta    	// si no toca un trigger, ir a corroborar la meta

	//guardo coordenadas actuales
	mov x24, x8
	mov x25, x9

	//activo temporizador
	movz x27, #400, lsl #16     

	cmp x28,#0
	b.eq evil_laberinto
	
	mov x28,#0
	b laberinto
ver_meta:
	mov w18,0x3D4C		// Color de la meta- verde
	cmp w18,w19
	b.eq win			// Si llegue a la meta, termina todo!

cool:
	sub x27,x27,#1

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
	mov w18,#0xFA52  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	mov w18,#0x8DF9  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	sub x9,x9,5  		// Mueve el eje y del Personaje arriba
	sub x13,x13,5  		// Mueve el eje y del Personaje arriba
	b delay2
	
moverderecha:
	ldurh w18,[x10,#10]  	// Toma el valor del color en la direccion a la que se va a mover
	mov w19,#0xFA52  	// Guardar el valor de las paredes en w19
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	mov w19,#0x8DF9  	// Guardar el valor de las paredes en w19
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	add x8,x8,5  		// Mueve el eje x del Personaje a la derecha
	add x12,x12,5  		// Mueve el eje x del Personaje a la derecha
	b delay2
	
moverizquierda:
	ldurh w18,[x10,#-10]  	
	mov w19,#0xFA52  		
	cmp w18,w19      	
	b.eq delay2
	mov w19,#0x8DF9  		
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
	mov w18,#0xFA52  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
	cmp w18,w19      	// Comparar si el camino esta libre
	b.eq delay2    		// Si hay una pared de por medio, no moverse
	mov w18,#0x8DF9  	// Guardar el valor de las paredes en w19 (deshaciendose del valor anterior)
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
	b triggercheck

win:
	mov w21, #0x04
	str w21, [x20, #0x1C] //enciendo led rojo
	mov w21, #0x08
	str w21, [x20, #0x1C] //enciendo led verde
		
infloop:
	b infloop
	

//----glosario de registros----//
//x0: Direccion base de framebuffer- NO TOCAR
//x1: Tamaño en x de la pantalla- contador pinta fondos
//x2: Tamaño en y de la pantalla- contador pinta fondos
//w3: Color a enviar al framebuffer- color que pinta la pantalla
//x4: Paredes: xi. Triggers: xi 
//x5: Paredes: xf. Triggers: yi. Pj-offset x pixel
//x6: Paredes: yi. Triggers: r. Pj-cont x
//x7: Paredes: yf. Triggers: w7 aux de color anterior. Pj-cont y
//x8: Eje x del Pj	   				 Aux trigger-xmin. 
//x9: Eje y del Pj. Aux pared-offsety. Aux trigger-xmax. 
//x10: Direccion base del framebuffer MAS el offset en pixeles
//x11: Usado para delays
//x12: Aux pared-offsetx. Aux trigger-ymin. Pj-fin eje x
//x13: Aux pared-distfila. Aux trigger-ymax. Pj-fin eje y
//x14: Ancho framebuffer. y despues para Personaje
//x15: * 2 bytes por pixel y despues para Personaje
//w16: Usado para el refondo, donde se carga el valor del color en un pixel
//x17: Pj-offset y pixel; suma offsets
//x18: Auxiliar de color- color comparador
//x19: Auxiliar de color- color de la celda
//w20: Direccion de GPIO- NO TOCAR
//x21: Inicializar y configurar GPIO
//x22: Para GPIO- toma el boton apretado
//x23: Auxiliar para GPIO
//x24: Guarda coordenada x del personaje para el salto
//x25: Guarda coordenada y del personaje para el salto
//x26: Aux paredes y triggers
//x27: Cooler para triggers
//x28: Indicador de tablero: 0-Laberinto rosa; 1-Evil Laberinto celeste
//x29:
//x30: Para link- NO TOCAR

//GPIO14=arriba, GPIO17=abajo, GPIO18=izquierda, GPIO15=derecha
//led rojo=GPIO3, led verde=GPIO2
//-----//
