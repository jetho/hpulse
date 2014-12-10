
{-# LANGUAGE OverloadedStrings #-}

module Network.Syncthing.Post.Ping
    ( ping
    ) where

import           Control.Applicative           ((<$>))
import           Data.Text                     (Text)
import           Network.Syncthing.Common.Ping
import           Network.Syncthing.Query
import           Network.Syncthing.Types


ping :: MonadSync m => SyncM m Text
ping = getPing <$> ping'
  where
    ping' = query $ postRequest { path = "/rest/ping" }

