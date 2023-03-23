//
//  MVVMWidget.swift
//  MVVMWidget
//
//  Created by Vartika Singh on 17/09/21.
//

import WidgetKit
import SwiftUI
import Intents

struct MVVMWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium, .systemSmall:
            MediumWidget(_movieData: entry.widgetData)
        default:
            fatalError()
        }
    }
}

@main
struct MVVMWidget: Widget {
    let kind: String = "MVVMWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MVVMWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct MVVMWidget_Previews: PreviewProvider {
    static var previews: some View {
        MVVMWidgetEntryView(entry: MVVMEntry.getMockDataEntry())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
