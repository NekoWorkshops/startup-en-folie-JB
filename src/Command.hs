{-# LANGUAGE OverloadedStrings #-}

module Command (
  parseRequest
  , evalCommand
  ) where

import           Data.Text        (Text)
import qualified Data.Text        as T
import           Text.Parsec      (ParseError, digit, many1, parse, string, choice,
                                   oneOf)
import           Text.Parsec.Text (Parser)
import Control.Applicative ((<$>), (<$), (*>), (<*), (<*>))

data Command = Add Int Int
               | Name
  deriving Show

parseRequest :: Text -> Either ParseError Command
parseRequest txt =
  let parser = choice [
        addParser,
        nameParser
        ]
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

nameParser :: Parser Command
nameParser = Name <$ headerParser <* string "what is your name"


-- | parse header
-- >>> parse headerParser "test" "0041f190: "
-- Right "0041f190"
headerParser :: Parser String
headerParser =  many1 (oneOf "0123456789abcdef") <* string ": "

-- | command evaluator
-- >>> evalCommand $ Add 10 15
-- "25"
evalCommand :: Command -> Text
evalCommand c = case c of
  Add x y ->  T.pack $ show $ x + y
  Name -> "JB"
