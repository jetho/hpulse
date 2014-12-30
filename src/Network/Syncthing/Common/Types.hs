
{-# LANGUAGE OverloadedStrings #-}

module Network.Syncthing.Common.Types
    (
    -- * Common Types
      DeviceId
    , FolderName
    , SubPath
    , Host
    , Port
    , Addr

    -- * Defaults
    , defaultFolder
    ) where

import           Data.Text (Text)


type DeviceId   = Text

type FolderName = Text

type SubPath    = Text

type Host       = Text

type Port       = Int

type Addr       = (Host, Maybe Port)

defaultFolder :: FolderName
defaultFolder = "default"

