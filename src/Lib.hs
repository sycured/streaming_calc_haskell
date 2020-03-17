module Lib
  ( bwServer
  , serverUsageBw
  , printBwServer
  , printServerUsageBw
  )
where

bwServer :: Float -> Float -> Float
bwServer nblisteners bitrate = nblisteners * bitrate * 1000 / 1024

serverUsageBw :: Float -> Float -> Float -> Float -> Float
serverUsageBw nblisteners bitrate nbdays nbhours =
  nbdays * nbhours * 3600 * bitrate * 1000 / 8 * nblisteners / 1024 / 1024

printBwServer :: Float -> Float -> IO ()
printBwServer nblisteners bitrate = putStrLn
  (  "Number of listeners: "
  ++ shows nblisteners "\nBitrate (kb/s): "
  ++ shows bitrate     "\nServer bandwidth (Mib/s): "
  ++ result
  )
  where result = show (bwServer nblisteners bitrate)


printServerUsageBw :: Float -> Float -> Float -> Float -> IO ()
printServerUsageBw nblisteners bitrate nbdays nbhours = putStrLn
  (  "Number of listeners: "
  ++ shows nblisteners "\nBitrate (kb/s): "
  ++ shows bitrate     "\nNumber of days: "
  ++ shows nbdays      "\nNumber of hours by days: "
  ++ shows nbhours     "\nBandwidth used (GiB): "
  ++ result
  )
  where result = show (serverUsageBw nblisteners bitrate nbdays nbhours)
