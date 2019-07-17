//
//  DatabaseManager.swift
//  Close
//
//  Created by User on 7/24/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import CoreData

protocol PersistantProtocol {
    func create(_ entityName: String, _ parameters: Dictionary<String, Any>)
    func read(_ entityName: String, _ predicates: Dictionary<String, Any>)
    func update(_ entityName: String, _ predicates: Dictionary<String, Any>, _ parameters: Dictionary<String, Any>)
    func delete(_ entityName: String, _ predicates: Dictionary<String, Any>)
}

class DatabaseManager {
    
    static let shared = DatabaseManager()

    private let backgroundContext: NSManagedObjectContext
    private let foregroundContext: NSManagedObjectContext
    
    private init(){
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        foregroundContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    func create(_ entityName: String, _ parameters: Dictionary<String, Any>){
        try? foregroundContext.apply{
            NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityName, in: $0)!, insertInto: $0).apply{ entity in
                parameters.forEach{entity.setValue($0.value, forKey: $0.key)}
            }
        }.save()
    }
    
    func createAsync(_ entityName: String, _ parameters: Dictionary<String, Any>){
        try? backgroundContext.apply{
            NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityName, in: $0)!, insertInto: $0).apply{ entity in
                parameters.forEach{entity.setValue($0.value, forKey: $0.key)}
            }
            }.save()
    }
    
    func readBlocking(_ entityName: String, _ parameters: Dictionary<String, Any>){
        try? foregroundContext.apply{
            NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityName, in: $0)!, insertInto: $0).apply{ entity in
                parameters.forEach{entity.setValue($0.value, forKey: $0.key)}
            }
            }.save()
    }
    
    func readAsync(_ entityName: String, _ parameters: Dictionary<String, Any>){
        try? backgroundContext.apply{
            NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityName, in: $0)!, insertInto: $0).apply{ entity in
                parameters.forEach{entity.setValue($0.value, forKey: $0.key)}
            }
            }.save()
    }
}

class Persistant: PersistantProtocol {
    
    private let context: NSManagedObjectContext
    
    private let isBackgroud: Bool
    
    private init(_ context: NSManagedObjectContext,_ isBackgroud: Bool){
       self.context = context
       self.isBackgroud = isBackgroud
    }
    
    func create(_ entityName: String, _ parameters: Dictionary<String, Any>) {
        try? context.apply{
            NSManagedObject(entity: NSEntityDescription.entity(forEntityName: entityName, in: $0)!, insertInto: $0).apply{ entity in
                parameters.forEach{entity.setValue($0.value, forKey: $0.key)}
            }
            }.save()
    }
    
    func read(_ entityName: String, _ predicates: Dictionary<String, Any>) {
        NotificationCenter.default.addObserver(forName: Notification.Name("sdf"), object: nil, queue: nil) { not in
            
        }
    }
    
    func update(_ entityName: String, _ predicates: Dictionary<String, Any>, _ parameters: Dictionary<String, Any>) {
        
    }
    
    func delete(_ entityName: String, _ predicates: Dictionary<String, Any>) {
        
    }
    
    
}
