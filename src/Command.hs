{-# LANGUAGE OverloadedStrings #-}

module Command (
  parseRequest
  , eval
  ) where

import Data.Text (Text)
import qualified Data.Text as T
import Text.Parsec (parse, string, digit, many1, ParseError)
import Text.Parsec.Text (Parser)

data Command = Add Int Int 
  deriving Show

parseRequest :: Text -> Either ParseError Command
parseRequest txt =
  let parser = addParser
  in parse parser "parseRequest" txt

-- | read addition
-- >>> parse addParser "test" "what is the sum of 12 and 5 ?"
-- Right (Add 12 5)
addParser :: Parser Command
addParser = do
  _ <- string "what is the sum of "
  a <- many1 digit
  _ <- string " and "
  b <- many1 digit
  _ <- string " ?"
  return $ Add (read a) (read b)

-- | eval
-- >>> eval $ Add 10 15
-- "25"
eval :: Command -> Text
eval c = case c of
  Add x y ->  T.pack $ show $ x + y
