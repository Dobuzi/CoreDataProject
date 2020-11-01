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

    @FetchRequest(
        entity: Wizard.entity(),
        sortDescriptors: [],
        animation: .default)
    private var wizards: FetchedResults<Wizard>
    
    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"),
        animation: .default
    ) private var ships: FetchedResults<Ship>
    
    var body: some View {
        return VStack {
            List {
                ForEach(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown")
                }
            }
            Spacer()
            Button(action: {
                let ship1 = Ship(context: self.viewContext)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.viewContext)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.viewContext)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.viewContext)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
            }, label: {
                Text("Add")
            })
            HStack {
                Button("Clear") {
                    deleteShips(at: IndexSet(0..<ships.count))
                }
                Button("Save") {
                    try? self.viewContext.save()
                }
            }
        }
    }
    
    func deleteShips(at offsets: IndexSet) {
        for offset in offsets {
            let ship = ships[offset]
            viewContext.delete(ship)
        }
        try? viewContext.save()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
