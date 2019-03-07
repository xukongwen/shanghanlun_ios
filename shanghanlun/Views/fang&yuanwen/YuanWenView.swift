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
    
    var items: [CellConfiguratorType] = []
    
    var bookList = [SH_book]()
    let searchController = UISearchController(searchResultsController: nil)
    var fliterList = [SH_book]()
    
    //定义一个section的组
    var sectionsData = [Section]()
    var filtersectionData = [Section]()
    var filter_sectionData = [BookDetailSection]()
    var filter_seach_section = [BookSearcheSection]()
    
    var newList = [SH_book_data]()
    
    //定义各种section的具体组里的内容
    var sectionXuyan = [SH_book]()
    var sectionPingmai = [SH_book]()
    var sectionZhengzhi = [SH_book]()
    var sectionLiuJjing = [SH_book]()
  
    
    // 定义六经的section，是搜索结果用
    var section_cell_Taiyang = [CellConfiguratorType]()
    var section_cell_Yangming = [CellConfiguratorType]()
    var section_cell_Shaoyang = [CellConfiguratorType]()
    var section_cell_Taiyin = [CellConfiguratorType]()
    var section_cell_Shaoyin = [CellConfiguratorType]()
    var section_cell_Jueyin = [CellConfiguratorType]()
    
    // 其他的section
    var section_Other = [SH_book_data]()
    var section_Jinkui = [SH_book_data]()
    var section_cell_other = [CellConfiguratorType]()
    
    
    // 金匮的section
    var sectionJk = [SH_book]()
    var section_cell_jk = [CellConfiguratorType]()

    override func viewDidLoad() {
        super.viewDidLoad()
   
        readFileJson_book(jsonFile: "SH_book.json")

        navigationItem.title = "伤寒论与金匮要略原文"
   
        tableView.tableFooterView = UIView()
        //搜索栏
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "关键词"
        
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        
        
    }
    
    func registerCells() {
//        for cellConfigurator in items {
//            tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
//        }
//
        filter_seach_section.forEach { (bb) in
            for cellConfigurator in bb.newcells {
                tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
            }
        }
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
                    for i in oneJson[8...15] {
                        self.sectionLiuJjing.append(i)
                    }
                    for i in oneJson[16...25] {
                        self.sectionZhengzhi.append(i)
                        }
                    for i in oneJson[27...48] {
                        self.sectionJk.append(i)
                    }
                    self.sectionXuyan.append(oneJson[26])
                    //制作sections
                    self.sectionsData = [
                        Section(name: "序言", items: self.sectionXuyan),
                        Section(name: "平脉法", items: self.sectionPingmai),
                        Section(name: "六经辨证", items: self.sectionLiuJjing),
                        Section(name: "伤寒其他", items: self.sectionZhengzhi),
                        Section(name: "金匮要略", items: self.sectionJk)
                    ]
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

        section_cell_Taiyang = []
        section_cell_Shaoyang = []
        section_cell_Yangming = []
        section_cell_Jueyin = []
        section_cell_Shaoyin = []
        section_cell_Taiyin = []
        section_cell_other = []
        section_cell_jk = []
        
        newList = []
        
        var outputData = [Int]()
        
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
                
                section_cell_Taiyang.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! > 178 && data.ID! <= 262 {
                
                section_cell_Yangming.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! > 262 && data.ID! <= 272 {
                
                section_cell_Shaoyang.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! > 272 && data.ID! <= 280 {
                
                section_cell_Taiyin.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! > 280 && data.ID! <= 325 {
                
                section_cell_Shaoyin.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! > 325 && data.ID! <= 381 {
                
                section_cell_Jueyin.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            } else if data.ID! >= 2000000 { // 金匮
                
                section_cell_jk.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            }
            else {
                
                section_cell_other.append(CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: data.text!)))
            }
        }
        
        outputData = [section_cell_Taiyang.count,
                      section_cell_Yangming.count,
                      section_cell_Shaoyang.count,
                      section_cell_Taiyin.count,
                      section_cell_Shaoyin.count,
                      section_cell_Jueyin.count
        ]
    
        // 设置section
        filter_seach_section = [
            BookSearcheSection(name: "统计图表", newcells: [CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: "根据搜索关键词统计出的六经统计图")),CellConfigurator<ImageTableViewCell>(viewData: ImageCellViewData(image: UIImage(named: "brain")!, data: outputData))]),
            BookSearcheSection(name: "太阳 \(section_cell_Taiyang.count)", newcells: section_cell_Taiyang),
            BookSearcheSection(name: "阳明 \(section_cell_Yangming.count)", newcells: section_cell_Yangming),
            BookSearcheSection(name: "少阳 \(section_cell_Shaoyang.count)", newcells: section_cell_Shaoyang),
            BookSearcheSection(name: "太阴 \(section_cell_Taiyin.count)", newcells: section_cell_Taiyin),
            BookSearcheSection(name: "少阴 \(section_cell_Shaoyin.count)", newcells: section_cell_Shaoyin),
            BookSearcheSection(name: "厥阴 \(section_cell_Jueyin.count)", newcells: section_cell_Jueyin),
            BookSearcheSection(name: "金匮 \(section_cell_jk.count)", newcells: section_cell_jk),
            BookSearcheSection(name: "其他 \(section_cell_other.count)", newcells: section_cell_other)
        ]

        registerCells()
     
        tableView.reloadData()
    }
    
 
    //下面这个必须给注释掉，否则啥也出不来，因为return0！
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if isFiltering() {
        
            return filter_seach_section.count
        }
      
        return sectionsData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
          
            return filter_seach_section[section].collapsed ? 0 : filter_seach_section[section].newcells.count
        }
      
        return sectionsData[section].collapsed ? 0 : sectionsData[section].items.count //有多少行
    }
    
    // 设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let book: SH_book
     
        //搜索过滤
        if isFiltering() {
            //加装自制cell
            let cellConfigurator = filter_seach_section[indexPath.section].newcells[(indexPath as NSIndexPath).row]
            cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
            cellConfigurator.update(cell: cell)
            cell.isUserInteractionEnabled = false
            cell.textLabel?.numberOfLines = 0
           
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
            header.titleLabel.text = filter_seach_section[section].name
            header.arrowLabel.text = "-"
            header.setCollapsed(filter_seach_section[section].collapsed)
            
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
            
            if filter_seach_section[section].newcells.count == 0 {
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
    
        fliterContentforSearcheText(searchController.searchBar.text!)
    }
}

