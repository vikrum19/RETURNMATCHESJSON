module Lib (parseAndCompare) where

import Data.Aeson (eitherDecode)
import Data.List
import Data.ByteString.Lazy (ByteString)


data Person = Person
  { name :: Text
  , number :: Int
  , phone :: Text
  } deriving (Show, Eq)


-- to decode a Json value we first convert the Json string to value of our haskell value after making the Person type instance of FromJson class we can use 
-- returns mzero if any value other than JsonObject is passed
-- decode or eitherDecode function to decode to sepcifiv type

instance FromJSON Person where

  parseJSON (Object v) = Person <$> v .: "name" <*> v .: "number" <*> v .: "phone"

  parseJSON _ = mzero

--compare both the lists using filter function and returns a tuple of matches and mismatches
compareData :: [Person] -> [Person] -> ([Person], [Person])
compareData xs ys = (matches, mismatches)

  where

    matches = filter (\x -> x `elem` ys) xs
    mismatches =filter (\x -> x `notElem` ys) xs


parseAndCompare :: ByteString -> ByteString -> IO ()
parseAndCompare x y =

  case (eitherDecode x, eitherDecode y) of

    (Right xs, Right ys) -> do

      let (matches, mismatches) = compareData xs ys

      putStrLn "Matches:"

      mapM_ print matches

      putStrLn "Mismatches:"

      mapM_ print mismatches

    (Left e, _) -> putStrLn $ "Error decoding first input: " ++ e

    (_, Left e) -> putStrLn $ "Error decoding second input: " ++ e

    


