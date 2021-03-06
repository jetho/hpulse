
{-# LANGUAGE OverloadedStrings #-}

module Network.Syncthing.Types.Version
    ( Version(..)
    ) where

import           Control.Applicative              ((<$>), (<*>))
import           Control.Monad                    (MonadPlus (mzero))
import           Data.Aeson                       (FromJSON, Value (..), parseJSON, (.:))
import           Data.Text                        (Text)


-- | Current Syncthing version information.
data Version = Version {
      getArch        :: Text
    , getLongVersion :: Text
    , getOs          :: Text
    , getVersion     :: Text
    } deriving (Eq, Show)

instance FromJSON Version where
    parseJSON (Object v) =
        Version <$> (v .: "arch")
                <*> (v .: "longVersion")
                <*> (v .: "os")
                <*> (v .: "version")
    parseJSON _          = mzero

