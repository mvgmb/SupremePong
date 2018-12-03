module Events where
    
    import Data
    import Control.Concurrent.MVar
    import Graphics.Gloss.Interface.Pure.Game

    events :: Event -> (PongGame, Control, Control) -> IO (PongGame, Control, Control)
    -- KEYDOWN events
    -- Player 1
    events (EventKey (Char 'w') (Down) _ _) (game, p1Control, p2Control) = do
        c <- takeMVar p1Control
        putMVar p1Control (c+1)
        return (game { p1 = (Obj x y 0 maxPadVel) } , p1Control, p2Control)
        where (Obj x y vx vy) = p1 game
    
    events (EventKey (Char 's') Down _ _) (game, p1Control, p2Control) = do
        c <- takeMVar p1Control
        putMVar p1Control (c+1)
        return (game { p1 = (Obj x y 0 (-maxPadVel)) } , p1Control, p2Control)
        where (Obj x y vx vy) = p1 game

    -- Player 2
    events (EventKey (SpecialKey KeyUp) (Down) _ _) (game, p1Control, p2Control) = do
        c <- takeMVar p2Control
        putMVar p2Control (c+1)
        return (game { p2 = (Obj x y 0 maxPadVel) } , p1Control, p2Control)
        where (Obj x y vx vy) = p2 game

    events (EventKey (SpecialKey KeyDown) (Down) _ _) (game, p1Control, p2Control) = do
        c <- takeMVar p2Control
        putMVar p2Control (c+1)
        return (game { p2 = (Obj x y 0 (-maxPadVel)) }, p1Control, p2Control)
        where (Obj x y vx vy) = p2 game

    events (EventKey (Char '1') (Down) _ _) (game, p1Control, p2Control)= do
        return (levelOneState, p1Control, p2Control)
    
    events (EventKey (Char '2') (Down) _ _) (game, p1Control, p2Control)= do
        return (levelTwoState, p1Control, p2Control)

    events (EventKey (Char '3') (Down) _ _) (game, p1Control, p2Control)= do
        return (levelThreeState, p1Control, p2Control)

    events (EventKey (SpecialKey KeySpace) _ _ _) (game, p1Control, p2Control) = do
        return (levelOneState, p1Control, p2Control)

    -- KEYUP events
    events (EventKey k (Up) _ _) (game, p1Control, p2Control)
    -- Player 1
        | (Char 'w') <- k = do
            c <- takeMVar p1Control
            putMVar p1Control (c-1)
            if (c-1) == 0    
            then return( game { p1 = (Obj x1 y1 0 0) }, p1Control, p2Control )
            else return( game { p1 = (Obj x1 y1 0 (-maxPadVel)) }, p1Control, p2Control )

        | (Char 's') <- k = do
            c <- takeMVar p1Control
            putMVar p1Control (c-1)
            if (c-1) == 0    
            then return( game { p1 = (Obj x1 y1 0 0) }, p1Control, p2Control ) 
            else return( game { p1 = (Obj x1 y1 0 maxPadVel) }, p1Control, p2Control )

    -- Player 2
        | SpecialKey KeyUp <- k = do
            c <- takeMVar p2Control
            putMVar p2Control (c-1)
            if (c-1) == 0    
            then return( game { p2 = (Obj x2 y2 0 0) }, p1Control, p2Control )
            else return( game { p2 = (Obj x2 y2 0 (-maxPadVel)) }, p1Control, p2Control )

        | SpecialKey KeyDown <- k = do
            c <- takeMVar p2Control
            putMVar p2Control (c-1)
            if (c-1) == 0    
            then return( game { p2 = (Obj x2 y2 0 0) }, p1Control, p2Control ) 
            else return( game { p2 = (Obj x2 y2 0 maxPadVel) }, p1Control, p2Control )
        
        | otherwise = do -- nothing
            return(game, p1Control, p2Control)
            where
                (Obj x1 y1 vx1 vy1) = p1 game
                (Obj x2 y2 vx2 vy2) = p2 game
    -- default
    events _ (game, p1Control, p2Control) = return (game, p1Control, p2Control)