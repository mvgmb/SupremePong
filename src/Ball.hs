module Ball where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    ball :: PongGame -> Picture
    ball game = uncurry translate (ballLoc game) $ color ballColor $ circleSolid ballRadius

    moveBall :: Float -> PongGame -> PongGame
    moveBall seconds game = game { ballLoc = (x', y') }
        where
            -- old location
            (x, y) = ballLoc game
            (vx, vy) = ballVel game
            -- new location
            x' = x + vx * seconds
            y' = y + vy * seconds