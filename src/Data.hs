module Data where 

    import Control.Concurrent.MVar
    import Graphics.Gloss.Interface.Pure.Game

    width, height, upOffset, leftOffset :: Int
    width = 600
    height = 400
    upOffset = 150
    leftOffset = 380

    padWidth, maxPadVel, padInfluence, ballRadius, ballBaseSpeed_one, ballBaseSpeed_two, wallOffset :: Float
    padWidth = 15
    maxPadVel = 700
    padInfluence = 0.05
    ballRadius = 8
    ballBaseSpeed_one = 300
    ballBaseSpeed_two = (-200)
    wallOffset = 200
    
    maxScore :: Integer
    maxScore = 6

    padColor, ballColor, wallColor :: Color
    padColor = light blue
    ballColor = dark red   
    wallColor = greyN 0.5
    
    data Object = Obj 
        { x :: Float, y :: Float
        , vx :: Float, vy :: Float 
        } deriving Show

    data PongGame = Game
        { ball_one :: Object
        , ball_two :: Object
        , p1 :: Object
        , p2 :: Object
        , score :: (Integer, Integer)
        , result :: Integer
        , isOver :: Bool
        , padHeight :: Float
        , gameType :: Integer
        } deriving Show 
        
    type Radius = Float 
    type Position = (Float, Float) 
    type Control = MVar Integer

    levelOneState :: PongGame
    levelOneState = Game 
        { ball_one = (Obj 0 0 ballBaseSpeed_one ballBaseSpeed_one)
        , ball_two = (Obj 0 5000 0 0)
        , p1 = (Obj (-260) 0 0 0)
        , p2 = (Obj 260 0 0 0)
        , score = (0, 0)
        , result = 0
        , isOver = False
        , padHeight = 80
        , gameType = 1
        }
    
    levelTwoState :: PongGame
    levelTwoState = Game 
        { ball_one = (Obj 0 0 ballBaseSpeed_one ballBaseSpeed_one)
        , ball_two = (Obj 0 5000 0 0)
        , p1 = (Obj (-260) 0 0 0)
        , p2 = (Obj 260 0 0 0)
        , score = (0, 0)
        , result = 0
        , isOver = False
        , padHeight = 60
        , gameType = 2
        }

    levelThreeState :: PongGame
    levelThreeState = Game 
        { ball_one = (Obj 0 0 ballBaseSpeed_one ballBaseSpeed_one)
        , ball_two = (Obj 0 0 (ballBaseSpeed_one * (-0.8)) (ballBaseSpeed_one * (-0.8)))
        , p1 = (Obj (-260) 0 0 0)
        , p2 = (Obj 260 0 0 0)
        , score = (0, 0)
        , result = 0
        , isOver = False
        , padHeight = 100
        , gameType = 3
        }
