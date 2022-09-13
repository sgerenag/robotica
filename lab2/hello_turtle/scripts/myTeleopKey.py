#!/usr/bin/env python 
#Script de python del nodo tipo Teleop_key para mover turtle
import rospy
from geometry_msgs.msg import Twist
from turtlesim.srv import TeleportAbsolute, TeleportRelative 
import termios, sys, os
from numpy import pi
import termios, sys, os
TERMIOS = termios

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
def moveturtle(line_vel,angle_vel):
    rospy.init_node('myTeleopKey',anonymous=True)
    pub = rospy.Publisher('/turtle1/cmd_vel',Twist, queue_size=10)
    vel = Twist()
    vel.linear.x=line_vel
    vel.angular.z=angle_vel
    pub.publish(vel)

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



    




