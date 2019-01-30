//
//  BaseTableCon.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BaseTableCon<T:UITableViewCell> : UITableViewController {
    
    let cellID = "cellID"
    var items = [Any]()
    var fanglist = [SH_json]()
    var sectionData = [Section_jk]()
    let db = DataBase.shared
    
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "伤寒论汤剂"
        
        //导航栏的颜色和返回的颜色
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        //自定义小字体导航栏
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
   
        tableView.register(T.self, forCellReuseIdentifier: cellID)
        
        
    }
    
   
  
    
    //===============收藏==========
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let love = UITableViewRowAction(style: .normal, title: "收藏") { action, index in
            let myAppdelegate = UIApplication.shared.delegate as! AppDelegate//这个很重要，是获取当前AppDelegate的方法！花了好几天的时间！
            self.saveRow(row: Int64(editActionsForRowAt.row))
            myAppdelegate.lovelistView.updateData()
            
        }
        love.backgroundColor = .orange
        
        return [love]
    }
    
    
    
    //============section number============
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print(sectionData.count)
        return sectionData.count
    }
    
    
    //===============Row number==========
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].collapsed ? 0 : sectionData[section].items.count
    }
    
    
    //===============cell=================
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseCell
        let fang : SH_json
        //fang = sectionData[indexPath.section].items[indexPath.row]
        
        //cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        //cell.detailTextLabel?.font = UIFont.init(name: "STSong", size: 14)
        //cell.item = self.items[indexPath.row]
        return cell
    }
    
    
    //=============selected=================
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fanglook = fangDetailView()
        fanglook.fang = sectionData[indexPath.section].items[indexPath.row]
        navigationController?.pushViewController(fanglook, animated: true)
    }
    //==================header========
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sectionData[section].name
        header.arrowLabel.text = "-"
        header.setCollapsed(sectionData[section].collapsed)
        
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        
        return header
    }
    //====================header的一些设置============
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func saveRow(row: Int64) {
        //步骤一：获取总代理和托管对象总管
        let managedObjectContext = db.persistentContainer.viewContext
        //步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "LoveList", in: managedObjectContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        //步骤三：保存文本框中的值到person
        item.setValue(row, forKey: "row")
        //步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObjectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        //步骤五：保存到数组中，更新UI
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        myAppdelegate.lovelistView.rowofsection.append(item)
       
    }
  
}


//===============header 收起============
extension BaseTableCon: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sectionData[section].collapsed
        
        // Toggle collapse
        sectionData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
