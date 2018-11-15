module Data where 

    import Graphics.Gloss.Interface.Pure.Game

    width, height, offset :: Int
    width = 600
    height = 400
    offset = 100

    padWidth, padHeight, ballRadius :: Float
    padWidth = 15
    padHeight = 80
    ballRadius = 8

    padColor, ballColor :: Color
    padColor = light blue
    ballColor = dark red   
    
    data PongGame = Game
        { ballLoc :: (Float, Float)  
        , ballVel :: (Float, Float)  
        , p1Loc :: (Float, Float)
        , p1Vel :: (Float, Float)          
        , p2Loc :: (Float, Float) 
        , p2Vel :: (Float, Float)
        , padVel :: (Float, Float)
        } deriving Show 
        
    type Radius = Float 
    type Position = (Float, Float)
    
    initialState :: PongGame
    initialState = Game
        { ballLoc = (0, 0)
        , ballVel = (50, 0)
        , p1Loc = (-260, 0)
        , p1Vel = (0, 0)
        , p2Loc = (260, 0)
        , p2Vel = (0, 0)
        , padVel = (0, 350)
        }
    
