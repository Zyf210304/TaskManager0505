//
//  TaskManager0505App.swift
//  TaskManager0505
//
//  Created by 张亚飞 on 2022/5/5.
//

import SwiftUI

@main
struct TaskManager0505App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
