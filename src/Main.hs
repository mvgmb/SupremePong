import Control.Concurrent.MVar

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.IO.Game

import Data
import Events
import Ball
import Paddle
import Wall
import Score

window :: Display
window = InWindow "Pong" (width, height) (leftOffset, upOffset)
    
background :: Color
background = black

-- Frames per Second
fps :: Int
fps = 60

-- Transforms the Game state into a Picture to be rendered
render :: (PongGame, Control, Control) -> IO Picture
render (game, _, _) = do
    return(pics)    
    where 
        pics = pictures [ mkBall bx1 by1
                        , mkBall bx2 by2
                        , mkPaddle x1 y1 padH
                        , mkPaddle x2 y2 padH
                        , mkWall wallOffset
                        , mkWall (-wallOffset)
                        , mkScore p1Score p2Score (result game)
                        ]
        (Obj bx1 by1 _ _) = ball_one game
        (Obj bx2 by2 _ _) = ball_two game
        (Obj x1 y1 _ _) = p1 game
        (Obj x2 y2 _ _) = p2 game
        (p1Score, p2Score) = score game
        padH = padHeight game

update :: Float -> (PongGame, Control, Control) -> IO (PongGame, Control, Control)
update seconds (game, p1Control, p2Control) = return ( (ballBounce $ movePaddles seconds $ moveBall seconds game), p1Control, p2Control )

main :: IO()
main = do 
    p1Control <- newMVar 0
    p2Control <- newMVar 0
    playIO window background fps (levelOneState, p1Control, p2Control) render events update