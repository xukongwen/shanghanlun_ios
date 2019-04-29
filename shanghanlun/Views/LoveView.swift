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
    var fangList = [SH_fang_final]()
    
    var loveBook = [SH_book]()
    var booklist = [SH_book]()
    
    //不同section初始化
    var BooksectionData = [Section]()
    var FangsectionsData = [Section_jk]()
    
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]
    
    let db = DataBase.shared
    var rowofsection: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //读到书和方剂的总表
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        fangList = myAppdelegate.fanglist
        booklist = myAppdelegate.SHbook

        title = "收藏"
        
        loadsaveData()
        self.FangsectionsData.append(Section_jk(name: "经方", items: loveList))
        self.BooksectionData.append(Section(name: "原文", items: loveBook))
    
    }
    
    func updateData(){
        tableView.reloadData()
    }
    
    func loadsaveData(){
        
        if let result = selectAll() {
            rowofsection = result
            loveList.removeAll()
            loveBook.removeAll()
            rowofsection.forEach { (data) in
                
                let n_data : Int16 = data.value(forKey: "id") as! Int16
                let ok_data = Int(n_data)
                
                let b_data : Int16 = data.value(forKey: "row") as! Int16
                let ok_b_data = Int(b_data)
                //print("load:", ok_data)
                
                loveList.append(fangList[ok_data])
                loveBook.append(booklist[ok_b_data])
            
                
            }
            
            tableView.reloadData()
            
//            loveList.forEach { (data) in
//                print("lovelist:", data.name)
//            }
            
        }
    }
    
    
    
    //============取消收藏================
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let love = UITableViewRowAction(style: .normal, title: "删除") { action, index in
            self.deleteName(index: editActionsForRowAt.row)
            self.loveList.remove(at: editActionsForRowAt.row)
            tableView.deleteRows(at: [editActionsForRowAt], with: .fade)//这个带动画而且不用update！
            
        }
        love.backgroundColor = .red
        
        return [love]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return FangsectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loveList.count
    }
    
    //===============cell=================
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let fang = loveList[indexPath.row]
        
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
        cell.detailTextLabel?.font = UIFont.init(name: "Songti Tc", size: 15)
        cell.detailTextLabel?.text = fang.zhengtext
        cell.detailTextLabel?.textColor = .gray
        
        return cell
    }
    //=========点击显示======================
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fanglook = fangDetailView()

        fanglook.fang = loveList[indexPath.row]
        navigationController?.pushViewController(fanglook, animated: true)
    }
    
    //section header的相关
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = FangsectionsData[section].name
        header.arrowLabel.text = "-"
        header.setCollapsed(FangsectionsData[section].collapsed)
        
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        
        return header
     
        
    }
    //header的一些设置
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if FangsectionsData[section].items.count == 0 {
            return 0
        } else {
            return 50
        }
        
       
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
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

extension LoveView: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !FangsectionsData[section].collapsed
        
        // Toggle collapse
        FangsectionsData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
