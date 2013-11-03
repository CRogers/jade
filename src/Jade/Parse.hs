{-# LANGUAGE NoMonomorphismRestriction #-}

module Jade.Parse (parseJade) where

import Text.Parsec hiding (State)
import Text.Parsec.Indent
import Control.Monad.State

import Jade.Types

type IParser a = IndentParser String () a

iParse :: IParser a -> SourceName -> String -> Either ParseError a
iParse p sn i = runIndent sn $ runParserT p () sn i

parseJade :: String -> Either ParseError Jade
parseJade s = Right $ Text "foo"