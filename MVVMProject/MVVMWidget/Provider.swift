//
//  Provider.swift
//  MVVMProject
//
//  Created by Vartika Singh on 17/09/21.
//

import WidgetKit

struct Provider: IntentTimelineProvider {
    
    typealias Entry = MVVMEntry
    let dataModel = MoviesHomeViewModel()
    
    func placeholder(in context: Context) -> MVVMEntry {
        MVVMEntry.getMockDataEntry()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MVVMEntry) -> ()) {
        let entry = MVVMEntry.getMockDataEntry()
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline an hour apart, starting from the current date.
        dataModel.getDataForWidget()
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        let entry = MVVMEntry(date: currentDate, widgetData: dataModel.widgetData )
        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
}
