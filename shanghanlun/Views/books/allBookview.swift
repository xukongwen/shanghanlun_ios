//
//  allBookview.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/8.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class AllBookView : UITableViewController {
    
    var allBook = [Book]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        allBook = myAppdelegate.allbook
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return allBook.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        let book = allBook[indexPath.row]
      
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
        cell.textLabel?.text = book.bookname
        cell.detailTextLabel?.text = book.writer
        cell.detailTextLabel?.textColor = .gray
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookview = EachBookView()
        bookview.alldata = allBook[indexPath.row].alldata
        bookview.booktitle = allBook[indexPath.row].bookname
        
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(bookview, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
}
