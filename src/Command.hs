{-# LANGUAGE OverloadedStrings #-}

module Command (
  parseRequest
  , evalCommand
  ) where

import           Data.Text        (Text)
import qualified Data.Text        as T
import           Text.Parsec      (ParseError, digit, many1, parse, string)
import           Text.Parsec.Text (Parser)
import Control.Applicative ((<$>), (*>), (<*), (<*>))

data Command = Add Int Int
  deriving Show

parseRequest :: Text -> Either ParseError Command
parseRequest txt =
  let parser = addParser
  in parse parser "parseRequest" txt

-- | addition parser
-- >>> parse addParser "test" "what is the sum of 12 and 5 ?"
-- Right (Add 12 5)
addParser :: Parser Command
addParser =
  Add <$>
  (string "what is the sum of " *> intParser <* string " and ") <*>
  intParser <* string " ?"
  where
    intParser :: Parser Int
    intParser = read <$> many1 digit
    
-- | command evaluator
-- >>> evalCommand $ Add 10 15
-- "25"
evalCommand :: Command -> Text
evalCommand c = case c of
  Add x y ->  T.pack $ show $ x + y
