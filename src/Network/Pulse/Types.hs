
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TemplateHaskell #-}

module Network.Pulse.Types 
    ( Pulse
    , PulseConfig(..)
    , Param
    , HttpMethod(..)
    , PulseRequest(..)
    , PulseError(..)
    , pServer
    , pApiKey
    , pAuth
    , pManager
    ) where

import Data.Typeable              (Typeable)
import Data.Text                  as T
import Network.Wreq               (Auth)
import Network.HTTP.Client        (Manager, ManagerSettings)
import Control.Lens               (makeLenses)
import Control.Monad.Trans.Either (EitherT)
import Control.Monad.Trans.Reader (ReaderT)
import Data.Aeson                 (Value)


data PulseConfig = PulseConfig { 
      _pServer    :: T.Text
    , _pApiKey    :: Maybe T.Text
    , _pAuth      :: Maybe Auth
    , _pManager   :: Either ManagerSettings Manager
    } 

$(makeLenses ''PulseConfig)

type Pulse a = EitherT PulseError (ReaderT PulseConfig IO) a

type Param = (T.Text, T.Text)

data HttpMethod = 
      Get 
    | Post Value
    deriving (Eq, Show)

data PulseRequest = PulseRequest { 
      path      :: String
    , method    :: HttpMethod
    , params    :: [Param]
    } deriving (Eq, Show)
    
data PulseError = 
      InvalidApiKey 
    | ParseError String 
    | NotFound 
    | RequestError 
    | Unauthorized
    deriving (Typeable, Eq, Show)

