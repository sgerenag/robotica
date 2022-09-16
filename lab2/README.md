# lab 2 robotica. Robotica en desarrollo introduccion a ROS
### Daniel Melo Avila
### Sergio Andres Gerena Gomez
## Metodologia
El primer paso es crear un archivo .py donde vamos a crear todo nuestro codigo, este archivo lo llamamos _myTeleopKey.py_ en esta creamos las funciones que dan solucion al problema, este archivo se crea dentro del packete de ros que descargamos del repositorio https://github.com/felipeg17/hello_turtle . El paquete se llama _HelloTurtle_ como se evidencia en la siguiente imagen


![Captura de pantalla de 2022-09-15 20-20-43](https://user-images.githubusercontent.com/38962033/190536128-732f1910-b9cc-423e-af14-8d433c045f87.png)

Despues de creado el archivo, pasamos a la creacion del codigo, el primer paso es importar las librerias necesarias para usar ros en python, ademas de las necesarias para usar sus servicios y, poder leer la tecla presionada, a continuacion la seccion del codigo que realiza dicha importacion

```
#!/usr/bin/env python 
#Script de python del nodo tipo Teleop_key para mover turtle
import rospy
from geometry_msgs.msg import Twist
from turtlesim.srv import TeleportAbsolute, TeleportRelative 
import termios, sys, os
from numpy import pi
import termios, sys, os
TERMIOS = termios
```

Ya con esto podemos iniciar a realizar codigo, el primero es ña funcion para retornar la tecla presionada, esto dado que el comando que se le dara a la tortuga sera mediante el teclado del computador, esta funcion no tiene problema con linux y retorna la tecla que se presiona en forma de string (hay que hacer una pequeña seleccion ya que no es solamente el string de la tecla lo que se devuelve pero esto se tendra en cuenta mas adelante en el codigo) este codigo llo puedes encontrar en el siguiente enlace http://python4fun.blogspot.com/2008/06/get-key-press-in-python.html
~~~
def getkey():
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    new = termios.tcgetattr(fd)
    new[3] = new[3] & ~TERMIOS.ICANON & ~TERMIOS.ECHO
    new[6][TERMIOS.VMIN] = 1
    new[6][TERMIOS.VTIME] = 0
    termios.tcsetattr(fd, TERMIOS.TCSANOW, new)
    c = None
    
    try:
        c = os.read(fd, 1)
        
    finally:
        termios.tcsetattr(fd, TERMIOS.TCSAFLUSH, old)
    return c
~~~
Una vez tenemos la tecla presionada, pasamos a crear la funcion que hace que la tortuga se mueva adelante, atras o rote en los distintos sentidos podemos usar el topico _/turtle1/cmd_vel_

## Resultados
## Analisis
## Conclusiones

