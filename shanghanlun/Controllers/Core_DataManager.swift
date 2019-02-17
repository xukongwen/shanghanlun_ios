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
    
    func fetchPeople() -> [PeopleEntity] {
        
        let context = pCon.viewContext
        
        let fetchRe = NSFetchRequest<PeopleEntity>(entityName: "PeopleEntity")//<>里面是自动生成的coredata里的entity，如果没有就写一个，然后按cmd进入
        
        do {
            let peoples = try context.fetch(fetchRe)
            
            return peoples

        } catch let fetchErr {
            print("fetcherr: \(fetchErr)")
            return []
        }
    }
    
    func createDocetor(doctorName: String, illdate: Date, people: PeopleEntity, illType: String) -> DoctorEntity? {
        let context = pCon.viewContext
        
      
        let doctor = NSEntityDescription.insertNewObject(forEntityName: "DoctorEntity", into: context) as! DoctorEntity
        
        doctor.people = people
        doctor.type = illType
        
        doctor.setValue(doctorName, forKey: "name")
        
     
        
        let zheng = NSEntityDescription.insertNewObject(forEntityName: "ZhengEntity", into: context) as! ZhengEntity
        
        zheng.yinyang = "yin"
        zheng.illdate = illdate
       

        //zheng.setValue("yin", forKey: "yinyang")
        
        doctor.docinfo = zheng
        
        do {
            try context.save()
            //return doctor
            
        } catch let err {
            print("save doctor err:", err)
        }
        
        
       return doctor
    }
}
