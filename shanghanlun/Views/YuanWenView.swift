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
    let searchController = UISearchController(searchResultsController: nil)
    var fliterList = [SH_book]()
    
    //定义一个section的组
    var sectionsData = [Section]()
    var filtersectionData = [Section]()
    var filter_sectionData = [BookDetailSection]()
    
    var newList = [SH_book_data]()
    
    //定义各种section的具体组里的内容
    var sectionXuyan = [SH_book]()
    var sectionPingmai = [SH_book]()
    var sectionZhengzhi = [SH_book]()
    
    // 定义六经的section，是搜索结果用
    var section_Taiyang = [SH_book_data]()
    var section_Yangming = [SH_book_data]()
    var section_ShaoYang = [SH_book_data]()
    var section_Taiyin = [SH_book_data]()
    var section_Shaoyin = [SH_book_data]()
    var section_Jueyin = [SH_book_data]()
    
    // 其他的section
    var section_Other = [SH_book_data]()
    
    
    // 金匮的section
    var sectionJk = [SH_book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        readFileJson_book(jsonFile: "SH_book.json")
        readFileJson_jk_book(jsonFile: "SH_jk_book.json")

        navigationItem.title = "伤寒论与金匮要略原文"
        
        
        //搜索栏
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "关键词"
        
        
        navigationItem.searchController = searchController
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
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmputy()
    }
   
    func fliterContentforSearcheText(_ searchText: String, scope: String = "All"){
        
        
        // 再次搜索时清空
        section_Taiyang = []
        section_ShaoYang = []
        section_Yangming = []
        section_Jueyin = []
        section_Shaoyin = []
        section_Taiyin = []
        section_Other = []
        newList = []
        
        // 查关键词
        bookList.forEach { (book) in
            book.data.forEach({ (data) in
                if (data?.text?.contains(searchText))! {
                    newList.append(data!)
                }
            })
            
        }
        

        // 分六经
        newList.forEach { (data) in
            if data.ID! <= 178 {
                section_Taiyang.append(data)
            } else if data.ID! > 178 && data.ID! <= 262 {
                section_Yangming.append(data)
            } else if data.ID! > 262 && data.ID! <= 272 {
                section_ShaoYang.append(data)
            } else if data.ID! > 272 && data.ID! <= 280 {
                section_Taiyang.append(data)
            } else if data.ID! > 280 && data.ID! <= 325 {
                section_Shaoyin.append(data)
            } else if data.ID! > 325 && data.ID! <= 381 {
                section_Jueyin.append(data)
            }
            else {
                section_Other.append(data)
            }
        }
        
        
        // 设置section
        filter_sectionData = [
            BookDetailSection(name: "太阳:\(section_Taiyang.count)", items: section_Taiyang),
            BookDetailSection(name: "阳明:\(section_Yangming.count)", items: section_Yangming),
            BookDetailSection(name: "少阳:\(section_ShaoYang.count)", items: section_ShaoYang),
            BookDetailSection(name: "太阴:\(section_Taiyin.count)", items: section_Taiyin),
            BookDetailSection(name: "少阴:\(section_Shaoyin.count)", items: section_Shaoyin),
            BookDetailSection(name: "厥阴:\(section_Jueyin.count)", items: section_Jueyin),
            BookDetailSection(name: "其他:\(section_Other.count)", items: section_Other)
            
        ]
       
        
        tableView.reloadData()
    }
    
    
    
    
    
    //下面这个必须给注释掉，否则啥也出不来，因为return0！
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
        let fang : SH_book_data
        let book: SH_book
     
        //搜索过滤
        if isFiltering() {
           
            fang = filter_sectionData[indexPath.section].items[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = fang.text
            cell.isUserInteractionEnabled = false
        } else {
          
            book = sectionsData[indexPath.section].items[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = book.header
        }
        
       
     
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isFiltering() {
            
            let booklook = bookDetailTableViewController()
            booklook.fang = filtersectionData[indexPath.section].items[indexPath.row]
            navigationController?.pushViewController(booklook, animated: true)
            
            
        } else {
            
            let booklook = bookDetailTableViewController()
            booklook.fang = sectionsData[indexPath.section].items[indexPath.row]
            navigationController?.pushViewController(booklook, animated: true)
            
        }
       
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
  
        // 隐藏没有内容的section
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

extension yuanwenTableViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        //fliterContentforSearcheText(searchController.searchBar.text!, scope: scope)
        
        fliterContentforSearcheText(searchController.searchBar.text!)
    }
}

