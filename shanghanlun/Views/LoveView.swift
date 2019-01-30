//
//  LoveView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
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
        print(loveList.count)
        
   
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "收藏"
        
        //导航栏的颜色和返回的颜色
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        //自定义小字体导航栏
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
        
        title = "收藏"
        navigationItem.largeTitleDisplayMode = .automatic
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
        
        let ok: Int64 = rowofsection[indexPath.row].value(forKey: "row") as! Int64
        let ok1 = Int(ok)
        print(ok1)
        
        let fang = loveList[ok1]
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fanglook = fangDetailView()
        
        let ok: Int64 = rowofsection[indexPath.row].value(forKey: "row") as! Int64
        let ok1 = Int(ok)
        
        fanglook.fang = loveList[ok1]
        navigationController?.pushViewController(fanglook, animated: true)
    }
    
    
    //读取数据
    func selectAll() -> [NSManagedObject]? {
        //步骤一：获取总代理和托管对象总管
        let managedObjectContext = db.persistentContainer.viewContext
        //步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoveList")
        //步骤三：执行请求
        do {
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            return fetchedResults
        } catch {
            fatalError("获取失败")
        }
    }
    
    
    //删除数据
    func deleteName(index: Int) {
        //步骤一：获取总代理和托管对象总管
        let managedObjectContext = db.persistentContainer.viewContext
        //步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoveList")
        //步骤三：执行请求
        do {
            if let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                //步骤四：删除联系人
                managedObjectContext.delete(fetchedResults[index])
                try managedObjectContext.save()
                //步骤五：更新数组与UI
                rowofsection.remove(at: index)
                //tableView.reloadData()
            } else {
                print("no such fang")
            }
        } catch {
            fatalError("删除失败")
        }
    }
}


