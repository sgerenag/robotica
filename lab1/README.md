# Laboratorio 1 - Robótica Industrial No 1

## Metodología


### Diseño de la herramienta:
Se diseñó una herramienta en Fusion 360 que sostuviera al marcador. Se dibuja la base para que tenga los huecos para un tornillo M6 y que estén dispuestos de igual manera que en el plato del robot. En la punta se modela una a rosca M24 con paso de 3mm para enroscar una tapa (con la misma rosca) que tiene un agujero por donde sobresale la punta del marcador. El eje del tubo se modela formando un ángulo de 50 grados con respecto a la horizontal de la herramienta. Esto se realizó con el objetivo de facilitar la escritura y mejorar la rigidez de la sujeción del marcador. Al interior del tubo de la herramienta se introduce un marcador pero antes de este se introduce un resorte. Este permite modular la presión sobre la punta del marcador cuando el robot escribe sobre el tablero. Esto es importante para que el robot no mueva el tablero mientras escribe y para que tenga cierta tolerancia respecto a la definición de los 3 puntos que toma de referencia el robot.
En cuanto a la impresión en 3d, esta herramienta tomó 7 horas en su impresión. Se imprimió con material PLA, con una estructura interna hexagonal y con un relleno al 50%.
Una vez impresa la pieza, se retiró la rebaba sobrante y en particular se utilizó una lija para lograr que la tapa se pudiera enroscar con la tapa. 

