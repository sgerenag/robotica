# lab 4 robotica. 
### Daniel Melo Avila
### Sergio Andres Gerena Gomez


## Metodologia
### Analisis
El primer paso es dimensionar el robot y con base en esto, encontrar el esquema DH que le corresponde, con los parametros exigidos. Esto es indispensable para poder hacer un modelo del robot y poder manejar el mismo en las distintas poses solicitadas

A continuacion un grafico que muestra las diversas dimensiones del brazo
![image](https://user-images.githubusercontent.com/38962033/194959613-80de7b63-cdaa-483f-9fd6-eae699813f2b.png)

Con base en estas mediciones, se plantea el siguiente esquema y con ello, la siguiente tabla con los parametros DH del robot.
![image](https://user-images.githubusercontent.com/38962033/194965109-2685624b-a61a-4f79-a8bc-3177f622ec73.png)
![image](https://user-images.githubusercontent.com/38962033/194966556-a4514d3e-d996-43a9-9c88-abbd8918cd2e.png)
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

### Conexion con Matlab
  ## Resultados

  ## Análisis de resultados


  ## Conclusiones
