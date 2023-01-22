module Main (main) where
import qualified Data.ByteString as B
import Lib 


main :: IO ()
main = do
    jsonData1 <- B.readFile "file1.json"
    jsonData2 <- B.readFile "file2.json"
    parseAndCompare jsonData1 jsonData2
