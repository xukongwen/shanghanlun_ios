//
//  Core_DataManager.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/7.
//  Copyright © 2019 xuhua. All rights reserved.
//

import CoreData

struct CoreDataManger {
    static let shared = CoreDataManger()
    
    let pCon: NSPersistentContainer = {
        let ppCon = NSPersistentContainer(name: "Model")
        ppCon.loadPersistentStores { (StoreDes, err) in
            if let err = err {
                fatalError("Load store failed: \(err)")
            }
        }
        return ppCon
    }()
}
