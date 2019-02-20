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
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFileJson_SH(jsonFile: "SH_all_fang1.json")
    
        navigationItem.title = "伤寒论方剂"

        
    }
    
    // 读取json并且规划section
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
                  
                    var jk_fang_list = [SH_fang_final]()
                    var sh_fang_taiyang = [SH_fang_final]()
                    var sh_fang_yangming = [SH_fang_final]()
                    var sh_fang_shaoyang = [SH_fang_final]()
                    var sh_fang_taiyin = [SH_fang_final]()
                    var sh_fang_shaoyin = [SH_fang_final]()
                    var sh_fang_jueyin = [SH_fang_final]()
                    var sh_fang_huoluan = [SH_fang_final]()
                    var sh_fang_yinyang = [SH_fang_final]()
                    for i in oneJson {
                        if i.jing == "太阳" {
                            sh_fang_taiyang.append(i)
                        }
                        if i.jing == "阳明" {
                            sh_fang_yangming.append(i)
                        }
                        if i.jing == "少阳" {
                            sh_fang_shaoyang.append(i)
                        }
                        if i.jing == "太阴" {
                            sh_fang_taiyin.append(i)
                        }
                        if i.jing == "少阴" {
                            sh_fang_shaoyin.append(i)
                        }
                        if i.jing == "厥阴" {
                            sh_fang_jueyin.append(i)
                        }
                        if i.yinyang == "霍乱" {
                            sh_fang_huoluan.append(i)
                        }
                        if i.yinyang == "阴阳" {
                            sh_fang_yinyang.append(i)
                        }
                        if i.book == "金匮" {
                            jk_fang_list.append(i)
                        }
                    }
                 
                    self.sectionsData.append(Section_jk(name: "伤寒太阳病方剂 凡\(sh_fang_taiyang.count)方", items: sh_fang_taiyang))
                    self.sectionsData.append(Section_jk(name: "伤寒阳明病方剂 凡\(sh_fang_yangming.count)方", items: sh_fang_yangming))
                    self.sectionsData.append(Section_jk(name: "伤寒少阳病方剂 凡\(sh_fang_shaoyang.count)方", items: sh_fang_shaoyang))
                    self.sectionsData.append(Section_jk(name: "伤寒太阴病方剂 凡\(sh_fang_taiyin.count)方", items: sh_fang_taiyin))
                    self.sectionsData.append(Section_jk(name: "伤寒少阴病方剂 凡\(sh_fang_shaoyin.count)方", items: sh_fang_shaoyin))
                    self.sectionsData.append(Section_jk(name: "伤寒厥阴病方剂 凡\(sh_fang_jueyin.count)方", items: sh_fang_jueyin))
                    self.sectionsData.append(Section_jk(name: "伤寒霍乱病方剂 凡\(sh_fang_huoluan.count)方", items: sh_fang_huoluan))
                    self.sectionsData.append(Section_jk(name: "伤寒阴阳易差后劳复病方剂 凡\(sh_fang_yinyang.count)方", items: sh_fang_yinyang))
                    self.sectionsData.append(Section_jk(name: "金匮方剂 凡\(jk_fang_list.count)方", items: jk_fang_list))
                    
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print("fangerr:",jsonErr)
                }
            }
            
            }.resume()
    }
    
    
    //===========收藏==================
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let love = UITableViewRowAction(style: .normal, title: "收藏") { action, index in
            let myAppdelegate = UIApplication.shared.delegate as! AppDelegate//这个很重要，是获取当前AppDelegate的方法！花了好几天的时间！
            
            let fang : SH_fang_final
            fang = self.sectionsData[editActionsForRowAt.section].items[editActionsForRowAt.row]
            
            
            let fangId = fang.ID
          
            self.saveRow(id: Int16(fangId))
            myAppdelegate.lovelistView.updateData()
            print("name:",fang.name, "id:",fangId)
            print("选中的row",editActionsForRowAt.row)
            
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
    
    
    // 储存ID
    func saveRow(id: Int16) {
       
        let managedObjectContext = db.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LoveList", in: managedObjectContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        item.setValue(id, forKey: "id")
       
        do {
            try managedObjectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        
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


