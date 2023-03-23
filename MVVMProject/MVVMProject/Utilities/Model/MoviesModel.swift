//
//  MoviesModel.swift
//  MVVMProject
//
//  Created by Vartika on 21/01/21.
//

import Foundation

struct Trending: Codable {
    let page: Int?
    let results: [Data]
}

struct Data: Codable {
    var id: Int?
    var video: Bool?
    var voteCount: Int?
    var voteAverage: Float?
    var title: String?
    var name: String?
    var releaseDate: String?
    var originalLanguage: String?
    var originalTitle: String?
    var backdropPath: String?
    var originalName: String?
    var firstAirDate: String?
    var adult: Bool?
    var overview: String?
    var posterPath: String?
    var popularity: Float?
    var mediaType: String?
}

struct MovieData {
    var movie = Data()
    var isFavourite: Bool?
    
    init(id: Int?, video: Bool?, voteCount: Int?, voteAverage: Float?, title: String?, name: String?, releaseDate: String?, originalLanguage: String?, originalTitle: String?, backdropPath: String?, originalName: String?, firstAirDate: String?, adult: Bool?, overview: String?, posterPath: String?, popularity: Float?, mediaType: String?) {
        self.movie.id = id
        self.movie.video = video
        self.movie.voteCount = voteCount
        self.movie.voteAverage = voteAverage
        self.movie.title = title
        self.movie.name = name
        self.movie.releaseDate = releaseDate
        self.movie.originalLanguage = originalLanguage
        self.movie.originalTitle = originalTitle
        self.movie.backdropPath = backdropPath
        self.movie.originalName = originalName
        self.movie.firstAirDate = firstAirDate
        self.movie.adult = adult
        self.movie.overview = overview
        self.movie.posterPath = posterPath
        self.movie.popularity = popularity
        self.movie.mediaType = mediaType
        self.isFavourite = true
    }
}
