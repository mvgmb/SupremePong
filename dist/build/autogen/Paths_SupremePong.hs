{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_SupremePong (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/mario/git/SupremePong/.cabal-sandbox/bin"
libdir     = "/home/mario/git/SupremePong/.cabal-sandbox/lib/x86_64-linux-ghc-8.0.2/SupremePong-0.1.0.0"
dynlibdir  = "/home/mario/git/SupremePong/.cabal-sandbox/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/mario/git/SupremePong/.cabal-sandbox/share/x86_64-linux-ghc-8.0.2/SupremePong-0.1.0.0"
libexecdir = "/home/mario/git/SupremePong/.cabal-sandbox/libexec"
sysconfdir = "/home/mario/git/SupremePong/.cabal-sandbox/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "SupremePong_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "SupremePong_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "SupremePong_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "SupremePong_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "SupremePong_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "SupremePong_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
