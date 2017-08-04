# GameHNA3---iOS
Accelerometer/Touch Based


How to Play/ Rules of the Game-
Player is in the form of sphere which starts from the bottom. 
Player movement can be controlled using accelerometer as well as by tapping the screen to make the player jump.
Player goal is to reach Home. Along the path to the destination there are enemies as well as stars. Stars will give Player some score, score meter is at the top right corner and if player touches the enemies while going home it will end the game.


Methods Used
Game Technology – Sprite Kit
CoreMotion framework which holds accelerometer, gyroscope that is already built into the iPhone from where we can grab the data and can be used to change the scene according to the requirements.
startMagnetometerUpdates()	
accelerometerUpdateInterval
startAccelerometerUpdates(to: OperationQueue.main) 
