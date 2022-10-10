# lab 3 robotica. 
### Daniel Melo Avila
### Sergio Andres Gerena Gomez

## Introduccion
A continuacion se describe el desarrollo del laboratorio 3 de robotica. Los links de simulacion y practica son los siguientes:

https://www.youtube.com/watch?v=uS5VfN7vxlw&t=14s

https://vimeo.com/758121587/73d2241945

## Metodologia
### Creacion de programa RAPID

Inicialmente, se crean trayectorias por medio de los métodos aprendidos en el laboratorio 1. Esto se hace de manera que el robot comience en la posición de home y, por medio de movimientos J, pase por una pose cómoda para instalar la herramienta y posteriormente se aproxime al suelo a realizar la forma de la Y. Ya estando cerca de la superficie donde se escribirá, se utilizan movimientos L para moverse entre targets ubicados en las esquinas de la Y. Finalmente se realiza el movimiento de nuevo hacia home primero pasando por un target intermedio para facilitar el movimiento hacia home. Las trayectorias para dirigirse hacia la pose de puesta de la herramienta se ubican dentro del procedimiento "instpose", mientras que el resto de trayectorias que se aproximan, realizan la Y y se devuelven a home se ubican dentro de un solo procedimiento, "pathY".

![image](https://user-images.githubusercontent.com/37639887/194663490-bb06dc4b-22d3-409d-a33a-6428d929dcc4.png)
![image](https://user-images.githubusercontent.com/37639887/194664099-22cbb7e4-4ae9-407b-b9ff-f44215fa808a.png)


### Configuracion de entradas y salidas
Al dirigirnos a controlador, en el árbol debajo de configuración se escoge "I/O System". De la ventana que aparece a la derecha se selecciona "signal" con clic derecho.

![image](https://user-images.githubusercontent.com/37639887/194667382-289936bc-d444-40e2-b2a1-043fea6088e3.png)

Al hacer clic derecho, se selecciona "New Signal" y se abre la siguiente ventana, en donde se asigna el nombre de las señales y el tipo (entra o salida digital).

![image](https://user-images.githubusercontent.com/37639887/194668210-cedeeddd-0e89-4d61-9e62-4ffbec436437.png)

Por medio de la anterior ventana se crean las entradas digitales DI_01, DI_02 y la salida DO_01. Para que estas señales creadas tomen efecto se debe reiniciar el controlador.

Ahora, para poder utilizar estas entradas y salida en el programa, primero reiniciamos el controlador, el botón con la flecha circular en la pestaña "controller". 

![image](https://user-images.githubusercontent.com/37639887/194668667-d481988c-0af1-4772-abdb-e5fec9cf4c9f.png)

Posterior a esto, nos dirigimos a home, paths and targets, clic derecho sobre "main" y seleccionar insertar una instrucción de acción, se abre la siguiente ventana:

![image](https://user-images.githubusercontent.com/37639887/194669405-6b9d778f-32af-40f5-ab0b-615781a8e0fb.png)

Aquí escogemos de "instruction templates" WaitDI para crear una instrucción que solo permita la continuación de la ejecución del programa una vez se activa una entrada digital. En los argumentos de instrucción se selecciona el nombre de la señal que ya creamos y en value se selecciona 1. Hacemos clic en crear.

![image](https://user-images.githubusercontent.com/37639887/194669896-c46ae72b-8258-46d4-8986-aee1a00c7c61.png)

De esta manera creamos 2 instrucciones WaitDI, cada una para cada señal de entrada del programa. Estas instrucciones aparecen en main con un rayo amarillo a la izquierda bajo main en el árbol. Además de estas 2 entradas, se crea una instrucción Set para prender la salida DO_01. Esta también aparece en el árbol.

![image](https://user-images.githubusercontent.com/37639887/194670283-a303255b-bde4-409d-9469-223c31c8d517.png)

Ahora, para crear el programa arrastramos los procedimientos "instpose" y "pathY" a main y así observamos que se añaden al programa que se ejecutara. Para lograr el efecto de comenzar la rutina solo cuando el botón 1 se presiona, se ubica WaitDI DI_01 al principio del programa para que nada se pueda ejecutar hasta que DI_01 tenga el valor de 1.
A continuación se ubica "instpose" para cambiar la herramienta de la pose de home a la de instalación de herramienta.
Después de esta se ubica WaitDI DI_02 y inmediatamente después, Set DO_01 y pathY. Esta configuración tiene el efecto de permitir esperar a ubicar la herramienta y solo una vez presionemos el botón 2, se ejecutará Set DO_01 (qué prendera el botón verde) y pathY (que hara la Y y hara que el robot se devuelva a home). Finalmente, se utiliza una instrucción Reset DO_01 para apagar el botón verde una vez el robot este en home y de esta manera poder comenzar otro ciclo con el botón apagado.

![image](https://user-images.githubusercontent.com/37639887/194670844-e13ec201-d1d8-40ef-b035-05e5b7c41032.png)

Ahora sincronizamos el programa con RAPID para generar el código RAPID correspondiente.

![image](https://user-images.githubusercontent.com/37639887/194671028-30a373d2-dd71-4dec-a508-27823068bf31.png)

Finalmente, para que este proceso se pueda ejecutar indefinidamente, se añade un while infinito al código de main:

![image](https://user-images.githubusercontent.com/37639887/194671181-3b95ef32-4ab4-4377-9239-23d42c4ae7c6.png)

### Procedimiento en LabSir
![image](https://user-images.githubusercontent.com/37639887/194460002-4a99df66-c22d-45f0-b511-b05a8c76c5af.png)

Procedimiento en el labsir:

Inicialmente, se carga el programa de la usb. Se modifican en el sitio los nombres de las entradas en el programa si no corresponden a los ya configurados en el flexpendant.
  Posterior a esto, en jogging, se selecciona el workobject creado para el programa y el marco de herramienta creado en el programa. 
  
  ![image](https://user-images.githubusercontent.com/37639887/194460044-561136b6-05aa-4fc7-8a55-19d8746d93c8.png)

Con estos dos ajustes, se corrió primero el programa en aire para verificar que funcionara.

Ya verificado que se ejecuta, en programa data, se procede a redefinir el workobject por el método de 3 puntos en el piso del laboratorio. Adicionalmente, se monta la herramienta con el marcador.

 ![image](https://user-images.githubusercontent.com/37639887/194460086-2a7e1776-a0ac-456d-a7da-63162ac9beb1.png)

Ya con esto, para correr el programa nos dirigimos a program editor > debug  y seleccionamos PP to Main.
 
 ![image](https://user-images.githubusercontent.com/37639887/194460131-efc4ffe4-638c-47b3-893e-49b5fb03a41b.png)

  En este punto se puede seleccionar el botón para correr el programa. 

  ## Resultados
Al correr el programa, se presiona el botón 1, por lo que el robot pasara de estar en home a estar en una posición que facilita sujetar la herramienta.

![image](https://user-images.githubusercontent.com/37639887/194460645-4c3ac029-c282-493d-8048-2bbdccb9088c.png) 
![image](https://user-images.githubusercontent.com/37639887/194460425-f6845a4f-bd55-461e-b6a3-6c896bb03d85.png)
![image](https://user-images.githubusercontent.com/37639887/194461464-09eeee80-351c-4106-8791-702eb9513eb7.png)

Después de esto se presiona el botón 2, se observa que se prende el bombillo verde y el robot hace la rutina de la figura sobre el tablero hasta devolverse a home.

![image](https://user-images.githubusercontent.com/37639887/194461635-c9a93aa0-4104-4ee4-a673-5cb569bebdbd.png)
![image](https://user-images.githubusercontent.com/37639887/194461729-2c7612fd-04c0-420a-9dbf-188b4751c367.png)
![image](https://user-images.githubusercontent.com/37639887/194461773-2f06d096-6af7-41fc-bf5a-96afe7cc5156.png)
![image](https://user-images.githubusercontent.com/37639887/194461797-c539a27c-6f66-4f32-a8cb-112726297b85.png)
![image](https://user-images.githubusercontent.com/37639887/194461826-18959966-749f-43bf-bf98-6cf4703a1be9.png)

A continuación se proporcionan los links a los videos de la práctica y de la simulación:

### Video del robot ejecutando la rutina:

https://www.youtube.com/watch?v=uS5VfN7vxlw&t=14s

### Video de simulación:
https://vimeo.com/758121587/73d2241945


  ## Análisis de resultados

  El robot cumple con la tarea tal como lo esperado. Se observa que el robot comienza en la posición de home y solo se mueve cuando sele indica presionando el botón 1. Además realiza estos movimientos iniciales más rápidamente, como se espera de acuerdo a la programación de movimientos J. Una vez en la posición de instalación de la herramienta, el robot se queda quieto esperando al botón 2. Cuando este se presiona, se prende el bombillo verde en el flexpendant y se observa que el brazo baja tal como lo esperado, orienta la herramienta de acuerdo a los objetivos y procede a dibujar la letra Y, y ininterrumpidamente, se devuelve a la posición de home pasando primero por la posición intermedia. Finalmente, al terminar la ejecución de path Y el robot para de nuevo, esperando la señal del botón 1.

  Respecto a la simulación, se observa que el robot se comporta idénticamente al anterior párrafo, con la única diferencia de que la letra Y se dibuja sobre un workobjetct ubicado en el programa y no sobre uno ubicado sobre el piso del tablero.

  ## Conclusiones
  La implementación de entradas externas al robot controladas por el usuario son un medio para que el usuario pueda controlar lo que hará el robot de acuerdo a la necesidad que tenga. En particular, le permite controlar los tiempos en los que el robot ejecuta cada rutina y esto le conviene al usuario, pues así puede solicitar la acción del robot solo cuando la necesita (en este caso, cuando la herramienta ya está instalada).

  Un programa de rapid puede controlar señales que no son del robot (como un bombillo). Estas pueden ser útiles para complementar la función del robot, como lo sería un bombillo para señalizar que el robot se está moviendo u otro tipo de actuadores que se puedan controlar por medio de señales digitales, como una válvula de un fluido que accione un cilindro, por ejemplo.

  Robot Studio permite programar y simular la interacción del robot con las entradas y salidas que tendrá el programa, permitiendo así verificar el resultado de la programación antes de correr el código en el robot físico. Esto permite disminuye el riesgo de accidentes y permite ahorrar tiempo de depuración, pues hace que no se requiera al robot físico para corroborar el funcionamiento del programa interactuando con entradas y salidas.
