//
//  MVVMWidgetDataModel.swift
//  MVVMWidgetExtension
//
//  Created by Vartika Singh on 17/09/21.
//

import WidgetKit

struct MVVMEntry: TimelineEntry {
    let date: Date
    let widgetData: [Data]
    
    static func getMockDataEntry() -> MVVMEntry {
        return MVVMEntry(date: Date(), widgetData: [Data(id: 1, video: true, voteCount: 10, voteAverage: 10, title: "ABC", name: "LMN", releaseDate: "PQR", originalLanguage: "Hindi", originalTitle: "Hello", backdropPath: "", originalName: "Hello Again", firstAirDate: "", adult: false, overview: "", posterPath: "", popularity: 10.0, mediaType: "")])
    }
}
