{-
 In this file i'll model fighting robots

Each robot will have some basic properties:
A name
An attack strength
A number of hit points -}

{-
This is the constructor of the robot, a tuple is used to model the three
attributes that i need for the robots.
All objects can be viewed as a collection of attributes that you send messages.
Can be possible that the akka actor system is influenced by this?
-}
robot (name,attack,hp) = (\message -> message (name,attack,hp))

-- Creating an istance of the a robot
killerRobot = robot ("killer",100,1000)

-- I'll create accessors for all the differet filed using pattern matching
getName robot = robot (\(name,_,_) -> name)
getAttack robot = robot (\(_,attack,_) -> attack)
getHp robot = robot hp

-- would be even better to use other function in the gett
hp (_,_,hp) = hp

-- Now i need to define setter for changing the value fo the robot
setName aRobot newName = aRobot (\(name,a,h) -> robot (newName,a,h))
setAttack aRobot newAttack = aRobot (\(n,a,h) -> robot (n,newAttack,h))
setHp aRobot newHP = aRobot (\(n,a,h) -> robot (n,a,newHP))

-- would be good to have a printer function for printing my robots
printRobot aRobot =  aRobot (\(n,a,h) -> n ++
                                        " attack:" ++ (show a) ++
                                        " hp:"++ (show h))
