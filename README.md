# Robot_ObstacleAvoiding
Repository for my autonomous robot

##Purpose
The goal of this project was to be able to design a robot capable of driving through an obstacle course. 

##Folders
The ahdlParts folder contains all the basic digital logic components such as comparators that I used.
The vhdlFiles folder contains the main controllers for the robot. The controllers tell the robot what to do depending on what part of the obstacle course it is located at. 
The third file is the archived Quartus II project where all the files required to make the project run are located at. 

##Race Track
The objective of the race track it to test all the features of the robot. For the first obstacle, the robot has to go into a friend's house to pick him up. It has to stop and honk once it detects that there is no light, then it was to leave the house and seach for the left wall. It will follow the wall proving the wall following capabilities. It will do this until the t-tunnel where it was to switch to righ-wall-following so that it can make it out. Once out of the tunnel, it will drive across to the right wall and right-wall-follow until it stops at the stop sign. It will continue driving once the bus at the stop sign leaves. The robot will continue driving until it gets to the church at the end and play a song. 

##Components
The robot is mainly controlled by the eight sensors located at the front and the back. It checks this sensors to know what is around it so that it can make decisions. These are located at a PCB connected to the brain of the robot, a CPLD. The PCB contains a CDS cell which allows the CPDL to know when the there is no light along with a 7 segment display and 3 LEDs for debugging purposes. At the back of the robot, there is a PCB is a hall effect sensor that allows the robot to know when there is a magnet nearby along with 2 of the 8 sensors. The power supply is a recycled battery from a used laptop which powers two servo motors for the two wooden wheels. The battery can be recharged through a port located to the right of the switch. 

##Logic
The Logic for each part will be explained in a Readme file located at each folder. 
