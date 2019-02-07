//
//  test1CreatPeople.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/7.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class PeopleListView: UITableViewController {
    
    var peopleList = [PeopleEntity]()
    
    private func fetchPeoples() {
        
//        let pCon = NSPersistentContainer(name: "Model")
//        pCon.loadPersistentStores { (StoreDes, err) in
//            if let err = err {
//                fatalError("Load store failed: \(err)")
//            }
//        }
//
//        let context = pCon.viewContext
        
        let context = CoreDataManger.shared.pCon.viewContext
        
        let fetchRe = NSFetchRequest<PeopleEntity>(entityName: "PeopleEntity")//<>里面是自动生成的coredata里的entity，如果没有就写一个，然后按cmd进入
        
        do {
            let peoples = try context.fetch(fetchRe)
            
            self.peopleList = peoples
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("fetcherr: \(fetchErr)")
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPeoples()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "创建人", style: .plain, target: self, action: #selector(createPeople))
       
    }
    
    func addPeople(people: PeopleEntity) {
       
        peopleList.append(people)
        
        let newIndexPath = IndexPath(row: peopleList.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    @objc func createPeople() {
        let createPeopleView1 = CreatePeopleView()
        let navCon = UINavigationController(rootViewController: createPeopleView1)
        present(navCon, animated: true, completion: nil)
        
        createPeopleView1.companyCreateCon = self//这个就是把自己交给了另外的view
        
        
        //navigationController?.pushViewController(createPeopleView1, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = peopleList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            let people = self.peopleList[indexPath.row]
            //print(people.name)
            self.peopleList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManger.shared.pCon.viewContext
            context.delete(people)
            
            do {
                try context.save()
            } catch let saveErr {
                print(saveErr)
            }
            
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "编辑") { (_, indexPath) in
            print("editing")
        }
        
        
        return [deleteAction, editAction]
    }
}
