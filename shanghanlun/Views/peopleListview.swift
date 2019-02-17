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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.peopleList = CoreDataManger.shared.fetchPeople()
        
        setpupPlus(selector: #selector(createPeople))
    
        tableView.register(PeopleCell.self, forCellReuseIdentifier: "Cell")
       
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
     
    }

    
    //编辑后重新刷新信息
    func dideditPeople(people: PeopleEntity) {
        
        let row = peopleList.lastIndex(of: people)//这个很重要，是找一个数组里某一个item的位置
        let reloadindexPath = IndexPath(row: row!, section: 0)
        
        tableView.reloadRows(at: [reloadindexPath], with: .middle)//重新装在某一个row的信息
    }
}
