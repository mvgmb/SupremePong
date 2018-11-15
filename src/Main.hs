import Control.Concurrent
import Control.Concurrent.MVar

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

import Data
import Events
import Ball
import Paddle
import Wall

window :: Display
window = InWindow "Pong" (width, height) (leftOffset, upOffset)
    
background :: Color
background = black

-- Frames per Second
fps :: Int
fps = 60

-- Transforms the Game state into a Picture to be rendered
render :: PongGame -> Picture
render game =
    pictures [ mkBall game
             , mkPaddle x1 y1
             , mkPaddle x2 y2
             , mkWall wallOffset
             , mkWall (-wallOffset)
             ]
        where
            (Obj x1 y1 _ _) = p1 game
            (Obj x2 y2 _ _) = p2 game

update :: Float -> PongGame -> PongGame
update seconds game = movePaddles seconds $ moveBall seconds game

main :: IO()
main = play window background fps initialState render handleKeys update

