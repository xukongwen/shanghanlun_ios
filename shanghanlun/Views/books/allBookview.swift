//
//  allBookview.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/8.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class AllBookView : UITableViewController {
    
    let allBook = ReadJson.shared.readBookJson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return allBook[0].alldata.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBook[0].alldata[section].data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let book = allBook[0]
        
        cell.textLabel?.text = book.alldata[indexPath.row].header
        
        return cell
    }
    
    
    
    
}
