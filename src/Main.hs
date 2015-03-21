{-# LANGUAGE OverloadedStrings #-}

import qualified Command                              as C
import qualified Data.Text                            as T
import           Network.HTTP.Types.Status            (status400)
import           Network.Wai.Middleware.RequestLogger (logStdoutDev)
import           Web.Spock.Safe                       (SpockT, get, middleware,
                                                       param, root, runSpock,
                                                       setStatus, spockT, text)

appMiddleware :: SpockT IO ()
appMiddleware = middleware logStdoutDev

appRoutes :: SpockT IO ()
appRoutes =
  get root $ do
    maybeQ <- param "q"
    case maybeQ of
     Nothing -> text "JB"
     Just q -> case C.parseRequest q of
       Left parseError -> do
         setStatus status400
         text $ T.pack $ show parseError
       Right command -> text $ C.evalCommand command

main :: IO ()
main = runSpock 3000 $ spockT id $ appMiddleware >> appRoutes
