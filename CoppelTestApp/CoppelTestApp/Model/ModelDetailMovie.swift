//
//  ModelDetailMovie.swift
//  coppelTestApp
//
//  Created by El Reymon . on 07/12/22.
//

struct detailMovie : Codable{
    var arrCompanies        :[companiSection]?
    var arrLanguajes        :[languajeSection]?
    var strDate             :String?
    var arrGenres           :[genreSection]?
    var strOverview         :String?
    var strHomepage         :String?
    var bAdult              :Bool?
    var strTitle            :String?
    var strImage            :String?

    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        arrCompanies        =  try (container.decodeIfPresent([companiSection].self, forKey: .arrCompanies))
        arrLanguajes        =  try (container.decodeIfPresent([languajeSection].self, forKey: .arrLanguajes))
        strDate    =  try (container.decodeIfPresent(String.self, forKey: .strDate))
        arrGenres      =  try (container.decodeIfPresent([genreSection].self, forKey: .arrGenres))
        strOverview    =  try (container.decodeIfPresent(String.self, forKey: .strOverview))
        strHomepage    =  try (container.decodeIfPresent(String.self, forKey: .strHomepage))
        bAdult    =  try (container.decodeIfPresent(Bool.self, forKey: .bAdult))
        strTitle    =  try (container.decodeIfPresent(String.self, forKey: .strTitle))
        strImage    =  try (container.decodeIfPresent(String.self, forKey: .strImage))
    }
    
    private enum CodingKeys : String, CodingKey{
        case arrCompanies       = "production_companies"
        case arrLanguajes       = "spoken_languages"
        case strDate            = "release_date"
        case arrGenres          = "genres"
        case strOverview        = "overview"
        case strHomepage        = "homepage"
        case bAdult             = "adult"
        case strTitle           = "original_title"
        case strImage           = "backdrop_path"
    }
}

struct genreSection : Codable{
    var iId                 : Int?
    var strName             :String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iId             =  try (container.decodeIfPresent(Int.self, forKey: .iId))
        strName         =  try (container.decodeIfPresent(String.self, forKey: .strName))
       
    }
    
    private enum CodingKeys : String, CodingKey{
        case iId            = "id"
        case strName        = "name"
    }
}

struct languajeSection : Codable{
    var strEnglishName         :String?
    var strIso                 :String?
    var strName                :String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strEnglishName              =  try (container.decodeIfPresent(String.self, forKey: .strEnglishName))
        strIso                      =  try (container.decodeIfPresent(String.self, forKey: .strIso))
        strName                     =  try (container.decodeIfPresent(String.self, forKey: .strName))

    }
    
    private enum CodingKeys : String, CodingKey{
        case strEnglishName         = "english_name"
        case strIso                 = "iso_639_1"
        case strName                = "name"
    }
}


struct companiSection : Codable{
    var iId            :Int?
    var aLogo          :String?
    var strName        :String?
    var strCountry     :String?
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        iId       =  try (container.decodeIfPresent(Int.self, forKey: .iId))
        aLogo       =  try (container.decodeIfPresent(String.self, forKey: .aLogo))
        strName     =  try (container.decodeIfPresent(String.self, forKey: .strName))
        strCountry       =  try (container.decodeIfPresent(String.self, forKey: .strCountry))
    }
    
    private enum CodingKeys : String, CodingKey{
        case iId            = "id"
        case aLogo          = "logo_path"
        case strName        = "name"
        case strCountry     = "origin_country"
        
        }
    }

