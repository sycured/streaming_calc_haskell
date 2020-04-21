module Lib
  ( bwServer
  , serverUsageBw
  , printBwServer
  , printServerUsageBw
  )
where

import           Text.Format

bwServer :: Float -> Float -> Float
bwServer nblisteners bitrate = nblisteners * bitrate * 1000 / 1024

serverUsageBw :: Float -> Float -> Float -> Float -> Float
serverUsageBw nblisteners bitrate nbdays nbhours =
  nbdays * nbhours * 3600 * bitrate * 1000 / 8 * nblisteners / 1024 / 1024

printBwServer :: Float -> Float -> IO ()
printBwServer nblisteners bitrate = putStrLn
  (format
    "Number of listeners: {0} \nBitrate (kb/s): {1} \nServer bandwidth (Mib/s): {2}"
    [show nblisteners, show bitrate, result]
  )
  where result = show (bwServer nblisteners bitrate)


printServerUsageBw :: Float -> Float -> Float -> Float -> IO ()
printServerUsageBw nblisteners bitrate nbdays nbhours = putStrLn
  (format
    "Number of listeners: {0} \nBitrate (kb/s): {1} \nNumber of days: {2} \nNumber of hours by days: {3} \nBandwidth used (GiB): {4}"
    [show nblisteners, show bitrate, show nbdays, show nbhours, result]
  )
  where result = show (serverUsageBw nblisteners bitrate nbdays nbhours)
