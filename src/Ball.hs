module Ball where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    mkBall :: PongGame -> Picture
    mkBall game = uncurry translate trans $ color ballColor $ circleSolid ballRadius
        where 
            (Obj x y _ _) = ball game
            trans = (x, y)

    moveBall :: Float -> PongGame -> PongGame
    moveBall seconds game = game 
        { ball = (Obj x' y' vx vy)
        } where
            -- old values
            (Obj x y vx vy) = ball game
            -- new values
            x' = x + vx * seconds
            y' = y + vy * seconds

    