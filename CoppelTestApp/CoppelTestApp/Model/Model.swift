//
//  Model.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import Foundation

struct allMovies : Codable{
    var iPages          :Int?
    var arrMovies       :[movieSection]?
    var iTotalResults   :Int?
    var iTotalPages     :Int?
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        iPages           =  try (container.decodeIfPresent(Int.self, forKey: .iPages))
        arrMovies        =  try (container.decodeIfPresent([movieSection].self, forKey: .arrMovies))
        iTotalResults    =  try (container.decodeIfPresent(Int.self, forKey: .iTotalResults))
        iTotalPages      =  try (container.decodeIfPresent(Int.self, forKey: .iTotalPages))
    }
    
    private enum CodingKeys : String, CodingKey{
        case arrMovies          = "results"
        case iPages             = "page"
        case iTotalResults      = "total_results"
        case iTotalPages        = "total_pages"
    }
}

struct movieSection : Codable{
    var strPoster_path                 : String?
    var bAdult                         : Bool?
    var strOverview                    : String?
    var strDate                        : String?
    var arrGenre                       : [Int]?
    var iId                            : Int?
    var strOriginalTitle               : String?
    var strOriginalLanguage            : String?
    var strTitle                       : String?
    var strBackdrop                    : String?
    var fPopularity                    : Float?
    var iVoteCount                     : Int?
    var bVideo                         : Bool?
    var iVoteAverage                   : Float?
    var strfirstAirDate                :String?
    var arrOriginCountry               :[String]?
    var strName                        :String?
    var strOriginalName                :String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strPoster_path                 =  try (container.decodeIfPresent(String.self, forKey: .strPoster_path))
        bAdult                         =  try (container.decodeIfPresent(Bool.self, forKey: .bAdult))
        strOverview                    =  try (container.decodeIfPresent(String.self, forKey: .strOverview))
        strDate                        =  try (container.decodeIfPresent(String.self, forKey: .strDate))
        arrGenre                       =  try (container.decodeIfPresent([Int].self, forKey: .arrGenre))
        iId                            =  try (container.decodeIfPresent(Int.self, forKey: .iId))
        strOriginalTitle               =  try (container.decodeIfPresent(String.self, forKey: .strOriginalTitle))
        strOriginalLanguage            =  try (container.decodeIfPresent(String.self, forKey: .strOriginalLanguage))
        strTitle                       =  try (container.decodeIfPresent(String.self, forKey: .strTitle))
        strBackdrop                    =  try (container.decodeIfPresent(String.self, forKey: .strBackdrop))
        fPopularity                    =  try (container.decodeIfPresent(Float.self, forKey: .fPopularity))
        iVoteCount                     =  try (container.decodeIfPresent(Int.self, forKey: .iVoteCount))
        bVideo                         =  try (container.decodeIfPresent(Bool.self, forKey: .bVideo))
        iVoteAverage                   =  try (container.decodeIfPresent(Float.self, forKey: .iVoteAverage))
        strfirstAirDate                =  try (container.decodeIfPresent(String.self, forKey: .strfirstAirDate))
        arrOriginCountry               =  try (container.decodeIfPresent([String].self, forKey: .arrOriginCountry))
        strName                        =  try (container.decodeIfPresent(String.self, forKey: .strName))
        strOriginalName                =  try (container.decodeIfPresent(String.self, forKey: .strOriginalName))
        
    }
    
    private enum CodingKeys : String, CodingKey{
        case strPoster_path                 = "poster_path"
        case bAdult                         = "adult"
        case strOverview                    = "overview"
        case strDate                        = "release_date"
        case strfirstAirDate                = "first_air_date"
        case arrOriginCountry               = "origin_country"
        case arrGenre                       = "genre_ids"
        case iId                            = "id"
        case strOriginalTitle               = "original_title"
        case strOriginalLanguage            = "original_language"
        case strTitle                       = "title"
        case strBackdrop                    = "backdrop_path"
        case fPopularity                    = "popularity"
        case iVoteCount                     = "vote_count"
        case bVideo                         = "video"
        case iVoteAverage                   = "vote_average"
        case strName                        = "name"
        case strOriginalName                = "original_name"
    }
}


struct apiKey : Codable{
    var bSuccess       :Bool?
    var strExpires     :String?
    var strToken       :String?
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        bSuccess       =  try (container.decodeIfPresent(Bool.self, forKey: .bSuccess))
        strExpires     =  try (container.decodeIfPresent(String.self, forKey: .strExpires))
        strToken       =  try (container.decodeIfPresent(String.self, forKey: .strToken))
    }
    
    private enum CodingKeys : String, CodingKey{
        case bSuccess       = "success"
        case strExpires     = "expires_at"
        case strToken       = "request_token"
    }
}

struct sessionNew : Codable{
    var bSuccess       :Bool?
    var strSession     :String?
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        bSuccess        =  try (container.decodeIfPresent(Bool.self, forKey: .bSuccess))
        strSession      =  try (container.decodeIfPresent(String.self, forKey: .strSession))
    }
    
    private enum CodingKeys : String, CodingKey{
        case bSuccess       = "success"
        case strSession     = "session_id"
    }
}
