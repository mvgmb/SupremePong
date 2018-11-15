module Events where
    
    import Data
    import Graphics.Gloss.Interface.Pure.Game


    handleKeys :: Event -> PongGame -> PongGame
    -- Player 1 controls
    handleKeys (EventKey (Char 'w') (Down) _ _) game = game { p1Vel = (0, vy') }
        where  
            (vx, vy) = p1Vel game
            (_, vyPad) = padVel game
            vy' = vyPad
    handleKeys (EventKey (Char 's') (Down) _ _) game = game { p1Vel = (0, vy') }
        where  
            (vx, vy) = p1Vel game
            (_, vyPad) = padVel game
            vy' = -vyPad
    
    -- Player 2 controls
    handleKeys (EventKey (SpecialKey KeyUp) (Down) _ _) game = game { p2Vel = (0, vy') }
        where  
            (vx, vy) = p2Vel game
            (_, vyPad) = padVel game
            vy' = vyPad
    handleKeys (EventKey (SpecialKey KeyDown) (Down) _ _) game = game { p2Vel = (0, vy') }
        where  
            (vx, vy) = p2Vel game
            (_, vyPad) = padVel game
            vy' = -vyPad

    -- Handling up key event, to create smooth controllers
    handleKeys (EventKey k (Up) _ _) game
        | (Char 'w') <- k, vy < 0 = game { p1Vel = (0, vy) }
        | (Char 's') <- k, vy > 0 = game { p1Vel = (0, vy) }

        | SpecialKey KeyUp <- k, vy < 0 = game { p2Vel = (0, vy) }
        | SpecialKey KeyDown <- k, vy > 0 = game { p2Vel = (0, vy) }

        | otherwise = game { p1Vel = (0, 0), p2Vel = (0, 0) }
            where
                (_, vy) = p2Vel game 
    -- Generic Case
    handleKeys _ game = game