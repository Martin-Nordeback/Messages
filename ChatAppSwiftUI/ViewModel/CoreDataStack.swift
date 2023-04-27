//
//  CoreDataStack.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-27.
//

import CoreData

//This class is a singleton class, the sharedCoreData make sure of that
class CoreDataStack {
    
    static let sharedCoreData = CoreDataStack()
    
    private init() {}
    
}
