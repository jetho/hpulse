
{-# LANGUAGE OverloadedStrings #-}

module Network.Syncthing.Types.Error
    ( Error(..)
    , Errors(..)
    ) where

import           Control.Applicative              ((<$>), (<*>))
import           Control.Monad                    (MonadPlus (mzero))
import           Data.Aeson                       (FromJSON, Value (..), parseJSON, (.:))
import           Data.Text                        (Text)
import           Data.Time.Clock                  (UTCTime)

import           Network.Syncthing.Utils          (toUTC)


data Error = Error {
      getTime :: Maybe UTCTime
    , getMsg  :: Text
    } deriving (Show)

newtype Errors = Errors { getErrors :: [Error] }

instance FromJSON Error where
    parseJSON (Object v) =
        Error <$> (toUTC <$> (v .:  "Time"))
              <*> (v .:  "Error")
    parseJSON _          = mzero

instance FromJSON Errors where
    parseJSON (Object v) = Errors <$> (v .: "errors")
    parseJSON _          = mzero
