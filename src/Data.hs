module Data where 

    import Graphics.Gloss.Interface.Pure.Game

    width, height, offset :: Int
    width = 600
    height = 400
    offset = 100

    padWidth, padHeight, maxPadVel, ballRadius :: Float
    padWidth = 15
    padHeight = 80
    maxPadVel = 700
    ballRadius = 8

    padColor, ballColor :: Color
    padColor = light blue
    ballColor = dark red   
    
    data Object = Obj 
        { x :: Float, y :: Float
        , vx :: Float, vy :: Float 
        } deriving Show

    data PongGame = Game
        { ball :: Object
        , p1 :: Object
        , p2 :: Object
        } deriving Show 
        
    type Radius = Float 
    type Position = (Float, Float)
    
    initialState :: PongGame
    initialState = Game
        { ball = (Obj 0 0 50 0)
        , p1 = (Obj (-260) 0 0 0)
        , p2 = (Obj 260 0 0 0)
        }
    
