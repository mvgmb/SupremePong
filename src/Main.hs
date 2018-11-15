import Control.Concurrent
import Control.Concurrent.MVar

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

import Data
import Events
import Ball
import Paddle

window :: Display
window = InWindow "Pong" (width, height) (offset, offset)
    
background :: Color
background = black

-- Frames per Second
fps :: Int
fps = 60

-- Transforms the Game state into a Picture to be rendered
render :: PongGame -> Picture
render game =
    pictures [ ball game
             , mkPaddle px1 py1
             , mkPaddle px2 py2
             ]
        where
            (px1, py1) = p1Loc game
            (px2, py2) = p2Loc game

update :: Float -> PongGame -> PongGame
update seconds game = movePaddles seconds $ moveBall seconds game

main :: IO()
main = play window background fps initialState render handleKeys update

