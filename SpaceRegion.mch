// Author: Akshayan Mohandas
// UOW ID: w1867142
// 6SENG005W Formal Methods
// Old asteroids arcade game

MACHINE
    SpaceRegion

CONSTANTS
    X_Axis,			// Set of values for the x-axis in the space region.
    Y_Axis,			// Set of values for the y-axis in the space region.
    Space,			// Cartesian product of X_Axis and Y_Axis defining the entire space region.
    Asteroids,			// Subset of the space region where asteroids are located.
    EmptySpace,			// Set of space excluding the asteroids.
    Homebase,			// Coordinates of the homebase within the empty space
    Starbase			// Coordinates of the starbase within the empty space.
    
PROPERTIES
    // Dimensions of the space region in terms of its width and height.
    X_Axis <: NATURAL1 & X_Axis = 1..12 &							// X-axis is a subset of the natural numbers and is within the range 1 to 12.
    Y_Axis <: NATURAL1 & Y_Axis = 1..7 &							// Y-axis is a subset of the natural numbers and is within the range 1 to 7.
     
    // Describes how the space region is connected to and interacts with its x and y axes.
    Space : X_Axis <-> Y_Axis &							// Bijective relationship between X_Axis and Y_Axis in the space region.
    Space = X_Axis * Y_Axis &							// Cartesian product of X_Axis and Y_Axis representing the entire space region.

    // Subset of asteroids of SpaceRegion
    Asteroids <: Space &							// Set of asteroids is a subset of the entire space region.
    Asteroids = {(3 |-> 2), (3 |-> 5), (5 |-> 4), (6 |-> 7), (7 |-> 1), (7 |-> 5), (7 |-> 7), (8 |-> 3), (10 |-> 6), (11 |-> 2), (12 |-> 5)} &

    // Empty space that spaceship can move without asteroid collision
    EmptySpace = Space - Asteroids &							// EmptySpace as the set of space excluding the asteroids.
    EmptySpace /\ Asteroids = {} & 							// Intersection of empty space and asteroids is an empty set.
    EmptySpace \/ Asteroids = Space &							// Union of empty space and asteroids covers the entire space region.
 
    // Relationship with empty space and their definitions 
    Homebase : EmptySpace & Homebase = (1 |-> 1) &						// Homebase is located within the empty space at coordinates (1, 1).
    Starbase : EmptySpace & Starbase = (6 |-> 4)							// Starbase is located within the empty space at coordinates (6, 4).

END