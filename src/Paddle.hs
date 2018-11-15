module Paddle where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    mkPaddle :: Float -> Float -> Picture
    mkPaddle x y = pictures
        [ translate x y $ color padColor $ rectangleSolid padWidth padHeight]


    movePaddles :: Float -> PongGame -> PongGame
    movePaddles seconds game = game { p1Loc = (px1', py1'), p2Loc = (px2', py2') }
        where 
            -- Old locations
            (px1, py1) = p1Loc game
            (px2, py2) = p2Loc game 
            -- Velocity Values
            (vx1, vy1) = p1Vel game
            (vx2, vy2) = p2Vel game
            -- New Locations
            px1' = px1 + vx1 * seconds
            py1' = py1 + vy1 * seconds
            px2' = px2 + vx2 * seconds
            py2' = py2 + vy2 * seconds