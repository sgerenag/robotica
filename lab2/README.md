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
Una vez tenemos la tecla presionada, pasamos a crear la funcion que hace que la tortuga se mueva adelante, atras o rote en los distintos sentidos podemos usar el topico _/turtle1/cmd_vel_ para esto primero creamos un publisher para ese topico, despues de esto iniciamos el nodo y publicamos la informacion correspondiente al topico, la definicion de que tanto se mueve segun cada uno de los comandos (la propiedad _angular_ es para el giro en tanto la propiedad _linear_ es para avanzar )
~~~
def moveturtle(line_vel,angle_vel):
    rospy.init_node('myTeleopKey',anonymous=True)
    pub = rospy.Publisher('/turtle1/cmd_vel',Twist, queue_size=10)
    vel = Twist()
    vel.linear.x=line_vel
    vel.angular.z=angle_vel
    pub.publish(vel)
~~~
Con estas funciones ya se puede hacer el movimiento de las teclas _a_,_s_,_d_y_w_ mas sin embargo, aun falta los comandos para la letra _r_ y _space_ los cuales retornan a la posicion central en la orientacion default y gira 180° sobre si mismo respectivamente, para hacer esto podemos usar los servicios _/turtle1/teleport_absolute_ y _/turtle1/teleport_relative_. Para poder usar estos servicios lo primero que debemos hacer es primero, esperamos por el servicio (con _absolute_ vamos a realizar el desplazamiento a la mitad del mapa con orientacion inicial en cambio con _relative_ vamos a realizar el giro de 180 grados) para posteriormente pasar los parametros requeridos por este servicio para hacer la orden que queremos, usamos relative para el giro de 180 ya que este depende de la orientacion actual de la tortuga, en cambio el absolute no tiene  en cuenta ese factor.
~~~
def Absolute(x, y,ang):
    rospy.wait_for_service('/turtle1/teleport_absolute')
    try:
        absolute=rospy.ServiceProxy('/turtle1/teleport_absolute',TeleportAbsolute)
        res=absolute(x,y,ang)
        print('teletransportado a x: ',x,'y en y: ',y, 'con angulo: ',ang)
        return res
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)
def Relative(x,ang):
    rospy.wait_for_service('/turtle1/teleport_relative')
    try:
        Relative=rospy.ServiceProxy('/turtle1/teleport_relative',TeleportRelative)
        res=Relative(x,ang)
        print('teletransportado a x: ',x, 'con angulo: ',ang)
        return res
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)

~~~
Por ultimo creamos la funcion main la cual indica el ciclo de pedir un valor de tecla y segun la respuesta, realizar la accion correspondiente, es aca donde damos los valores a pasar, para los giros, segun el sentido, se pasa el valor de velocidad angular en radianes de 0.1 o -0.1. Para el movimiento lineal de avanzar o retroceder se da una velocidad de 1 o -1. Por ultimo, el movimiento de volver a la posicion central y de girar pi radianes se hace llamando a las respectivas funciones con parametros segun lo establecido.
~~~
if __name__ == '__main__':
    
    while True:
        d= str(getkey())[-2]
        print('holi, se lee tecla ',d)
        if d=='a':
            moveturtle(0,0.1)
        elif d=='s':
            moveturtle(-1,0)
        elif d=='d':
            moveturtle(0,-0.1)
        elif d=='w':
            
            moveturtle(1,0)
            
        elif d=='r':
            Absolute(5.5,5.5,pi/2)
        elif d==' ':
            Relative(0,pi)
~~~

### Scripts de Matlab
Respecto a los scripts .m solicitados, despues de correr el script suminisitrado (el cual inicia el ROS master y crea el nodo global con rosinit), se puede correr los otros 2 scripts. El tipo del mensaje es 'turtlesim/Pose', como se indica en la documentacion de este topico.

