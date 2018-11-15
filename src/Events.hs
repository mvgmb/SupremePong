module Events where
    
    import Data
    import Graphics.Gloss.Interface.Pure.Game


    handleKeys :: Event -> PongGame -> PongGame
    -- Player 1 controls
    handleKeys (EventKey (Char 'w') (Down) _ _) game = game 
        { p1 = (Obj x y 0 maxPadVel) 
        } where  
            (Obj x y vx vy) = p1 game

    handleKeys (EventKey (Char 's') (Down) _ _) game = game 
        { p1 = (Obj x y 0 (-maxPadVel)) 
        } where  
            (Obj x y vx vy) = p1 game

    -- Player 2 controls
    handleKeys (EventKey (SpecialKey KeyUp) (Down) _ _) game =  game 
        { p2 = (Obj x y 0 maxPadVel) 
        } where  
            (Obj x y vx vy) = p2 game
    handleKeys (EventKey (SpecialKey KeyDown) (Down) _ _) game =  game 
        { p2 = (Obj x y 0 (-maxPadVel)) 
        } where  
            (Obj x y vx vy) = p2 game

    -- Handling up key event, to create smooth controllers
    handleKeys (EventKey k (Up) _ _) game
        | (Char 'w') <- k, vy1 < 0 = game { p1 = (Obj x1 y1 0 vy1) }
        | (Char 's') <- k, vy1 > 0 = game { p1 = (Obj x1 y1 0 vy1) }

        | SpecialKey KeyUp <- k, vy2 < 0 = game { p2 = (Obj x2 y2 0 vy2) }
        | SpecialKey KeyDown <- k, vy2 > 0 = game { p2 = (Obj x2 y2 0 vy2) }

        | otherwise = game { p1 = (Obj x1 y1 0 0), p2 = (Obj x2 y2 0 0) }
            where
                (Obj x1 y1 vx1 vy1) = p1 game
                (Obj x2 y2 vx2 vy2) = p2 game
    -- Generic Case
    handleKeys _ game = game