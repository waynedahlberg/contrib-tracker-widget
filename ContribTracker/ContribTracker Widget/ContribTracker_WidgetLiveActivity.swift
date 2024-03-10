//
//  ContribTracker_WidgetLiveActivity.swift
//  ContribTracker Widget
//
//  Created by Wayne Dahlberg on 3/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ContribTracker_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ContribTracker_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ContribTracker_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ContribTracker_WidgetAttributes {
    fileprivate static var preview: ContribTracker_WidgetAttributes {
        ContribTracker_WidgetAttributes(name: "World")
    }
}

extension ContribTracker_WidgetAttributes.ContentState {
    fileprivate static var smiley: ContribTracker_WidgetAttributes.ContentState {
        ContribTracker_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ContribTracker_WidgetAttributes.ContentState {
         ContribTracker_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ContribTracker_WidgetAttributes.preview) {
   ContribTracker_WidgetLiveActivity()
} contentStates: {
    ContribTracker_WidgetAttributes.ContentState.smiley
    ContribTracker_WidgetAttributes.ContentState.starEyes
}
