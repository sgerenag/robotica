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

´´´
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

´´´

En este primero, se setea los torques maximos de cada articulacion, posteriormente se hace el movimiento de cada articulacion en el orden establecido por la guia, de forma tal que primero va a una posicion totalmente vertical (512) con una pausa entre cada movimiento para poder apreciar el mismo, una vez termina el movimiento de home, comienza a moverse a la posicion objetivo articulacion por articulacion.

### Toolbox

  ## Resultados

  ## Análisis de resultados


  ## Conclusiones
