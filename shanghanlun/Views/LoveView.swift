//
//  LoveView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class LoveView: UITableViewController {
    //收藏列表
    var loveList = [SH_fang_final]()
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]
    
    let db = DataBase.shared
    var rowofsection: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        loveList = myAppdelegate.fanglist

        title = "收藏"
    }
    
    func updateData(){
        tableView.reloadData()
    }
    
    
    //从新打开程序时读取本地文件
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let result = selectAll() {
            rowofsection = result
            tableView.reloadData()
        }
    }
    
    
    //============取消收藏================
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let love = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            self.deleteName(index: editActionsForRowAt.row)
            tableView.deleteRows(at: [editActionsForRowAt], with: .fade)//这个带动画而且不用update！
           
        }
        love.backgroundColor = .red
        
        return [love]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowofsection.count
    }
    
    //===============cell=================
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let id: Int16 = rowofsection[indexPath.row].value(forKey: "id") as! Int16
        let okid = Int(id)
   
        let fang = loveList[okid]
        
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        
        return cell
    }
    //=========点击显示======================
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fanglook = fangDetailView()

        let id: Int16 = rowofsection[indexPath.row].value(forKey: "id") as! Int16
        let okid = Int(id)
       
        fanglook.fang = loveList[okid]
        navigationController?.pushViewController(fanglook, animated: true)
    }
    
    
    //读取数据
    func selectAll() -> [NSManagedObject]? {
       
        let managedObjectContext = db.persistentContainer.viewContext
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoveList")
      
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            return fetchedResults
        } catch {
            fatalError("获取失败")
        }
    }
    
    
    //删除数据
    func deleteName(index: Int) {
        
        let managedObjectContext = db.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoveList")
       
        do {
            if let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                
                managedObjectContext.delete(fetchedResults[index])
                try managedObjectContext.save()
               
                rowofsection.remove(at: index)
               
            } else {
                print("no such fang")
            }
        } catch {
            fatalError("删除失败")
        }
    }
}


