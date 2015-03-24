{-# LANGUAGE OverloadedStrings #-}

module Command (
  parseRequest
  , evalCommand
  ) where

import           Control.Applicative ((*>), (<$), (<$>), (<*), (<*>))
import           Data.Text           (Text)
import qualified Data.Text           as T
import           Text.Parsec         (ParseError, choice, digit, many1, oneOf,
                                      parse, string, sepBy, try)
import           Text.Parsec.Text    (Parser)
import Data.List (intercalate)

data Command = Largest [Int]
               | Add Int Int
               | Mult Int Int
               | Minus Int Int
               | Eiffel
               | PM
               | SquareCube [Int]
               | Banana
               | Prime [Int]
               | Spain
  deriving Show

parseRequest :: Text -> Either ParseError Command
parseRequest txt =
  let parser = headerParser *> choice [
        try largestParser,
        try addParser,
        try multParser,
        try minusParser,
        try eiffelParser,
        try primeMinisterParser,
--        try squareCubeParser,
        try bananaParser,
        try primeParser,
        try spainParser
        ]
  in parse parser "parseRequest" txt


intParser :: Parser Int
intParser = read <$> many1 digit

numbersParser :: Parser [Int]
numbersParser = intParser `sepBy` string ", "

eiffelParser :: Parser Command
eiffelParser = Eiffel <$ string "which city is the Eiffel tower in"

bananaParser :: Parser Command
bananaParser = Banana <$ string "what colour is a banana"

primeMinisterParser :: Parser Command
primeMinisterParser = PM <$ string "who is the Prime Minister of Great Britain"

addParser :: Parser Command
addParser = Add <$> (string "what is " *> intParser) <*> (string " plus " *> intParser)

minusParser :: Parser Command
minusParser = Minus <$> (string "what is " *> intParser) <*> (string " minus " *> intParser)

multParser :: Parser Command
multParser = Mult <$> (string "what is " *> intParser) <*> (string " multiplied by " *> intParser)

largestParser :: Parser Command
largestParser = Largest <$> (string "which of the following numbers is the largest: " *> numbersParser)

primeParser :: Parser Command
primeParser = Prime <$> (string "which of the following numbers are primes: " *> numbersParser)

squareCubeParser :: Parser Command
squareCubeParser = SquareCube <$> (string "which of the following numbers is both a square and a cube: " *> numbersParser)

spainParser :: Parser Command
spainParser = Spain <$ string "what currency did Spain use before the Euro"

-- | parse header
-- >>> parse headerParser "test" "0041f190: "
-- Right "0041f190"
headerParser :: Parser String
headerParser =  many1 (oneOf "0123456789abcdef") <* string ": "

-- | command evaluator
evalCommand :: Command -> Text
evalCommand c = case c of
    Largest xs -> T.pack $ show $ maximum xs
    Add a b -> T.pack $ show  (a  + b)
    Mult a b -> T.pack $ show (a * b)
    Minus a b -> T.pack $ show (a - b) 
    Eiffel -> T.pack "Paris"
    PM -> T.pack "David Cameron"
--    SquareCube xs -> T.pack $ show $ head xs
    Banana -> T.pack "yellow"
    Spain -> T.pack "peseta"
    Prime xs -> T.pack $ intercalate  ", " $  map show $ filter isPrime xs



-- | isPrime
-- >>> filter isPrime [2..10]
-- [2,3,5,7]
isPrime :: Int -> Bool
isPrime n =  null [m | m <- [2..n-1], n `mod` m == 0]
