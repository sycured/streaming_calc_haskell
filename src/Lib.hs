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
printBwServer nblisteners bitrate = do
  let result = bwServer nblisteners bitrate
  putStrLn
    (  "Number of listeners: "
    ++ show nblisteners
    ++ "\nBitrate (kb/s): "
    ++ show bitrate
    ++ "\nServer bandwidth (Mib/s): "
    ++ show result
    )

printServerUsageBw :: Float -> Float -> Float -> Float -> IO ()
printServerUsageBw nblisteners bitrate nbdays nbhours = do
  let result = serverUsageBw nblisteners bitrate nbdays nbhours
  putStrLn
    (  "Number of listeners: "
    ++ show nblisteners
    ++ "\nBitrate (kb/s): "
    ++ show bitrate
    ++ "\nNumber of days: "
    ++ show nbdays
    ++ "\nNumber of hours by days: "
    ++ show nbhours
    ++ "\nBandwidth used (GiB): "
    ++ show result
    )
