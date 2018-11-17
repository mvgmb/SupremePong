module Data where 

    import Control.Concurrent
    import Control.Concurrent.MVar
    import Graphics.Gloss.Interface.Pure.Game

    width, height, upOffset, leftOffset :: Int
    width = 600
    height = 400
    upOffset = 150
    leftOffset = 380

    padWidth, padHeight, maxPadVel, padInfluence, ballRadius, wallOffset :: Float
    padWidth = 15
    padHeight = 80
    maxPadVel = 700
    padInfluence = 0.10
    ballRadius = 8
    wallOffset = 200

    padColor, ballColor, wallColor :: Color
    padColor = light blue
    ballColor = dark red   
    wallColor = greyN 0.5
    
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
    type Control = MVar Integer

    initialState :: PongGame
    initialState = Game 
        { ball = (Obj 0 0 200 0)
        , p1 = (Obj (-260) 0 0 0)
        , p2 = (Obj 260 0 0 0)
        }
