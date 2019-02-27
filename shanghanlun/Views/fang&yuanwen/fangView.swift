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
    let searchController = UISearchController(searchResultsController: nil)

    var fliterList = [SH_json]()
    let db = DataBase.shared
    var fangallList = [SH_fang_final]()
    var filter_fangallList = [SH_fang_final]()
    
    //定义一个section的组
    var sectionsData = [Section_jk]()
    var filter_sectionData = [Section_jk]()
    var sectionJk = [SH_fang_final]()
    
    let illType : UISegmentedControl = {
        let type = ["方剂","原文"]
        let sc = UISegmentedControl(items: type)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .black
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
   
    func setUI() {
        view.addSubview(illType)
        illType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        illType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        illType.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        illType.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        tableView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
//        tableView.tableFooterView = UIView()

        //setUI()
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "关键词"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        readFileJson_SH(jsonFile: "SH_all_fang1.json")
        navigationItem.title = "伤寒论方与原文"
        
        
        

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
                    self.fangallList = oneJson
                  
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
    
    func searchBarIsEmputy () -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        //let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmputy())
    }
    
    func fliterContentforSearcheText(_ searchText: String){
 
        var jk_fang_list = [SH_fang_final]()
        var sh_fang_taiyang = [SH_fang_final]()
        var sh_fang_yangming = [SH_fang_final]()
        var sh_fang_shaoyang = [SH_fang_final]()
        var sh_fang_taiyin = [SH_fang_final]()
        var sh_fang_shaoyin = [SH_fang_final]()
        var sh_fang_jueyin = [SH_fang_final]()
        var sh_fang_other = [SH_fang_final]()
        filter_fangallList = []
     
        fangallList.forEach { (fang) in
            if fang.name.contains(searchText) {
                filter_fangallList.append(fang)
            }
        }
        
        filter_fangallList.forEach { (fang) in
            if fang.jing == "太阳" {
                sh_fang_taiyang.append(fang)
            } else if fang.jing == "阳明" {
                sh_fang_yangming.append(fang)
            } else if fang.jing == "少阳" {
                sh_fang_shaoyang.append(fang)
            } else
            if fang.jing == "太阴" {
                sh_fang_taiyin.append(fang)
            } else
            if fang.jing == "少阴" {
                sh_fang_shaoyin.append(fang)
            } else
            if fang.jing == "厥阴" {
                sh_fang_jueyin.append(fang)
            } else
            if fang.book == "金匮" {
                jk_fang_list.append(fang)
            } else {
                sh_fang_other.append(fang)
            }
        }
        
        filter_sectionData = [
            Section_jk(name: "太阳:\(sh_fang_taiyang.count)", items: sh_fang_taiyang),
            Section_jk(name: "阳明:\(sh_fang_yangming.count)", items: sh_fang_yangming),
            Section_jk(name: "少阳:\(sh_fang_shaoyang.count)", items: sh_fang_shaoyang),
            Section_jk(name: "太阴:\(sh_fang_taiyin.count)", items: sh_fang_taiyin),
            Section_jk(name: "少阴:\(sh_fang_shaoyin.count)", items: sh_fang_shaoyin),
            Section_jk(name: "厥阴:\(sh_fang_jueyin.count)", items: sh_fang_jueyin),
            Section_jk(name: "金匮:\(jk_fang_list.count)", items: jk_fang_list),
            Section_jk(name: "其他:\(sh_fang_other.count)", items: sh_fang_other)
        ]
        tableView.reloadData()
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
        
        }
        love.backgroundColor = .orange
        return [love]
    }
    
 
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if isFiltering() {
            
            return filter_sectionData.count
        }
       
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filter_sectionData[section].collapsed ? 0 : filter_sectionData[section].items.count
        }
        
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count //有多少行
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let fang : SH_fang_final
        
        if isFiltering() {
           
            fang = filter_sectionData[indexPath.section].items[indexPath.row]
            
        } else {
            fang = sectionsData[indexPath.section].items[indexPath.row]
            
        }

        //显示每个cell的内容
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fang.name
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if isFiltering() {
//            let booklook = fangDetailView()
//            booklook.fang = filter_sectionData[indexPath.section].items[indexPath.row]
//            navigationController?.pushViewController(booklook, animated: true)
//
//        } else {
//            let booklook = fangDetailView()
//            booklook.fang = sectionsData[indexPath.section].items[indexPath.row]
//            navigationController?.pushViewController(booklook, animated: true)
//        }
        
        let booklook = fangDetailView()
        booklook.fang = sectionsData[indexPath.section].items[indexPath.row]
        navigationController?.pushViewController(booklook, animated: true)
        print(navigationController)
        
    }
    
    
    //section header的相关
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        if isFiltering() {
            
            header.titleLabel.text = filter_sectionData[section].name
            header.arrowLabel.text = "-"
            header.setCollapsed(filter_sectionData[section].collapsed)
            
            header.section = section
            header.delegate = self as CollapsibleTableViewHeaderDelegate
            
            return header
            
            
            
        } else {
            header.titleLabel.text = sectionsData[section].name
            header.arrowLabel.text = "-"
            header.setCollapsed(sectionsData[section].collapsed)
            
            header.section = section
            header.delegate = self as CollapsibleTableViewHeaderDelegate
            
            return header
            
        }
        
        
    }
    //header的一些设置
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if isFiltering() {
            
            if filter_sectionData[section].items.count == 0 {
                return 0
            }
            
        }
        
        return 50.0
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

extension fangView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        fliterContentforSearcheText(searchController.searchBar.text!, scope: scope)
//
        fliterContentforSearcheText(searchController.searchBar.text!)
    }
    
    
}


