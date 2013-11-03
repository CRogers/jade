module Jade.Test where

import Test.HUnit
import Jade
import Control.Monad

testDir = "tests/"

makeTestCase :: String -> Test
makeTestCase n = TestCase $ do
	input  <- readFile $ testDir ++ n ++ ".jade"
	output <- readFile $ testDir ++ n ++ ".html"
	case compile input of
		Right x -> assertEqual "" output x
		Left _ -> assertFailure "Parse error"

testPrefixes :: [String]
testPrefixes =
	[
		"basic"
	]

testCases :: [Test]
testCases = map makeTestCase testPrefixes

runTestCases :: IO [Counts]
runTestCases = forM testCases runTestTT