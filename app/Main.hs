module Main where
import System.IO
import Data.List.Utils (replace)
import Data.List.Split (splitOn)
import Data.List (transpose)
import Data.List (intercalate)
import System.Environment

transformCSV :: String -> IO [String]
transformCSV inputCSV = do
    contents <- readFile inputCSV
    let newContents = replace "," "|" contents  
    return (lines newContents)

transformElement :: String -> [String]
transformElement element = splitOn "|" (replace " " "" element)

getSizeOfNthColumn :: [[String]] -> Int -> Int
getSizeOfNthColumn csv nElement = maximum (map length (map (!! nElement) csv))

getSizeOfColumn :: [String] -> Int
getSizeOfColumn col = maximum (map length col)

getSizeOfColumns :: [[String]] -> [Int]
getSizeOfColumns csv = map getSizeOfColumn (transpose csv)

adjustCell :: String -> Int -> String
adjustCell cell colSize = do
  if length cell >= colSize then  (cell ++ "|")
  else if length cell < colSize then adjustCell (cell ++ " ") colSize
  else cell

adjustColumn :: [String] -> Int -> [String]
adjustColumn column size = map  (\cell -> adjustCell cell size)    column

formatOutput :: [[String]] -> IO ()
formatOutput csv = putStrLn $ intercalate "\n" $ map unwords csv


main :: IO ()
main = do
    args <- getArgs
    let arg = (args !! 0)
    csvList <- transformCSV arg
    let csvListTransformed = map transformElement csvList
    let columnSizes = getSizeOfColumns csvListTransformed
    let adjustedCSV = zipWith adjustColumn (transpose csvListTransformed) columnSizes
    formatOutput (transpose adjustedCSV)
