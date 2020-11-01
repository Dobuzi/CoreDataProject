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
    
    init(filterKey: String, filterCondition: Condition, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        var condition: String {
            switch filterCondition {
            case .beginsWith:
                return "BEGINSWITH"
            case .beginsWithC:
                return "BEGINSWITH[c]"
            case .equals:
                return "=="
            case .bigger:
                return ">"
            case .smaller:
                return "<"
            case .like:
                return "like"
            case .between:
                return "between"
            case .inArray:
                return "in"
            }

        }
        self.fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(key: filterKey, ascending: true)], predicate: NSPredicate(format: "\(filterKey) \(condition) '\(filterValue)'"))
        self.content = content
    }
}

enum Condition {
    case beginsWith, beginsWithC
    case equals, bigger, smaller
    case like, between, inArray
    
}
