//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by 김종원 on 2020/10/31.
//

import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
