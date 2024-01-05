//
//  SwiftSnapsApp.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftSnapsApp: App {
    var body: some Scene {
        WindowGroup {
             AppScreen(store: Store(initialState: AppFeature.State(), reducer: {
                 AppFeature()
             }))
        }
    }
}
