// Author: Akshayan Mohandas
// UOW ID: w1867142
// 6SENG005W Formal Methods
// Old asteroids arcade game
// Note: To fix the NO-CONSTANTS-FOUND error, navigate to Preferences -> Configurations -> MININT..MAXINT (32bit).

MACHINE
    Spaceship

SEES				// To access the constants and properties specified in SpaceRegion.﻿
    SpaceRegion			

SETS 
    // Outcomes reported from an attempted movement
    OUTCOME = {SUCCESSFUL, FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES, FAILED_DUE_TO_AN_ASTEROID, FAILED_FOR_SOME_OTHER_REASON};
 
    // Current status of the game
    GAME_STATUS = {WON, LOST, NOT_OVER, NOT_STARTED}

CONSTANTS
    InitialPower,                 // Initial power of the spaceship
    PowerForNormalMove,           // Power usage for a normal move
    PowerForWarpDrive,            // Power when a spaceship engages its warp-drive
    PowerLossForAsteroidCollision // Power loss when a spaceship crashes into one of the asteroids    

PROPERTIES
    InitialPower : NAT & InitialPower = 0 &
    PowerForNormalMove : NAT & PowerForNormalMove = 5 &
    PowerForWarpDrive : NAT & PowerForWarpDrive = 20 &
    PowerLossForAsteroidCollision : NAT & PowerLossForAsteroidCollision = 10

VARIABLES
    regionX,         				  // To store the current x coordinate
    regionY,         				  // To store the current y coordinate
    totalPower,     				  // To store the current spaceship's power
    missionRoute,      				  // To store the regions of space that the spaceship has travelled through
    numberOfCollisions 				  // To store the number of crashes the spaceship had with the asteroids
    
INVARIANT
    regionX : X_Axis & regionY : Y_Axis &								// regionX and regionY must belong to their respective sets X_Axis and Y_Axis coordinates of the spaceship within the space.
    regionX |-> regionY : EmptySpace &								// The tuple with regionX as its first element and regionY as its second element (regionX, regionY) should belong to the set EmptySpace.
    totalPower : NAT &        								// The total power of the spaceship is a non-negative integer.                                     
    missionRoute : seq(EmptySpace) &								// missionRoute must be a sequence of elements from the set EmptySpace.
    numberOfCollisions : NAT								// Count of collisions is a non-negative integer
    
INITIALISATION
    regionX := prj1(X_Axis, Y_Axis)(Homebase) ||								// Initializing the regionX variable with the x coordinate of the Homebase 
    regionY := prj2(X_Axis, Y_Axis)(Homebase) ||								// Initializing the regionY variable with the y coordinate of the Homebase 
    totalPower := InitialPower ||								// Assigning the value of InitialPower to the variable totalPower
    missionRoute := [Homebase] ||								// Initializing the variable missionRoute with a sequence containing Homebase
    numberOfCollisions := 0								// Initializing the variable numberOfCollisions to zero
    
