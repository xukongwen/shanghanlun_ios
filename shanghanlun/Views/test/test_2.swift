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
        
        registerCells()
        
        items = [
        CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: "Foo")),
        CellConfigurator<ImageTableViewCell>(viewData: ImageCellViewData(image: UIImage(named: "brain")!)),
        CellConfigurator<ImageTableViewCell>(viewData: ImageCellViewData(image: UIImage(named: "brain")!)),
        CellConfigurator<TextTableViewCell>(viewData: TextCellViewData(title: "Bar")),
        ]
     
    }
    
    func registerCells() {
        for cellConfigurator in items {
            tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = items[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
        cellConfigurator.update(cell: cell)
        return cell
    }
    
    
}