![image](https://user-images.githubusercontent.com/37639887/188252280-6c8dfb24-d5ab-4b71-9382-1f3b9d49c69f.png)
![image](https://user-images.githubusercontent.com/37639887/188252345-2607a76a-2e65-4cdf-a302-044ae4b66fab.png)



### Diseño del codigo: 
Para el diseño del codigo, primero se importan la herramienta y el objeto de trabajo sobre el cual se va a trabajar, para esto se importa la geometria del objeto en la estacion de trabajo y tambien se posiciona la herramienta en el brazo, de forma que obtenemos el siguiente esquema  

![image](https://user-images.githubusercontent.com/38962033/188245916-d6d916a5-4c54-4465-b880-f4725411326f.png)  

Vemos como se ve el tcp de la herramienta mas sin embargo aun no se ha creado el marco del workobject, a continuacion se crea este objeto. Resulta necesario debido a que en el mundo real este objeto sobre el que se trabaja no siempre esta a la misma distancia del brazo, asi como para hacer el codigo mas robusto a cambios del entorno se busca que el codigo se exprese en terminos del marco de referencia del objeto.

El proceso para crear el marco de referencia del objeto es el siguiente: primero vamos a la pestaña de posicion inicial, vamos a programacion de trayectorias y en la pestaña otros, seleccionamos la opcion "crear objeto de trabajo"  
![image](https://user-images.githubusercontent.com/38962033/188246774-135f161f-3738-45ea-9e6c-37d200213212.png)

El segundo paso es en la pestaña que se abre, ir a la seccion de sistema de coordenadas usuario y la fila "sistema de coordenadas por puntos" abrimos la pestaña y seleccionamos la opcion de tres puntos  
![image](https://user-images.githubusercontent.com/38962033/188247350-f75e1f99-4a78-472e-ad2f-905ef48883a2.png)

En el siguiente paso, procedemos a guardar los puntos mostrados a continuacion, el programa interpreta estos puntos y a partir de estos, generara el marco de referencia del objeto de trabajo, a continuacion se evidencia el orden en el que se hizo en el codigo ( esta parte del orden es importante, ya que a la hora de la implementacion en el laboratorio, el orden en el que se generan los puntos es importante para que el marco del objeto guardado en el brazo real concuerde con el codigo cargado)  
![image](https://user-images.githubusercontent.com/38962033/188247686-370c535a-f9d3-4f7f-af2e-b30552d39dd1.png)

Luego de esto damos a aceptar y a guardar la configuracion del workobject, de esta manera se crea el workobject y podemos ver que fue creado efectivamente ya que aparecera un marco de referencia en el objeto de la siguiente manera  
![image](https://user-images.githubusercontent.com/38962033/188247926-38977d02-9e1d-49d1-bbfb-4a17de163539.png)  

Ademas que debe aparecer en la pestaña de trayectorias y puntos el nuevo marco de referencia como se ve en la siguiente imagen
![image](https://user-images.githubusercontent.com/38962033/188248022-47533472-f7d7-4208-849a-6ec8b33103ea.png)  

El siguiente paso es crear los puntos sobre los cuales se generara la trayectoria del robot, primero debemos asegurarnos de trabajar con el tcp de la herramienta creada y el workobject que creamos en el paso anterior, esto se mira en la pestaña posicion inicial. En la seccion "Parametros" en "oobjeto de trabajo" seleccionamos el workobject y en herramienta, trabajamos con nuestra herramienta.  

Una vez se verifica esto, procedemos a crear los puntos, estos se crean en la pestaña posicion inicial, en la seccion "programacion de trayectorias" y en "posicion" selecionamos "crear punto" como se evidencia a continuacion  
![image](https://user-images.githubusercontent.com/38962033/188248303-c871f663-266f-4cbf-a042-f8bc867cf728.png)  

Importante, se abrira una pestaña en el lado izquierdo, en este cambiamos la referencia al workobject para que la posicion generada este en terminos del marco de referencia del objeto de trabajo. Tambien tenemos que tener en cuenta una posicion de acercamiento o alejamiento cada que el robot acabe o vaya a empezar una trayectoria cerrada, esto por seguridad del robot y para tener en cuenta la inercia de la herramienta y no hacer movimientos tan bruscos. para facilitar la creacion de los puntos damos clic a la opcion marcada en la imagen de abajo, el cual nos permite seleccionar automaticamente esquinas y puntos medios de aristas con acercarnos lo suficiente.  
![image](https://user-images.githubusercontent.com/38962033/188248724-0f8d7133-b6ce-48b5-9d49-040391b6ed92.png)  

Una vez creado los puntos tendremos algo como lo que se muestra en la siguiente imagen, es importante justo despues de crear los puntos revisar no solo la posicion de la herramienta sino del brazo en esa posicion, esto para evitar complicaciones con las articulaciones o la herramienta. Podemos cambiar la orientacion de la herramienta y el brazo en esa posicion si es necesario, en este caso, con encontrar una orientacion comoda e igualar todos los puntos a la misma orientacion fue suficiente para evitar este problema, a continuacion se aprecian los puntos y ya todos orientados igualmente  
![image](https://user-images.githubusercontent.com/38962033/188248989-237b7cc7-c199-4d9f-99d7-13db317ab960.png)  

Para crear la trayectoria, seleccionamos todas las posiciones creadas y damos clic izquierdo sobre la seleccion, posteriormente vamos a "añadir a nueva trayectoria", con esto se crea automaticamente la trayectoria a travez de los puntos, importante a la hora de crear los puntos guardar un orden en la ruta consecuente a la creacion del punto, para guardar un sentido en la trayectoria creada.  
![image](https://user-images.githubusercontent.com/38962033/188249634-5ec19afd-c106-4d97-b16f-ca9c9f2d290e.png)

### Programación y prueba con el robot:
Inicialmente se introduce la usb con el programa cargado, se va  a module en la pestaña superior y se buscan y se cargan los archivos en la usb CalibData y Module1.
![image](https://user-images.githubusercontent.com/37639887/188256202-32ce2b45-3d25-4cb5-ba8b-d17cff9e2619.png)

Ahora vamos a “Jogging” y aquí cambiamos la herramienta y el objeto de trabajo que tiene por defecto el flexpendant. Vamos al menu y aqui escogemos “program data” y aquí primero definiremos el “work object” presionando en wobjdata. 

![image](https://user-images.githubusercontent.com/37639887/188256208-96592a86-3b1a-4d30-8944-67bcfe1796bb.png)

Al hacer click aquí, seleccionamos “Workobject_1”, que es nuestro work object. Después vamos a “edit” y seleccionamos “define”.

![image](https://user-images.githubusercontent.com/37639887/188256222-cc155bbe-53a6-4700-87fa-2cada9630bf7.png)

En este punto debemos configurar el work-object por medio del método de 3 puntos, para esto seleccionamos esta opción del menú “User Method”.
![image](https://user-images.githubusercontent.com/37639887/188256231-3f01591e-c733-4328-a8d6-6760768b4259.png)


Ahora lo que hicimos fue ubicar al robot en cada uno de los puntos X1, X2, Y1 correspondientes con el plano sobre el cual trabajaría el robot. Una vez en cada punto, seleccionamos “Modify Position” para guardar la coordenada en el punto. Al tener los 3 puntos definidos, seleccionamos ok y así se define el work object sobre el plano físico sobre el cual trabajaremos.

Ahora seleccionamos la herramienta en el programa yendo de nuevo en el menú a “Jogging” y se selecciona Tool. Aquí escogemos la herramienta de nuestro programa y damos ok.
![image](https://user-images.githubusercontent.com/37639887/188256249-b55b2b53-5f45-413a-861f-5196a2af0d0e.png)


Ya con la herramienta y el objeto de trabajo configurados, podemos correr el programa. Esto lo hacemos dirigiéndonos en el menú a programa editor, después a “debug” y aquí, seleccionamos “PP to Main”.
![image](https://user-images.githubusercontent.com/37639887/188256255-80c0690b-10a1-492f-a1b1-b38ee29118b8.png)

Ya con esto, se puede hacer click sobre el botón de “play” ubicado en la parte inferior derecha del flexpendant. A continuación el robot ejecutará el programa sobre el objeto de trabajo configurado.
![image](https://user-images.githubusercontent.com/37639887/188256258-d19d4ed7-a67d-483d-96b3-4a53dc358a94.png)



## Resultados:
	
Herramienta:
Se obtuvo como resultado de la impresión en 3d la herramienta impresa con un peso de 56g. Esta se logro acoplar muy bien al robot.

<img src="https://user-images.githubusercontent.com/37639887/188252846-15744b92-14f8-49e5-b381-9c9702881be8.png" width="200" height="auto" style="display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;">
	
Simulación:
Se obtuvo la simulación del movimiento del robot con las letras DA.
En el siguiente link se observa la simulación lograda con robotstudio: 
	Programa y prueba con el robot: https://youtu.be/fxF33lgCepg
	Se logró realizar la escritura de las letras en el tablero como se ve en el video a continuación:
	Link al video: https://youtu.be/jJ5Ot2ZODrU

## Analisis

## Conclusiones:
La definición de un work object permite realizar una operación para la que fue programado el robot sobre un plano que se define en la práctica en el lugar de trabajo. Esto permite el uso del mismo programa cuando hay cambios o se desconoce en cierta medida el entorno de trabajo en el que el robot hará la tarea. Todo esto sin necesidad de reescribir un programa para la misma tarea.

El poder simular al robot en software permite que se tenga certeza de que el programa se ejecuta como uno espera y también permite detectar los errores o aspectos indeseables del programa y todo esto sin disponer del robot. Esto facilita la labor de programación y depuración, pues así  no se requiere tener un robot al lado para poderlo programar y además hace que el proceso de programación y diseño del programa sea más seguro para las personas, el robot y su entorno.








