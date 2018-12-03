module Ball where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    mkBall :: Float -> Float -> Picture
    mkBall x y = uncurry translate trans $ color ballColor $ circleSolid ballRadius
        where 
            trans = (x, y)

    moveBall :: Float -> PongGame -> PongGame
    moveBall seconds game = game 
        { ball_one = (Obj x1' y1' vx1 vy1)
        , ball_two = (Obj x2' y2' vx2 vy2)
        } where
            -- old values
            (Obj x1 y1 vx1 vy1) = ball_one game
            (Obj x2 y2 vx2 vy2) = ball_two game
            -- new values
            x1' = x1 + vx1 * seconds
            y1' = y1 + vy1 * seconds
            x2' = x2 + vx2 * seconds
            y2' = y2 + vy2 * seconds

    wallCollision :: Position -> Bool 
    wallCollision (_, y) = topCollision || bottomCollision
        where
            topCollision    = y - ballRadius <= -wallOffset
            bottomCollision = y + ballRadius >=  wallOffset

    paddleCollision :: Float -> Position -> Float -> Float -> Bool
    paddleCollision padHeight (x, y) y1 y2 = leftCollision || rightCollision
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
    ballBounce game = game { ball_one = (Obj x1' y1' vx1' vy1')
                           , ball_two = (Obj x2' y2' vx2' vy2')
                           , score = (p1Score',p2Score')
                           , result = result'
                           , isOver = isOver' }
        where
                (Obj bx1 by1 bvx1 bvy1) = ball_one game
                (Obj bx2 by2 bvx2 bvy2) = ball_two game
                (Obj x1 y1 _ _) = p1 game
                (Obj x2 y2 _ _) = p2 game
                (p1Score, p2Score) = score game  
                padH = padHeight game
                gType = gameType game
                
                padCol1 = paddleCollision padH (bx1, by1) y1 y2
                padCol2 = paddleCollision padH (bx2, by2) y1 y2

                wallCol1 = wallCollision (bx1, by1)
                wallCol2 = wallCollision (bx2, by2)
                
                points1 = point bx1
                points2 = point bx2
                points = points1 + points2

                p1Score' = if isOver game
                    then p1Score
                    else if (points1 == 1 || points2 == 1)
                    then (p1Score + 1)
                    else p1Score
                
                p2Score' = if isOver game
                    then p2Score
                    else if (points1 == 2 || points2 == 2)
                    then (p2Score + 1)
                    else p2Score

                result' = if p1Score' == maxScore
                        then 1
                        else if p2Score' == maxScore
                        then 2
                        else 0
                
                isOver' = if result' /= 0
                        then True
                        else False

                x1' = if points /= 0
                    then 0
                    else bx1
                    
                y1' = if points /= 0
                    then 0
                    else by1
                
                vx1' = if points /= 0
                    then ballBaseSpeed_one * fromInteger ((p1Score' - p1Score) + (p2Score - p2Score'))
                    else if padCol1
                    then -(bvx1 + bvx1 * padInfluence)
                    else bvx1

                vy1' = if points /= 0
                    then ballBaseSpeed_one - (ballBaseSpeed_one * fromInteger (p1Score' + p2Score') / 6) * 0.9
                    else if wallCol1
                    then -bvy1
                    else if padCol1
                        then (bvy1 + bvy1 * padInfluence)
                        else bvy1

                x2' = if gType == 3
                    then if points /= 0
                        then 0
                        else bx2
                    else bx2
                    
                y2' = if gType == 3
                    then if points /= 0
                        then 0
                        else by2
                    else by2
                
                vx2' = if gType == 3
                    then if points /= 0
                        then ballBaseSpeed_two * fromInteger ((p1Score' - p1Score) + (p2Score - p2Score'))
                        else if padCol2
                            then -(bvx2 + bvx2 * padInfluence)
                            else bvx2
                    else bvx2

                vy2' = if gType == 3
                    then if points /= 0
                        then ballBaseSpeed_two - (ballBaseSpeed_two * fromInteger (p1Score' + p2Score') / 6) * 0.9
                        else if wallCol2
                            then -bvy2
                            else if padCol2
                                then (bvy2 + bvy2 * padInfluence)
                                else bvy2
                    else bvy2