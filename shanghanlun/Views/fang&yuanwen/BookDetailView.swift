//
//  bookDetailTableViewController.swift
//  learn_ui_1
//
//  Created by xuhua on 2019/1/19.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import SelectableTextView

class bookDetailTableViewController: UITableViewController {
    
    
    var fang: SH_book?
    var fangdata: SH_book_data!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        
        title = fang?.header
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.register(BookPageCell.self, forCellReuseIdentifier: "Cell")
        
    
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return fang!.data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookPageCell

        fangdata = fang!.data[indexPath.row]!
        
       
        cell.textLabel?.numberOfLines = 0//这个是让一个cell完整显示无论多少text，自动扩展
        cell.textLabel?.text = fangdata.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        
        
//        cell.peoplename.text = fangdata.text
//        cell.peoplename.textColor = .clear
//        cell.peoplename.numberOfLines = 0
//
//        cell.textView.text = fangdata.text
//        cell.textView.textColor = .red
//        cell.textView.font = UIFont.init(name: "Songti Tc", size: 18)!
//        cell.textView.numberOfLines = 0
//        cell.isUserInteractionEnabled = true
        
        //print(cell.textView.text!)
        
        return cell
    }

    
}

