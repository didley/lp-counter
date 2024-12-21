//
//  lp_counterApp.swift
//  lp-counter
//
//  Created by Dylan Lamont on 21/12/2024.
//

import SwiftUI
import SwiftData

@main
struct CounterApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: CounterData.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
