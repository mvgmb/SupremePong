module Paddle where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    mkPaddle :: Float -> Float -> Float -> Picture
    mkPaddle x y padHeight = pictures
        [ translate x y $ color padColor $ rectangleSolid padWidth padHeight]


    movePaddles :: Float -> PongGame -> PongGame
    movePaddles seconds game = game 
        { p1 = (Obj x1' y1' vx1 vy1)
        , p2 = (Obj x2' y2' vx2 vy2) 
        } where 
            -- Old values
            (Obj x1 y1 vx1 vy1) = p1 game
            (Obj x2 y2 vx2 vy2) = p2 game
            -- New Values
            x1' = x1 + vx1 * seconds
            y1' = y1 + vy1 * seconds
            x2' = x2 + vx2 * seconds
            y2' = y2 + vy2 * seconds