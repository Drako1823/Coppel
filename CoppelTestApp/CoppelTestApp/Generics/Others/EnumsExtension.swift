//
//  Others.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import Foundation

enum typeMovies: String {
    case apiKey = "authentication/token/new"
    case sessionNew = "authentication/session/new"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case onTv = "tv/on_the_air"
    case airingToday = "tv/airing_today"
}

enum typeDetail: Int {
    case movie = 0
    case tv = 1
}

