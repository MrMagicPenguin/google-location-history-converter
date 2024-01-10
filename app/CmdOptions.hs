{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE Unsafe #-}

module CmdOptions (getConfiguration, Config (..)) where

import Options.Applicative

data Config = Config
    { inputFilename :: !String
    , outputFilename :: !(Maybe String)
    , filterOlderThanDays :: !(Maybe Integer)
    }

config :: Parser Config
config =
    Config
        <$> strOption
            ( long "inputFile"
                <> metavar "FILENAME"
                <> help "Input filename - something like takeout.tgz"
            )
        <*> optional
            ( strOption
                ( long "outputFile"
                    <> metavar "FILENAME"
                    <> help "Output file name - something like takeout.kml"
                )
            )
        <*> optional
            ( option
                auto
                ( long "filterMoreThanDays"
                    <> help "Filter lecation records so they are no older than n days"
                    -- <> showDefault
                    -- <> value 14
                    <> metavar "INT"
                )
            )

getConfiguration :: IO Config
getConfiguration = execParser opts
  where
    opts =
        info
            (config <**> helper)
            ( fullDesc
                <> progDesc "Convert Google Location data in .tgz format to KML"
                <> header "Convert Google Location Data"
            )
