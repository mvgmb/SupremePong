module Wall where

    import Data
    import Graphics.Gloss.Interface.Pure.Game

    mkWall :: Float -> Picture
    mkWall offset =
        translate 0 offset $
        color wallColor $
        rectangleSolid 550 10

