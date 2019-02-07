//
//  yuanwenTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/18.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

//伤寒原文部分


class yuanwenTableViewController: UITableViewController {
    
    var bookList = [SH_book]()
    let seacherCon = UISearchController(searchResultsController: nil)
    var fliterList = [SH_book]()
    
    //定义一个section的组
    var sectionsData = [Section]()
    
    //定义各种section的具体组里的内容
    var sectionXuyan = [SH_book]()
    var sectionPingmai = [SH_book]()
    var sectionZhengzhi = [SH_book]()
    
    var sectionJk = [SH_book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFileJson_book(jsonFile: "SH_book.json")
        readFileJson_jk_book(jsonFile: "SH_jk_book.json")

        navigationItem.title = "伤寒论原文"
        
        
        //搜索栏
        seacherCon.searchResultsUpdater = self as? UISearchResultsUpdating
        seacherCon.obscuresBackgroundDuringPresentation = false
        seacherCon.searchBar.placeholder = "关键词"
        
        
        navigationItem.searchController = seacherCon
        definesPresentationContext = true
        
    }
    
    
    
    func readFileJson_book(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_book].self, from: data)
                    
                    self.bookList = oneJson
                    //制作section的分类，可以完全手动
                    for i in oneJson[0...3] {
                        self.sectionXuyan.append(i)
                    }
                    for i in oneJson[4...7] {
                        self.sectionPingmai.append(i)
                    }
                    for i in oneJson[8...25] {
                        self.sectionZhengzhi.append(i)
                    }
                    self.sectionXuyan.append(oneJson[26])
                    //制作sections
                    self.sectionsData = [
                        Section(name: "序言", items: self.sectionXuyan),
                        Section(name: "平脉法", items: self.sectionPingmai),
                        Section(name: "六经辨证", items: self.sectionZhengzhi)
                        
                    ]
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }
    
    func readFileJson_jk_book(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_book].self, from: data)
                    
            
                    self.sectionsData.append(Section(name: "金匮要略", items: oneJson))
                    //print(self.sectionsData)
                    self.tableView.reloadData()
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }
    
    //搜索相关func
    func searchBarIsEmputy () -> Bool{
        return seacherCon.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return seacherCon.isActive && !searchBarIsEmputy()
    }
    
    //    func fliterContentforSearcheText(_ searchText: String, scope: String = "All"){
    //        fliterList = bookList.filter({( fang : SH_book) -> Bool in
    //            return (fang.header?.lowercased().contains(searchText.lowercased()))!
    //        })
    //        tableView.reloadData()
    //    }
    
    
    
    
    
    // MARK: - Table view data source
    //我操下面这个必须给注释掉，否则啥也出不来，因为return0！
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print(sectionsData)
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return fliterList.count
        }
        
        //print(bookList)
        
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count //有多少行
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let fang : SH_book
        //print("open")
        //搜索过滤
        if isFiltering() {
            fang = fliterList[indexPath.row]
        } else {
            fang = sectionsData[indexPath.section].items[indexPath.row]
        }
        
        //显示每个cell的内容
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fang.header
        //print(fang.section!)
        //cell.detailTextLabel?.text = fang.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        //cell.detailTextLabel?.font = UIFont.init(name: "STSong", size: 14)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let booklook = bookDetailTableViewController()
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

    
}


//点击head后扩展和收缩
extension yuanwenTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sectionsData[section].collapsed
        
        // Toggle collapse
        sectionsData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

