{-# LANGUAGE NoMonomorphismRestriction #-}

module Jade.Parse where

import Text.Parsec hiding (State)
import Text.Parsec.Indent
import Control.Monad.State
import Control.Applicative ((<*>), (<$>))
import qualified Data.Map as M

import Jade.Types

type IParser a = IndentParser String () a

iParse :: IParser a -> SourceName -> String -> Either ParseError a
iParse p sn i = runIndent sn $ runParserT p () sn i

testp p i = iParse p "" i 


parseJade :: String -> Either ParseError Jade
parseJade s = Right $ Text "foo"

quoted q = between (char q) (char q) (many $ noneOf [q])
quotedString = quoted '\'' <|> quoted '"' 

attribName = many1 letter
attribValue = quotedString 

attrib = do
	n <- attribName
	spaces
	char '='
	spaces
	v <- attribValue
	return (n, v)

attribs = do
	char '('
	as <- sepBy attrib (spaces >> char ',' >> spaces)
	spaces
	char ')'
	return $ M.fromList as

posAttribs = try attribs <|> return M.empty


tag = do
	n <- many1 letter
	as <- posAttribs
	spaces
	return (n, as) 

rawText = Text <$> (many $ noneOf "\n")

jadeBlock = withBlock (uncurry Tag) tag rawText