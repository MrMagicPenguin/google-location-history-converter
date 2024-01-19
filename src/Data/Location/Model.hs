{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE Unsafe #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# OPTIONS_HADDOCK show-extensions #-}

{- |
Module      : Data.Location.Model
Description : Google Takeout Location to KML Converter
Copyright   : (c) 2024 Frederick Price
License     : BSD-3-Clause
Maintainer  : fprice@pricemail.ca
Stability   : experimental
Portability : POSIX

The Rosetta Stone module that defines GIS Location records
-}
module Data.Location.Model (
    -- * Overview
    -- $overview

    -- * Types
    LocationRecord (..),
) where

import Relude

import Data.Aeson

import Data.Time.Clock

-- Record that tracks a location IE a Placemark in KML
data LocationRecord = LocationRecord
    { timestamp :: !UTCTime
    , latitudeE7 :: !Latitude
    , longitudeE7 :: !Longitude
    , altitude :: !(Maybe Int)
    , accuracy :: !(Maybe Int)
    }
    deriving stock (Generic, Show, Eq, Ord)

-- instance ToJSON LocationRecord
instance FromJSON LocationRecord

newtype Latitude = Latitude {
        latitude :: Int
    }
    deriving stock (Generic, Show, Eq, Ord)

-- instance ToSON Latitude
instance FromJSON Latitude

newtype Longitude = Longitude {
        latitude :: Int
    }
    deriving stock (Generic, Show, Eq, Ord)

-- instance ToSON Longitude
instance FromJSON Longitude

{- $overview
 This module holds the data definition for LocationRecord which is a container for typical GIS location information.
-}
