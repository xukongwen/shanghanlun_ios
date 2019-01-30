//
//  yuanwenTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/18.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class fangView: UITableViewController {
    
    var bookList = [SH_json]()
    let seacherCon = UISearchController(searchResultsController: nil)
    var fliterList = [SH_json]()
    let db = DataBase.shared
    
    //定义一个section的组
    var sectionsData = [Section_jk]()
    var sectionJk = [SH_fang_final]()
    
    
    //自定义大字体导航栏
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 35)!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFileJson_SH(jsonFile: "SH_all_fang1.json")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "伤寒论方剂"
        
        //导航栏的颜色和返回的颜色
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        //自定义小字体导航栏
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Songti Tc", size: 25)!]
        
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
        
        //搜索栏
//        seacherCon.searchResultsUpdater = self as? UISearchResultsUpdating
//        seacherCon.obscuresBackgroundDuringPresentation = false
//        seacherCon.searchBar.placeholder = "关键词"
        
        
//        navigationItem.searchController = seacherCon
//        definesPresentationContext = true
        
    }
    
    func readFileJson_SH(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_fang_final].self, from: data)
                    var sh_fang_list = [SH_fang_final]()
                    var jk_fang_list = [SH_fang_final]()
                    for i in oneJson {
                        if i.book == "伤寒论" {
                            sh_fang_list.append(i)
                        }
                        if i.book == "金匮" {
                            jk_fang_list.append(i)
                        }
                    }
                    self.sectionsData.append(Section_jk(name: "伤寒方剂", items: sh_fang_list))
                    self.sectionsData.append(Section_jk(name: "金匮方剂", items: jk_fang_list))
                    
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print("fangerr:",jsonErr)
                }
            }
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let love = UITableViewRowAction(style: .normal, title: "收藏") { action, index in
            let myAppdelegate = UIApplication.shared.delegate as! AppDelegate//这个很重要，是获取当前AppDelegate的方法！花了好几天的时间！
            self.saveRow(row: Int64(editActionsForRowAt.row))
            myAppdelegate.lovelistView.updateData()
            
        }
        love.backgroundColor = .orange
        
        return [love]
    }
    
 
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        //print(sectionsData.count)
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count //有多少行
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let fang : SH_fang_final
        
        fang = sectionsData[indexPath.section].items[indexPath.row]
      
        //显示每个cell的内容
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let booklook = fangDetailView()
        booklook.fang = sectionsData[indexPath.section].items[indexPath.row]
        navigationController?.pushViewController(booklook, animated: true)
    }
    
    
    //section header的相关
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sectionsData[section].name
        header.arrowLabel.text = "-"
        header.setCollapsed(sectionsData[section].collapsed)
        
        header.section = section
        header.delegate = self as CollapsibleTableViewHeaderDelegate
        
        return header
    }
    //header的一些设置
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


//点击head后扩展和收缩
extension fangView: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sectionsData[section].collapsed
        
        // Toggle collapse
        sectionsData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}


