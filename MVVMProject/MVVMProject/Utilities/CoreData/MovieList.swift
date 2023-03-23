//
//  MovieList.swift
//  MVVMProject
//
//  Created by Vartika on 02/03/21.
//

import Foundation

public class MovieList: NSObject, NSCoding {
    
    public var favMovieList: [FavouriteMovieData] = []
    enum Key:String {
        case movieList = "movieList"
    }
    
    init(ranges: [FavouriteMovieData]) {
        self.favMovieList = ranges
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(favMovieList, forKey: Key.movieList.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mRanges = aDecoder.decodeObject(forKey: Key.movieList.rawValue) as! [FavouriteMovieData]
        self.init(ranges: mRanges)
    }
}

public class FavouriteMovieData: NSObject, NSCoding {
    public var id: Int = 0
    public var video: Bool = false
    public var voteCount: Int = 0
    public var voteAverage: Float = 0.0
    public var title: String = ""
    public var name: String = ""
    public var releaseDate: String = ""
    public var originalLanguage: String = ""
    public var originalTitle: String = ""
    public var backdropPath: String = ""
    public var originalName: String = ""
    public var firstAirDate: String = ""
    public var adult: Bool = false
    public var overview: String = ""
    public var posterPath: String = ""
    public var popularity: Float = 0.0
    public var mediaType: String = ""
    
    enum Key:String {
        case id = "id"
        case video = "video"
        case voteCount = "voteCount"
        case voteAverage = "voteAverage"
        case title = "title"
        case name = "name"
        case releaseDate = "releaseDate"
        case originalLanguage = "originalLanguage"
        case originalTitle = "originalTitle"
        case firstAirDate = "firstAirDate"
        case adult = "adult"
        case overview = "overview"
        case posterPath = "posterPath"
        case popularity = "popularity"
        case mediaType = "mediaType"
    }
    
    init(movie: Data) {
        self.id = movie.id ?? 0
        self.video = movie.video ?? false
        self.voteCount  = movie.voteCount ?? 0
        self.voteAverage = movie.voteAverage ?? 0.0
        self.title = movie.title ?? ""
        self.name  = movie.name ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle  = movie.originalTitle ?? ""
        self.firstAirDate = movie.firstAirDate ?? ""
        self.adult = movie.adult ?? false
        self.overview  = movie.overview ?? ""
        self.posterPath = movie.posterPath ?? ""
        self.popularity = movie.popularity ?? 0.0
        self.mediaType  = movie.mediaType ?? ""
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Key.id.rawValue)
        aCoder.encode(video, forKey: Key.video.rawValue)
        aCoder.encode(voteCount, forKey: Key.voteCount.rawValue)
        aCoder.encode(voteAverage, forKey: Key.voteAverage.rawValue)
        aCoder.encode(title, forKey: Key.title.rawValue)
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(releaseDate, forKey: Key.releaseDate.rawValue)
        aCoder.encode(originalLanguage, forKey: Key.originalLanguage.rawValue)
        aCoder.encode(originalTitle, forKey: Key.originalTitle.rawValue)
        aCoder.encode(firstAirDate, forKey: Key.firstAirDate.rawValue)
        aCoder.encode(adult, forKey: Key.adult.rawValue)
        aCoder.encode(overview, forKey: Key.overview.rawValue)
        aCoder.encode(posterPath, forKey: Key.posterPath.rawValue)
        aCoder.encode(popularity, forKey: Key.popularity.rawValue)
        aCoder.encode(mediaType, forKey: Key.mediaType.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
//        let mid = aDecoder.decodeInt32(forKey: Key.id.rawValue)
//        let mvideo = aDecoder.decodeInt32(forKey: Key.video.rawValue)
//        
        self.init()
    }
}
