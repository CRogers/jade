module Jade.Types where

import qualified Data.Map as M 

type TagName = String
type Attributes = M.Map String String

data Jade = 
	  Text String
	| Tag TagName Attributes Jade
	deriving (Show, Eq)