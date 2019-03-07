//
//  test_2.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/6.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class Tt_1cell : UITableViewController {
    
    var items: [CellConfiguratorType] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()//隐藏cell下面不用多余的line
        //tableView.rowHeight = 100 //cell的高度
    
        items = [
        CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: "搜索六经统计柱图")),
        ]
        
        registerCells()
     
    }
    
    func registerCells() {
        for cellConfigurator in items {
            tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
        }
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = items[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
        cellConfigurator.update(cell: cell)
        return cell
    }
    
}
