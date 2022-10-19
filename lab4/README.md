# lab 4 robotica. 
### Daniel Melo Avila
### Sergio Andres Gerena Gomez


## Metodologia
### Analisis
El primer paso es dimensionar el robot y con base en esto, encontrar el esquema DH que le corresponde, con los parametros exigidos. Esto es indispensable para poder hacer un modelo del robot y poder manejar el mismo en las distintas poses solicitadas

A continuacion un grafico que muestra las diversas dimensiones del brazo
![image](https://user-images.githubusercontent.com/38962033/194959613-80de7b63-cdaa-483f-9fd6-eae699813f2b.png)

Con base en estas mediciones, se plantea el siguiente esquema y con ello, la siguiente tabla con los parametros DH del robot.
![image](https://user-images.githubusercontent.com/38962033/196545051-07c66a1c-a128-4f2a-a164-8910873f4d31.png)

![image](https://user-images.githubusercontent.com/38962033/195693109-8b2ef55e-73b3-4738-9ed1-b5027aa37d8e.png)

### ROS
Para el desarrollo del codigo, se adapto el script jointSrv.py que fue dado en la guia, en este se realiza la siguiente modificacion

<pre><code>
if __name__ == '__main__':
    try:
        # Goal_Position (0,1023)
        # Torque_Limit (0,1023)
        jointCommand('', 1, 'Torque_Limit', 600, 0)
        jointCommand('', 2, 'Torque_Limit', 500, 0)
        jointCommand('', 3, 'Torque_Limit', 400, 0)
        jointCommand('', 4, 'Torque_Limit', 400, 0)
        jointCommand('', 1, 'Goal_Position', 512, 0.5)
        time.sleep(1)
        jointCommand('', 2, 'Goal_Position', 512, 0.5)
        time.sleep(1)
        jointCommand('', 3, 'Goal_Position', 512, 0.5)
        time.sleep(1)
        jointCommand('', 4, 'Goal_Position', 512, 0.5)
        time.sleep(1)
        jointCommand('', 1, 'Goal_Position', 384, 0.5)
        time.sleep(1)
        jointCommand('', 2, 'Goal_Position', 384, 0.5)
        time.sleep(1)
        jointCommand('', 3, 'Goal_Position', 384, 0.5)
        time.sleep(1)
        jointCommand('', 4, 'Goal_Position', 384, 0.5)
        
    except rospy.ROSInterruptException:
        pass

</code></pre>

En este primero, se setea los torques maximos de cada articulacion, posteriormente se hace el movimiento de cada articulacion en el orden establecido por la guia, de forma tal que primero va a una posicion totalmente vertical (512) con una pausa entre cada movimiento para poder apreciar el mismo, una vez termina el movimiento de home, comienza a moverse a la posicion objetivo articulacion por articulacion.

### Toolbox
El siguiente codigo muestra la configuracion del robot segun el marco y los parametros encontrados en el analisis
<pre><code>
L(1) = Link('revolute','alpha',pi/2,'a',0,'d',40,'offset',0,'qlim',[-3*pi/4 3*pi/4]);
L(2) = Link('revolute','alpha',0,'a',-110,'d',0,'offset',-pi/2,'qlim',[-3*pi/4 3*pi/4]);
L(3) = Link('revolute','alpha',0,'a',110,'d',0,'offset',pi/2,'qlim',[-3*pi/4 3*pi/4]);
L(4) = Link('revolute','alpha',pi/2,'a',90,'d',0,'offset',0,'qlim',[-3*pi/4 3*pi/4]);
Robot = SerialLink(L,'name','Px')
Robot.tool=[0 0 1 0;
            0 1 0 0;
            -1 0 0 0;
            0 0 0 1];
q1=[0 0 0 0];
Hbt1=L(1).A(q1(1))*L(2).A(q1(2))*L(3).A(q1(3))*L(4).A(q1(4))
Robot.plot(q1,'notiles','noname');
</code></pre>
A continuacion se muestra la tabla con los parametros DH, ademas de la MTH de la base a la herramienta en esa posicion.

![imagen](https://user-images.githubusercontent.com/38962033/194994645-4c19d6fa-4c4a-4a92-87bb-f18ea1eee0d8.png)

![imagen](https://user-images.githubusercontent.com/38962033/194994849-59b50bf1-ea93-4a23-b163-7c71782dfdd3.png)

Ademas de poder ver el robot en la posicion donde todos los valores articulares son 0

![imagen](https://user-images.githubusercontent.com/38962033/194995140-b2d1f341-a270-4ab3-b68e-bfb288cd45e4.png)


Para Las posiciones HOME y GOAL delimitadas en el insciso aterior tenemos el siguiente codigo, el cual nos da la matris de transformacion homogenea de la base a la herramienta y la pose del robot
<pre><code>
HOME=[0 0 pi/2 0];
Hbt2=L(1).A(HOME(1))*L(2).A(HOME(2))*L(3).A(HOME(3))*L(4).A(HOME(4))
Robot.plot(HOME,'notiles','noname');

GOAL=[3*pi/8 3*pi/8 7*pi/8 3*pi/8];
Hbt3=L(1).A(GOAL(1))*L(2).A(GOAL(2))*L(3).A(GOAL(3))*L(4).A(GOAL(4))
Robot.plot(GOAL,'notiles','noname');
</code></pre>
A continuacion se observa la salida para la pose HOME

![imagen](https://user-images.githubusercontent.com/38962033/194995882-1bd76ee8-02f3-432c-aa91-c939ba518bb6.png)

![imagen](https://user-images.githubusercontent.com/38962033/194995967-a43ef7f2-413e-49d6-b8d9-81b990739385.png)

Y estas muestran la salida para la pose GOAL

![imagen](https://user-images.githubusercontent.com/38962033/194996160-e082003b-e8cc-4d19-9670-8884d8e87f35.png)

![imagen](https://user-images.githubusercontent.com/38962033/194996345-d0ed1170-4b51-4715-aa94-b4b3851d7ef6.png)

### Publicacion en los topicos de controlador de junta
Para esta parte primero se modifico el codigo propuesto en el laboratorio para poder realizar la instruccion requerida en el ejercicio, en este codigo se modifica el main de tal forma que primero, se setea el limite de torque para cada articulacion, luego se lleva a la primera posicion que es home, usando la funcion que se ve en el codigo, en el tambien se pone el tiempo de descanso entre cada comando, esto con el fin de que se pueda observar en el video el movimiento de cada una de las articulaciones, una vez se logra la primera posicion (brazo totalmente erguido) se pasa a la segunda posicion articulacion por articulacion en el orden indicado en la guia

![imagen](https://user-images.githubusercontent.com/38962033/196767425-0819dce7-caa6-425e-9dc1-126a5cb35442.png)

### Suscripcion a topicos
Para esta seccion se empleo el codigo en el script "JointSub.py ", en este se suscribe al topico "JointState" que nos permite entre varias cosas, conocer la posicion de cada articulacion del robot en radianes, asi obtenemos la siguiente salida

![imagen](https://user-images.githubusercontent.com/38962033/196767867-e20eac01-a60f-431c-8d84-315024108533.png)
![imagen](https://user-images.githubusercontent.com/38962033/196768028-7dca6b56-8876-4ff5-810e-e6ca08ce4c91.png)

sta se comprueba viendo la posicion del robot mientras se ejecuta este codigo, la cual es la observada a continuacion

### codigo para enviar cierta pose al robot y su paralelo en matlab

En esta seccion, se crea un codigo en python el cual permite, segun un vector con los valores articulares indicado, se cambia la posicion del robot, se plantea un codigo secuencial ciclico donde se alterna entre las 5 posiciones pedidas en el orden estipulado en la guia, dicho codigo se muestra a continuacion



Esta verificacion de las diversas poses se hace teniendo en cuenta el home estipulado anteriormente, de esta forma podemos usar el toolbox como verificacion de las mismas, a continuacion se muestra la pose solicitada, la efectuada por el robot y su verificacion empleando el toolbox.
<b>q1=[0 0 0 0 0] </b>
    
![imagen](https://user-images.githubusercontent.com/38962033/196780408-f2d436e4-47e7-4436-9068-49e611300c6d.png)
   
<b>q2=[-20 20 -20 20 0] </b>
    
 ![imagen](https://user-images.githubusercontent.com/38962033/196780532-0fef92d7-bee4-4233-8644-9bcbb3f1afa8.png)

    
<b>q3=[30 -30 30 -30 0] </b>
   
![imagen](https://user-images.githubusercontent.com/38962033/196781953-33a0044b-6d58-4fef-9a42-466ca3da6e10.png)


    
<b>q4=[90 15 -55 17 0] </b>
    
![imagen](https://user-images.githubusercontent.com/38962033/196782012-04712318-b517-4f48-bc26-e397101a7002.png)
 

    
<b>q5=[90 45 -55 45 10] </b>

   ![imagen](https://user-images.githubusercontent.com/38962033/196780847-038f7c60-0aad-481b-85ad-0b8e7998936e.png)

    
  ## Resultados
  En el siguiente video se observa el movimiento secuencial de la publicacion en los topicos de controlador de junta: https://youtu.be/afS6nOVe7oA



  ## Conclusiones
