//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by 김종원 on 2020/11/01.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
