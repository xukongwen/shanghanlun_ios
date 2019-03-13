//
//  bookDetailTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/19.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class bookDetailTableViewController: UITableViewController {
    
    
    var fang: SH_book?
    var fangdata: SH_book_data!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        
        title = fang?.header
        navigationItem.largeTitleDisplayMode = .automatic
        
    
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return fang!.data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        fangdata = fang!.data[indexPath.row]!
        
        
       
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fangdata.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    
    
    
}

