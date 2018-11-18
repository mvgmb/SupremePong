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

    wallCollision :: Position -> Bool 
    wallCollision (_, y) = topCollision || bottomCollision
        where
            topCollision    = y - ballRadius <= -wallOffset
            bottomCollision = y + ballRadius >=  wallOffset

    paddleCollision :: Position -> Float -> Float -> Bool
    paddleCollision (x, y) y1 y2 = leftCollision || rightCollision
        where
            leftCollision  = (x - ballRadius <= -260) && (x - ballRadius >= -275) && ( y <= (halfPad + y1) ) && ( y >= (y1 - halfPad) )
            rightCollision = (x + ballRadius >= 260)  && (x + ballRadius <= 275)  && ( y <= (halfPad + y2) ) && ( y >= (y2 - halfPad) )
        
            halfPad = padHeight / 2
              
    point :: Float -> Int
    point x = 
        if x > 275 
        then 1
        else if x < (-275)
        then 2
        else 0

    ballBounce :: PongGame -> PongGame
    ballBounce game = game { ball = (Obj x' y' vx' vy'), score = (p1Score',p2Score') }
        where
                (Obj x y vx vy) = ball game
                (Obj x1 y1 _ _) = p1 game
                (Obj x2 y2 _ _) = p2 game
                (p1Score, p2Score) = score game   

                padCol = paddleCollision (x, y) y1 y2
                wallCol = wallCollision (x, y)
                points = point x

                p1Score' = if points == 1
                    then (p1Score + 1)
                    else p1Score
                
                p2Score' = if points == 2
                    then (p2Score + 1)
                    else p2Score

                x' = if points /= 0
                    then 0
                    else x
                    
                y' = if points /= 0
                    then 0
                    else y
                
                vx' = if points /= 0
                    then ballBaseSpeed
                    else if padCol
                    then -(vx + vx * padInfluence)
                    else vx

                vy' = if points /= 0
                    then ballBaseSpeed
                    else if wallCol
                    then -vy
                    else if padCol
                        then (vy + vy * padInfluence)
                        else vy