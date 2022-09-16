
client = rossvcclient("/turtle1/teleport_absolute")
recfunc = rosmessage(client)
recfunc.X= 2
recfunc.Y = 2
recfunc.Theta = pi
pos = call(client,recfunc,"Timeout",3)

%Verificar que la pose ha cambiado
sub.LatestMessage