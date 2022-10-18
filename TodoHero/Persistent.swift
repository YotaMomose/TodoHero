//
//  Persistent.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    
    
    init() {
        container = NSPersistentContainer(name: "TodoHero")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error\(error)")
            }
        })
    }
}
