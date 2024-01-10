-- {-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Unsafe #-}

module Main (main) where

import Data.Location.GoogleLocation as GL
import Data.Location.Model as M

import Data.Time

import CmdOptions

import System.IO

addDaysUTCTime :: UTCTime -> Integer -> UTCTime
addDaysUTCTime t x = addUTCTime (nominalDay * fromIntegral x) t

main :: IO ()
main = do
    configuration <- getConfiguration

    -- Get the location records from the Google Takout file
    locationList <- GL.getLocationRecords (inputFilename configuration)

    -- print locationList

    -- Filter records by date if required
    now <- getCurrentTime
    let listToOutput = case filterOlderThanDays configuration of
            Nothing -> locationList
            Just x -> GL.filterOlderThan filterDate locationList
              where
                filterDate = addDaysUTCTime now ((-1) * x)


    -- let lengthOriginal = Prelude.length locationList
    -- let lengthFilteredByDate = Prelude.length locationListFilteredByDate
    -- print locationListFilteredByDate

    -- Output as KML
    case outputFilename configuration of
        Nothing -> putStrLn $ toXMLString listToOutput
        Just x -> withFile x WriteMode $ \h -> do
            hPutStr h $ toXMLString listToOutput

-- print lengthOriginal
-- print lengthFilteredByDate

-- print "finished"
