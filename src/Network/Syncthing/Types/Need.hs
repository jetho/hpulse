
{-# LANGUAGE OverloadedStrings #-}

module Network.Syncthing.Types.Need
    ( Need(..)
    , Progress(..)
    ) where

import           Control.Applicative ((<$>), (<*>))
import           Control.Monad       (MonadPlus (mzero))
import           Data.Aeson          (FromJSON, Value (..), parseJSON, (.:))
import           Data.Text           (Text)


data Need = Need {
      getProgress :: [Progress]
    , getQueued   :: [Text]
    , getRest     :: [Text]
    } deriving (Show)

data Progress = Progress { 
      getName            :: Text
    , getFlags           :: Int
    , getModified        :: Integer
    , getProgressVersion :: Int
    , getLocalVersion    :: Int
    , getNumBlocks       :: Int
    , getSize            :: Integer
    } deriving (Show)

instance FromJSON Progress where
    parseJSON (Object v) =
        Progress <$> (v .: "Name")
                 <*> (v .: "Flags")
                 <*> (v .: "Modified")
                 <*> (v .: "Version")
                 <*> (v .: "LocalVersion")
                 <*> (v .: "NumBlocks")
                 <*> (v .: "Size")
    parseJSON _          = mzero

instance FromJSON Need where
    parseJSON (Object v) =
        Need <$> (v .: "progress")
             <*> (v .: "queued")
             <*> (v .: "rest")
    parseJSON _          = mzero
