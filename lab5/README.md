# lab 5 robotica. 

### Sergio Andres Gerena Gomez


## Metodologia
### Analisis
El primer paso es desarrollar el analicis de la sinematica inversa del brazo, partiendo de la siguiente geometria, podemos realizar el siguiente analisis matematico
![image](https://user-images.githubusercontent.com/38962033/199860851-7d300dd7-0d80-43bc-bd3f-8224737be053.png)
De aqui podemos inferir las siguientes ecuaciones para cada uno de los q que nos intereza

$$
\\begin{split}
q_1&=atan2(x,y)\\\\
q_2&=atan2\\left(\\sqrt{1-\\left(\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)^2},\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)+atan\\left(\\frac{(z-L_1)}{\\sqrt{x^2+y^2}}\\right)\\\\
q_3&=-atan2\\left(\\sqrt{1-\\left(\\left(\\frac{(\\sqrt{x^2+y^2-z^2}-L_4)^2}{(2*L_2)^2}\\right)^2-1\\right)^2},\\left(\\frac{(\\sqrt{x^2+y^2-z^2}-L_4)^2}{(2*L_2)^2}\\right)^2-1\\right)\\\\
q_4&=atan2\\left(\\sqrt{1-\\left(\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)^2},\\frac{\\sqrt{x^2+y^2-z^2}-L_4}{2*L_2}\\right)
\\end{split}
$$

### Comprobacion usando el toolbox

Para verificar estas ecuaciones se implemento un script en matlab donde se le da una posicion y se calcula los diversos valores articulares, posteriormente se comprueba mediante el uso del toolbox que con estos valores articulares se llegue a la posicion indicada, a continuacion se muestra las diversas pruebas
![image](https://user-images.githubusercontent.com/38962033/200090971-a3e10695-284d-40fb-bca8-2821b0ddaeef.png)

Ahora, para cada punto se calculo un vector con los diversos q mostrado a continuacion
![image](https://user-images.githubusercontent.com/38962033/200091104-66ab67a1-ba9f-4a46-8299-27444d8facf5.png)
donde cada fila indica una posicion en orden, y cada columna es un q desde q1 hasta q4, ahora empleando cinematica directa tenemos las siguientes salidas del robot para cada vector de q asociado a una posicion xyz

#### Posicion (x=50, y=250, z=40)
vector de Q

![image](https://user-images.githubusercontent.com/38962033/200091483-4bed67b6-9ed4-4146-977d-5b4acecc71ac.png)

Posicion del robot

![image](https://user-images.githubusercontent.com/38962033/200091566-c62a8871-6141-43cf-8cb3-6663ac9651ff.png)

![image](https://user-images.githubusercontent.com/38962033/200091626-dd9aafb1-ef7d-4fc9-b7dc-b4b8f8ed2a15.png)

#### Posicion (x=100, y=250, z=40)

Vector de Q

![image](https://user-images.githubusercontent.com/38962033/200091775-3e72deb7-f2ee-4ec2-aad0-727ca91402f3.png)

Posicion del robot

![image](https://user-images.githubusercontent.com/38962033/200091817-c71cbb75-ec8b-4ec9-9240-9c0537f6476d.png)

![image](https://user-images.githubusercontent.com/38962033/200091863-b768f70e-dcc2-4ce3-8b0f-3b92dfa63ebe.png)

#### Posicion (x=50, y=200, z=40)

Vector de Q

![image](https://user-images.githubusercontent.com/38962033/200091989-f6ddeb6c-5c5b-4e42-8273-694cb7e8860c.png)

Posicion del robot 

![image](https://user-images.githubusercontent.com/38962033/200092022-a4c0b640-0985-4330-9de3-d9399598182f.png)

![image](https://user-images.githubusercontent.com/38962033/200092100-8348501b-9248-4ea9-9e53-7fd5732ce2eb.png)

### Planeacion de trayectorias

El paso realizado es crear un archivo csv el cual contiene un mapa de puntos que describe la trayectoria deseada, incluyendo subidas y bajadas del marcador, entre las trayectorias programadas se encuentra. Ir por el marcador, realizar un triangulo, realizar un circulo (aproximado con 8 puntos), tres lineas paralelas, escritura de letra, marcar el espacio de trabajo, marcar 5 puntos equidistantes y por ultimo, retornar a home.

Para la lectura de este csv se manejo un archivo .py que modifica un poco la lectura del archivo, recibiendo un parametro llamado pointer, el cual indica la posicion en la que se debe empezar a leer el archivo de forma tal que se ejecute el comando deseado, el pointer arranca desde la primera linea y lee hasta que encuentra una fila vacia, en ese punto para de ejecutar el comando y pide la siguiente accion al usuario. El archivo encargado de esta tarea es get_points.py y el csv que contiene las trayectorias es test.csv. Aparte de leer el archivo, el programa get_points.py tambien desarrolla la cinematica inversa a cada punto para retornar una matriz de q, que es la empleada para publicar las posiciones en el robot

El codigo encargado de la publicacion de la posicion requerida es robot.py, en el se crea la clase phantomX la cual cuenta con el metodo joint_publisher(), en el se realiza toda la logica que determina la trayectoria a realizar por el brazo, asi segun el comando dado por el usuario, el llamara a la funcion get_points() en cierto pointer, que traera la matriz de Q necesaria para realizar dicha trayectoria, tambien se encarga de publicar en el topico del phantom las debidas posiciones con el sleep respectivo para poder ejecutar cada comando sin entrar en conflicto con el ciclo de python.

A continuacion se muestra una imagen esperada de las figuras a realizar






    
  ## Resultados
  en el siguiente video se encuentra la realizacion de las diversas trayectorias pedidas: https://www.youtube.com/watch?v=_RNeN0LOX_E


## Calculo de errores
Si se compara el video con la imagen donde se presenta una estimacion de las trayectorias, podemos ver varios detalles que indican un error en el trazado de las diversas figuras, detalles como el que se puede apreciar en la siguiente imagen

![image](https://user-images.githubusercontent.com/38962033/200095543-75e1c86e-ce7a-4424-94f9-528224597d28.png)

A continuacion se resaltan aquellos errores mas notorios y a los que se les hizo un analisis y seguimiento

![image](https://user-images.githubusercontent.com/38962033/200096128-bccaecd2-8797-4ba1-9afc-8e75860a6bfc.png)

al medir y caracterizar dichos errores se notan dos cosas:

- La mayoria de errores grandes se daban sobre el eje x
- El promedio de los errores daba alrededor de 1 cm

Varios factores pueden generar estos errores en los trazos, el primero y el mas notorio a la hora de realizar la letra, fue el dezplazamiento del marcador sobre el gripper generando una posicion incomoda para escribir y el deslizamiento pronunciado del marcador sobre el tablero, otro error que se puede evidenciar en el video se da en la trayectoria de alejamiento del brazo cuando acaba de trazar una linea o figura solicitada, este tipo de error se evidencia mas en las lineas y puntos. Estos errores son mas por el agarre del marcador que algo mas sistematico, a diferencia de los errores evidentes en las figuras realizadas por ejemplo, donde la trayectoria se ve incompleta o desfazada x cantidad

Se mide y calcula este ultimo error ya que brinda mayor informacion sobre el error porpio del brazo. Este da un promedio de 1 cm a lo largo de todos los x de desface.


  ## Conclusiones
El brazo sigue las trayectorias estipuladas mas sin embargo siempre hay un desface en las x con respecto a las posiciones de las distintas trayectorias. tambien se ve que a falta de un controlador propio en los motores, estos tienden a vibrar y realizar movimientos un poco bruscos, probocando que el marcador se safara o que se moviera. Otra conclusion es que mediante el uso del toolbox de matlab se pudo concretar y verificar la cinematica inversa del robot, mostrando y garantizando el correcto desarrollo del mismo por lo que las discrepancias entre el modelo y lo observado en la realidad fueron mas faciles de observar y modelar
