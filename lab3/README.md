# lab 2 robotica. Robotica en desarrollo introduccion a ROS
### Daniel Melo Avila
### Sergio Andres Gerena Gomez

## Metodologia
### Creacion de programa RAPID

Inicialmente se crean trayectorias por medio de los metodos aprendidos en el laboratorio 1. Esto se hace de manera que el robot comience en la posicion de home y ,por medio de movimientos J, pase por una pose comoda para instalar la herramienta y posteriormente se aproxime al suelo a realizar la forma de la Y. Ya estando cerca de la superficie donde se escribira, se utilizan movimientos L para moverse entre targets ubicados en las esquinas de la Y. Finalmente se realiza el movimiento de nuevo hacia home primero pasando por un target intermedio para facilitar el movimiento hacia home. Las trayectorias para dirigirse hacia la pose de puesta de la herramienta se ubican dentro del procedimiento "instpose", mientras que el resto de trayecotorias que se aproximan, realizan la Y y se devuelven a home se ubican dentro de un solo procedimiento, "pathY".

![image](https://user-images.githubusercontent.com/37639887/194663490-bb06dc4b-22d3-409d-a33a-6428d929dcc4.png)
![image](https://user-images.githubusercontent.com/37639887/194664099-22cbb7e4-4ae9-407b-b9ff-f44215fa808a.png)

Ahora, para poder utilizar estas entradas y salida en el programa, primero reiniciamos el controlador el boton con la flecha circular en la pestana "controller". 

![image](https://user-images.githubusercontent.com/37639887/194668667-d481988c-0af1-4772-abdb-e5fec9cf4c9f.png)

Posterior a esto, nos dirigimos a home, paths and targets, click derecho sobre "main" y seleccionar insertar una instruccion de accion, se abre la siguiente ventana:

![image](https://user-images.githubusercontent.com/37639887/194669405-6b9d778f-32af-40f5-ab0b-615781a8e0fb.png)

Aqui escogemos de "instruction templates" WaitDI para crear una instruccion que solo permita la continuacion de la ejecucion del programa una vez se se activa una entrada digital. En los argumentos de instruccion se selecciona el nombre de la senal que ya creamos y en value se selecciona 1. Hacemos click en crear.

![image](https://user-images.githubusercontent.com/37639887/194669896-c46ae72b-8258-46d4-8986-aee1a00c7c61.png)

De esta manrea creamos 2 instrucciones WaitDI, cada una para cada senal de entrada del programa. Estas instrucciones aparecen en main con un rayo amarillo a la izquierda bajo main en el arbol. Ademas de estas 2 entradas, se crea una instruccion Set para prender la salida DO_01. Esta tambien aparece en el arbol.

![image](https://user-images.githubusercontent.com/37639887/194670283-a303255b-bde4-409d-9469-223c31c8d517.png)

Ahora, para crear el programa arrastarmos los procedimientos "instpose" y "pathY" a main y asi observamos que se anaden al programa que se ejecutara. Para lograr el efecto de comenzar la rutina solo cuando el boton 1 se presiona, se ubica WaitDI DI_01 al principio del programa para que nada se pueda ejecutar hasta que DI_01 tenga el valor de 1.
A conitnuacion se ubica "instpose" para cambiar la herramienta de la pose de home a la de instalacion de herramienta.
Despues de esta se ubica WaitDI DI_02 y inmediatamente despues, Set DO_01 y pathY. Esta configuracion tiene el efecto de permitir esperar a ubicar la herramienta y solo una vez presionemos el boton 2, se ejecutara Set DO_01 (que prendera el boton verde) y pathY (que hara la Y y hara que el robot se devuelva a home). Finalmente se utiliza una instruccion Reset DO_01 para apagar el boton verde una vez el robot este en home y de esta manera poder comenzar otro ciclo con el boton apagado.

![image](https://user-images.githubusercontent.com/37639887/194670844-e13ec201-d1d8-40ef-b035-05e5b7c41032.png)

Ahora sincronizamos el programa con RAPID para generar el codigo RAPID correspondiente.

![image](https://user-images.githubusercontent.com/37639887/194671028-30a373d2-dd71-4dec-a508-27823068bf31.png)

Finalmente, para que este proceso se pueda ejecutar indefinidamente, se anade un while infinito al codigo de main:

![image](https://user-images.githubusercontent.com/37639887/194671181-3b95ef32-4ab4-4377-9239-23d42c4ae7c6.png)


### Configuracion de entradas y salidas
Al dirigirnos a controlador, en el arbol debajo de configuracion se escoge "I/O System". De la ventan que aparece a la derecha se selecciona "signal" con click derecho.

![image](https://user-images.githubusercontent.com/37639887/194667382-289936bc-d444-40e2-b2a1-043fea6088e3.png)

Al hacer click derecho, se selecciona "New Signal" y se abre la siguiente ventana, en donde se asigna el nombre de las senales y el tipo (entra o salida digital).

![image](https://user-images.githubusercontent.com/37639887/194668210-cedeeddd-0e89-4d61-9e62-4ffbec436437.png)

Por medio de la anterior ventan se crean las entradasdigitales DI_01, DI_02 y la salida DO_01. Para que estas senales creadas tomen efecto se debe reiniciar el controlador.

### Procedimiento en LabSir
![image](https://user-images.githubusercontent.com/37639887/194460002-4a99df66-c22d-45f0-b511-b05a8c76c5af.png)

Procedimiento en el labsir
Inicialmente se carga el programa de la usb. Se modifican en el sitio los nombres de las entradas en el programa si no corresponden a los ya configurados en el flexpendant.
  Posterior a esto, en jogging, se selecciona el workobject creado para el programa y el marco de herramienta creado en el programa. 
 ![image](https://user-images.githubusercontent.com/37639887/194460044-561136b6-05aa-4fc7-8a55-19d8746d93c8.png)

Con estos dos ajustes, se corrió primero el programa en aire para verificar que funcionara.

Ya verificado que se ejecuta, en programa data, se procede a redefinir el workobject por el método de 3 puntos en el piso del laboratorio. Adicionalmente se monta la herramienta con el marcador.
 ![image](https://user-images.githubusercontent.com/37639887/194460086-2a7e1776-a0ac-456d-a7da-63162ac9beb1.png)

Ya con esto, para correr el programa nos dirigimos a program editor > debug  y seleccionamos PP to Main.
 ![image](https://user-images.githubusercontent.com/37639887/194460131-efc4ffe4-638c-47b3-893e-49b5fb03a41b.png)

En este punto se puede seleccionar el botón para correr el programa. 

## Resultados
Al correr el programa, se presiona el botón 1, por lo que el robot pasara de estar en home a estar en una posición que facilita sujetar la herramienta.

![image](https://user-images.githubusercontent.com/37639887/194460645-4c3ac029-c282-493d-8048-2bbdccb9088c.png) 
![image](https://user-images.githubusercontent.com/37639887/194460425-f6845a4f-bd55-461e-b6a3-6c896bb03d85.png)
![image](https://user-images.githubusercontent.com/37639887/194461464-09eeee80-351c-4106-8791-702eb9513eb7.png)

Despues de esto se presiona el boton 2, se observa que se prende el bombillo verdy y el robot hace la rutina de la figura sobre el tablero hasta devolverse a home.

![image](https://user-images.githubusercontent.com/37639887/194461635-c9a93aa0-4104-4ee4-a673-5cb569bebdbd.png)
![image](https://user-images.githubusercontent.com/37639887/194461729-2c7612fd-04c0-420a-9dbf-188b4751c367.png)
![image](https://user-images.githubusercontent.com/37639887/194461773-2f06d096-6af7-41fc-bf5a-96afe7cc5156.png)
![image](https://user-images.githubusercontent.com/37639887/194461797-c539a27c-6f66-4f32-a8cb-112726297b85.png)
![image](https://user-images.githubusercontent.com/37639887/194461826-18959966-749f-43bf-bf98-6cf4703a1be9.png)

### Video del robot ejecutando la rutina:
https://www.youtube.com/watch?v=uS5VfN7vxlw&t=14s
### Video de simulacion:

## Analisis


## Conclusiones
La implementacion de entradas externas al robot controladas por el usuario son un medio para que el usuario peuda controlar lo que hara el robot deacuerdo a la necesidad que tenga. En particular, le permite controlar los tiempos en los que el robot ejecuta cada rutina y esto le conviene al usuario, pues asi puede solicitar la accion del robot solo cuando la necesita (en este caso, cuando la herramienta ya esta instalada).

Un programa de rapid puede controlar senales que no son del robot (como un bombillo). Estos pueden ser utles para complementar la funcion del robot, como lo seria un bombillo para senalizar que el robot se esta moviendo.
