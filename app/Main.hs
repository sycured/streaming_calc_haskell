import           Lib
import           System.Console.ArgParser.SubParser
import           System.Console.ArgParser


data Action
    = Bwsrv { _nblisteners :: Float, _bitrate :: Float}
    | Srvusgbw { _nblisteners :: Float, _bitrate :: Float, _nbdays :: Float, _nbhours :: Float}


parseBwsrv :: ParserSpec Action
parseBwsrv =
  Bwsrv
    `parsedBy` reqPos "nblisteners"
    `Descr`    "number of listeners"
    `andBy`    reqPos "bitrate"
    `Descr`    "bitrate in kb/s"

parseSrvusgbw :: ParserSpec Action
parseSrvusgbw =
  Srvusgbw
    `parsedBy` reqPos "nblisteners"
    `Descr`    "number of listeners"
    `andBy`    reqPos "bitrate"
    `Descr`    "bitrate in kb/s"
    `andBy`    reqPos "nbdays"
    `Descr`    "number of days"
    `andBy`    reqPos "nbhours"
    `Descr`    "number of hours by days"

mainParser :: IO (CmdLnInterface Action)
mainParser = mkSubParser
  [ ( "bwserver"
    , mkDefaultApp parseBwsrv "bwserver"
      `setAppDescr` "Determine necessary server bandwidth"
    )
  , ( "usagebw"
    , mkDefaultApp parseSrvusgbw "usagebw"
      `setAppDescr` "Determine the amount of data used for the streaming"
    )
  ]

main :: IO ()
main = mainParser >>= flip runApp dispatch

dispatch :: Action -> IO ()
dispatch argv@Bwsrv{}    = printBwServer (_nblisteners argv) (_bitrate argv)
dispatch argv@Srvusgbw{} = printServerUsageBw (_nblisteners argv)
                                              (_bitrate argv)
                                              (_nbdays argv)
                                              (_nbhours argv)
