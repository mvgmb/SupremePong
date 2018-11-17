module Ball where

    import Data
    import Graphics.Gloss.Interface.Pure.Game
    import Control.Concurrent
    import Control.Concurrent.MVar

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

    wallCollision :: Position -> Bool 
    wallCollision (_, y) = topCollision || bottomCollision
        where
            topCollision    = y - ballRadius <= -wallOffset
            bottomCollision = y + ballRadius >=  wallOffset

    paddleCollision :: PongGame -> Position -> Float -> Float -> Bool
    paddleCollision game (x, y) y1 y2 = leftCollision || rightCollision
        where
            leftCollision  = (x - ballRadius <= -260) && (x - ballRadius >= -275) && ( y <= (halfPad + y1) ) && ( y >= (y1 - halfPad) )
            rightCollision = (x + ballRadius >= 260)  && (x + ballRadius <= 275)  && ( y <= (halfPad + y2) ) && ( y >= (y2 - halfPad) )
        
            halfPad = padHeight / 2
                                     
    ballBounce :: PongGame -> PongGame
    ballBounce game = game { ball = (Obj x y vx' vy') }
        where
                (Obj x y vx vy) = ball game
                (Obj x1 y1 _ _) = p1 game
                (Obj x2 y2 _ _) = p2 game

                padCol = paddleCollision game (x, y) y1 y2
                wallCol = wallCollision (x, y)
                
                vx' = if padCol
                    then -(vx + vx * padInfluence)
                    else vx

                vy' = if wallCol
                    then -vy
                    else if padCol
                        then (vy + vy * padInfluence)
                        else vy
                
                