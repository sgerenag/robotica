
rosinit; %Conexión con n
velPub = rospublisher("/turtle1/cmd_vel","geometry_msgs/Twist"); %Creación publicadorodo maestro
velMsg = rosmessage(velPub); %Creación de mensaje
velMsg.Linear.X = 1; %Valor del mensaje
send(velPub,velMsg); %Envio
pause(1)