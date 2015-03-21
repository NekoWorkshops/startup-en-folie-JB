module Main (main) where

import System.FilePath.Glob (glob)
import Test.DocTest (doctest)

main :: IO ()
main = do
  files <- glob "src/**/*.hs"
  doctest $ ["-XOverloadedStrings"] ++ files
