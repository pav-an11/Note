//
//  NoteApp.swift
//  Note
//
//  Created by students on 04/12/25.
//

import SwiftUI
import SwiftData

@main
struct NoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Listt.self)
        }
    }
}