Inicialmente se crea el script que se subscribe al topico pose de turtle1. Este lo hace por medio de crear un objeto que representa un subscriptor en la red. Este codigo se corre depues del script inicial, pues ese contiene el rosinit.

subs.m:
~~~
sub = rossubscriber('/turtle1/pose','turtlesim/Pose')
pause(1)
sub.LatestMessage
~~~

El siguiente script crea un cliente al servicio "/turtle1/teleport_absolute", despues crea una funcion de solicitud se servicio al servidor. Esta tiene el tipo y formato que utiliza el servidor. Poseterior a esto, sele asignan los argumentos de coordenadas absolutas y angulo. Finalmente se llama el servicio con call(*).

servPos.m:
~~~
client = rossvcclient("/turtle1/teleport_absolute")
recfunc = rosmessage(client)
recfunc.X= 2
recfunc.Y = 2
recfunc.Theta = pi
pos = call(client,recfunc,"Timeout",3)
~~~

El comando para finalizar el nodo maestro en Matlab es rosshutdown. 

## Resultados

A continuacion se aprecia un video del funcionamiento de la tortuga con cada uno de los comandos dados
https://youtu.be/pGD2dH0vhOM

### Scripts de Matlab
A continuacion se muestra la salida de los scripts solicitados y el efecto sobre la tortuga:

Salida de subs.m:

![image](https://user-images.githubusercontent.com/37639887/190688543-7e184db6-0d15-436d-8ade-08d87b5dff3f.png)

Salida de servPos.m:

![image](https://user-images.githubusercontent.com/37639887/190688719-da74fe33-20b0-4229-b2e3-d439e2c6997c.png)
![image](https://user-images.githubusercontent.com/37639887/190688840-72ba8c31-cf70-4c54-9f67-ac5780cf1ad8.png)


## Analisis
El uso de topics para comunicar informacion entre nodos es una estructura escencial y la logica detras de la programacion modular de ros, esto se puede evidenciar en este laboratorio, donde podemos hacer funcion de los topicos para comunicar ciertas acciones a otro nodo, la capacidad de integrarse a python es una facilidad a la hora de realizar posteriormente programas mas complicados para el control del robot, ademas se aprecia tambien que un nodo no solamente puede publicar a ciertos topicos sino usar servicios que ofrece un paquete, los conceptos de nodo, topico y servicios fueron aplicados en este laboratorio.

### Analisis scripts de Matlab
Se observa que mediante el toolbox ROS de Matlab se puede crear un nodo global de matlab que permite hacer  publicacion, subsripcion y solicitud de servicios desde Matlab.
Respecto a la publicacion, se observa que al correr scripLab1.m se mueve la tortuga a la derecha. Esto sucede porque se publica al topico "/turtle1/cmd_vel" la velocidad que debe tener la tortuga en la direccion en la que esta esta orientada, la cual indica moverse hacia el frente. 

La salida de la subscripcion permite oservar las caracteristicas que corresponden al topico suscrito y al obtener el ultimo mensaje, este viene con la forma y tipo de mensaje esperados, en le cual se transmite la posicion actual de la tortuga (X, Y) y su orientacion en radianes.  

Finalmente, en cuanto a la solicitud del servicio, se observa que al ejecutar el codigo, la tortuga cambia su posicion y orientacion. Esto se puede verificar en la ventana de turtlesim y tambien en la nueva salida del topico de pose, en donde se observan los valores de X, Y, Theta actualizados.

## Conclusiones
A manera de conclusion, se destaca la gran versatilidad que ofrece ROS a la hora de realizar programas mediante paquetes, su capacidad de integrar varios programas como python o matlab reflejan ampliamente la modularidad que posee este mismo. Con este laboratorio se afianso varios conceptos basicos a la hora de trabajar con ROS como lo es nodo, topico, servicios, paquetes y publicar en un topico. Tambien se esclarecio la relacion entre estos conceptos que es muy importante a la hora de trabajar con ROS.

