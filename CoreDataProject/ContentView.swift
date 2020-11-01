//
//  ContentView.swift
//  CoreDataProject
//
//  Created by 김종원 on 2020/10/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedFirstName)")
            }
            Button(action: {
                let taylor = Singer(context: self.viewContext)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.viewContext)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.viewContext)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.viewContext.save()
            }, label: {
                Text("Add")
            })
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
