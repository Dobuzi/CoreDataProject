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
    
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var candyNameFilter = "M"

    var body: some View {
        VStack {
            FilteredList(filterKey: "name", filterCondition: Condition.beginsWith, filterValue: candyNameFilter) { (candy: Candy) in
                Text("\(candy.wrappedName) @\(candy.origin?.shortName ?? "Unknown")")
            }
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button(action: {
                let candy1 = Candy(context: self.viewContext)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.viewContext)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: self.viewContext)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.viewContext)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: self.viewContext)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.viewContext)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: self.viewContext)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.viewContext)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.viewContext.save()
            }, label: {
                Text("Add")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
