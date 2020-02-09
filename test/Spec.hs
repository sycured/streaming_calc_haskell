import           Lib
import           Test.Hspec
import           Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "tests with integer" $ do
    it "bwserver" $ bwServer 250 64 `shouldBe` 15625.0
    it "usagebw" $ serverUsageBw 250 64 1 24 `shouldBe` 164794.921875

  describe "tests with float" $ do
    it "bwserver" $ bwServer 250 64.8 `shouldBe` 15820.313
    it "usagebw" $ serverUsageBw 250 64.8 1 24 `shouldBe` 166854.88