OPERATIONS
    // To start or re-start the game
    NewGame(power) =
    PRE
        power: NAT1
    THEN
        totalPower := power ||
        numberOfCollisions := 0 ||
        regionX := prj1(X_Axis, Y_Axis)(Homebase) || regionY := prj2(X_Axis, Y_Axis)(Homebase) ||
        missionRoute := [Homebase] 
    END;

    // MoveUp operation to move the spaceship from one region of space to the adjacent top grid square.
    outcomeMessage <-- MoveUp =
    PRE
        outcomeMessage : OUTCOME & not((regionX |-> regionY = Starbase) or (totalPower < PowerForNormalMove))
    THEN
        IF
            totalPower >= PowerForNormalMove     													// To check if the spaceship has adequate power to make a normal move.
        THEN 
            IF
                regionY + 1 : Y_Axis                         													// To check if the movement is contained within the boundary of space.
            THEN
                IF 
                    (regionX |-> (regionY + 1) : Asteroids)  													// To check whether a spaceship has crashed into one of the asteroids.
                THEN
                    totalPower := totalPower - PowerLossForAsteroidCollision ||  
                    numberOfCollisions := numberOfCollisions + 1 ||
                    outcomeMessage := FAILED_DUE_TO_AN_ASTEROID 
                ELSE
                    totalPower := totalPower - PowerForNormalMove ||
                    regionY := regionY + 1 ||
                    missionRoute := missionRoute <- (regionX |-> regionY + 1) || 
                    outcomeMessage := SUCCESSFUL
                END
            ELSE
                outcomeMessage := FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES
            END
        ELSE
            outcomeMessage := FAILED_FOR_SOME_OTHER_REASON
        END
    END;
    
    // MoveDown operation to move the spaceship from one region of space to the adjacent bottom grid square.
    outcomeMessage <-- MoveDown =
    PRE
        outcomeMessage : OUTCOME & not((regionX |-> regionY = Starbase) or (totalPower < PowerForNormalMove))
    THEN
        IF
            totalPower >= PowerForNormalMove                              													// To check if the spaceship has adequate power to make a normal move.
        THEN
            IF
                regionY - 1 : Y_Axis                                  													// To check if the movement is contained within the boundary of space.
            THEN
                IF 
                    (regionX |-> (regionY - 1) : Asteroids)   													// To check whether a spaceship has crashed into one of the asteroids.
                THEN
                    totalPower := totalPower - PowerLossForAsteroidCollision ||
                    numberOfCollisions := numberOfCollisions + 1 ||
                    outcomeMessage := FAILED_DUE_TO_AN_ASTEROID
                ELSE
                    totalPower := totalPower - PowerForNormalMove ||
                    regionY := regionY - 1 ||
                    missionRoute := missionRoute <- (regionX |-> regionY - 1) ||
                    outcomeMessage := SUCCESSFUL
                END
            ELSE
                outcomeMessage := FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES
            END
        ELSE
            outcomeMessage := FAILED_FOR_SOME_OTHER_REASON
        END   
    END;

    // MoveLeft operation to move the spaceship from one region of space to the adjacent left grid square.
    outcomeMessage <-- MoveLeft =
    PRE
        outcomeMessage : OUTCOME & not((regionX |-> regionY = Starbase) or (totalPower < PowerForNormalMove))
    THEN
        IF
            totalPower >= PowerForNormalMove                             													// To check if the spaceship has adequate power to make a normal move.
        THEN
            IF
                regionX - 1 : X_Axis                                       													// To check if the movement is contained within the boundary of space.
            THEN
                IF 
                    ((regionX - 1) |-> regionY : Asteroids)                                   										// To check whether a spaceship has crashed into one of the asteroids.
                THEN
                    totalPower := totalPower - PowerLossForAsteroidCollision ||
                    numberOfCollisions := numberOfCollisions + 1 ||
                    outcomeMessage := FAILED_DUE_TO_AN_ASTEROID
                ELSE
                    totalPower := totalPower - PowerForNormalMove ||
                    regionX := regionX - 1 ||
                    missionRoute := missionRoute <- (regionX - 1 |-> regionY) ||
                    outcomeMessage := SUCCESSFUL
                END
            ELSE
                outcomeMessage := FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES
            END
        ELSE
            outcomeMessage := FAILED_FOR_SOME_OTHER_REASON
        END   
    END;

    // MoveRight operation to move the spaceship from one region of space to the adjacent right grid square.
    outcomeMessage <-- MoveRight =
    PRE
        outcomeMessage : OUTCOME & not((regionX |-> regionY = Starbase) or (totalPower < PowerForNormalMove))
    THEN
        IF
            totalPower >= PowerForNormalMove                                             													// To check if the spaceship has adequate power to make a normal move.
        THEN
            IF
                regionX + 1 : X_Axis                                     													// To check if the movement is contained within the boundary of space.
            THEN
                IF 
                    ((regionX + 1) |-> regionY : Asteroids)                                  											// To check whether a spaceship has crashed into one of the asteroids.
                THEN
                    totalPower := totalPower - PowerLossForAsteroidCollision ||
                    numberOfCollisions := numberOfCollisions + 1 ||
                    outcomeMessage := FAILED_DUE_TO_AN_ASTEROID
                ELSE
                    totalPower := totalPower - PowerForNormalMove ||
                    regionX := regionX + 1 ||
                    missionRoute := missionRoute <- (regionX + 1 |-> regionY) ||
                    outcomeMessage := SUCCESSFUL
                END
            ELSE
                outcomeMessage := FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES
            END
        ELSE
            outcomeMessage := FAILED_FOR_SOME_OTHER_REASON
        END   
    END;

    // WarpDrive operation to move the spaceship from one region of space to any region of space.
    outcomeMessage <-- WarpDrive(newpositionX, newpositionY) =
    PRE
        outcomeMessage : OUTCOME &
        newpositionX : NAT1 & newpositionX : X_Axis &
	newpositionY : NAT1 & newpositionY : Y_Axis &
        not((regionX |-> regionY = Starbase) or (totalPower < PowerForNormalMove))
    THEN
        IF
            totalPower >= PowerForWarpDrive                                     													// To check if the spaceship has adequate power to make a warp-drive.
        THEN
            IF
               newpositionX : X_Axis & newpositionY : Y_Axis                      													// To check if the movement is contained within the boundary of space.
            THEN
                IF
                    (newpositionX |-> newpositionY : Asteroids)  													// To check whether a spaceship has crashed into one of the asteroids.
                THEN
		    totalPower := totalPower - PowerForWarpDrive ||
                    outcomeMessage := FAILED_DUE_TO_AN_ASTEROID 
                ELSE
                    totalPower := totalPower - PowerForWarpDrive ||
                    regionX := newpositionX || regionY := newpositionY ||
                    missionRoute := missionRoute <- (newpositionX |-> newpositionY) ||
                    outcomeMessage := SUCCESSFUL
                END
            ELSE
                outcomeMessage := FAILED_DUE_TO_SPACE_BOUNDARY_ISSUES
            END
        ELSE
            outcomeMessage := FAILED_FOR_SOME_OTHER_REASON
        END        
    END;
    
    // MissionStatus operation to report the current status of the spaceship
    gameStatus, currentLocation, currentPower, asteroidCollisions <-- MissionStatus =
    PRE
	gameStatus : GAME_STATUS
    THEN		
    	IF
        	   missionRoute = [Homebase] & totalPower = 0												// To check whether the game has started
        THEN
            gameStatus := NOT_STARTED
        ELSE
            IF
            		(regionX |-> regionY = Starbase)											// To check whether the spaceship has gotten to the starbase
            THEN
                gameStatus := WON
            ELSE
                IF 
		    (totalPower < PowerForNormalMove)											// To check if the spaceship has adequate power to make a move
		THEN
		    gameStatus := LOST
		ELSE
	            gameStatus := NOT_OVER
		END
            END
        END ||
	currentLocation := regionX |-> regionY ||												// To find out the current location
	currentPower := totalPower ||												// To find out the current power reserves
	asteroidCollisions := numberOfCollisions												// To find out how many asteroid collisions it has had
    END;
    
    //  RegionsVisited operation to report the regions of space that the spaceship has travelled through
    route <-- RegionsVisited =
    BEGIN
        route := missionRoute
    END
END
