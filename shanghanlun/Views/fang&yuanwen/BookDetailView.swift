//
//  bookDetailTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/19.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import SelectableTextView
import CoreData

class bookDetailTableViewController: UITableViewController {
    
    
    var fang: SH_book?
    var fangdata: SH_book_data!
    
    let db = DataBase.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        
        title = fang?.header
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.register(BookPageCell.self, forCellReuseIdentifier: "Cell")
        
    
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return fang!.data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        fangdata = fang!.data[indexPath.row]!
    
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fangdata.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.isUserInteractionEnabled = true
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let love = UITableViewRowAction(style: .normal, title: "收藏") { action, index in
            var text : SH_book_data
            text = self.fang!.data[index.row]!
            let bookId: Int = text.ID as! Int
           
            self.saveRow(id: Int16(bookId))
            myAppdelegate.lovelistView.loadsaveData()
            
        }
        love.backgroundColor = .orange
        return [love]
    }
    
    // 储存ID
    func saveRow(id: Int16) {
        
        let managedObjectContext = db.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LoveList", in: managedObjectContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        item.setValue(id, forKey: "row")
        
        do {
            try managedObjectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        myAppdelegate.lovelistView.rowofsection.append(item)
        
    }

    
}

