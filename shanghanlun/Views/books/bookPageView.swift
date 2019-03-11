//
//  bookPageView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class BookPageView : UITableViewController {
    
    var data = [Book_allData_Data]()
    var booktitle : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = booktitle
        
        self.tableView.separatorColor = UIColor.clear
        //隐藏nav下面那个线
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let book = data[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.textLabel?.text = book
        cell.isUserInteractionEnabled = false
        return cell
    }
    
}
