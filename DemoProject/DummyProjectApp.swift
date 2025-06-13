//
//  DummyProjectApp.swift
//  DemoProject
//
//  Created by Arun Kumar  on 12/06/25.
//

import SwiftUI

@main
struct DummyProjectApp: App {
    
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .colorScheme(systemColorScheme == .light ? .light : .dark)
                .accentColor(.green)
        }
    }
}
