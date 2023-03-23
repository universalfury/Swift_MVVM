//
//  MediumWidget.swift
//  MVVMProject
//
//  Created by Vartika Singh on 17/09/21.
//

import SwiftUI
import WidgetKit

struct MediumWidget: View {
    
    private var movieData: [Data]
    
    init(_movieData: [Data]) {
        self.movieData = _movieData
    }
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            ForEach(movieData, id: \.id) { movie in
                ZStack {
                    Color.yellow
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top, spacing: 10) {
                            if movie.name != nil && movie.name != "" {
                                Text(String(movie.name!)).font(Font.system(size: 20, weight: .bold)).textCase(.uppercase).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                            } else {
                                Text(String(movie.title!)).font(Font.system(size: 20, weight: .bold)).textCase(.uppercase).foregroundColor(.white).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                            }
                            
                            Text(String(movie.voteAverage!)).font(Font.system(size: 18, weight: .semibold)).foregroundColor(.white).multilineTextAlignment(.trailing).frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing).frame(width: 60.0)
                        }
                    }
                }
            }
        }
        .widgetURL(URL(string: "myapp://link"))
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(_movieData: [Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: ""), Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: ""), Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: ""), Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: ""), Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: "")]).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
