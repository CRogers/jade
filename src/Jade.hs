module Jade where

import Text.Parsec (ParseError)

import Jade.Types
import Jade.Parse

main = putStrLn "foo"

compile :: String -> Either ParseError String
compile s = do
	jade <- parseJade s
	case jade of Text x -> return x