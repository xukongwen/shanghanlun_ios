//
//  eachBookView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/3/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class EachBookView: UITableViewController {
    
    var alldata = [Book_allData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alldata.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //这个可以显示detaillable
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")

        
        let book = alldata[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 22)
        cell.textLabel?.text = book.header
       
        cell.detailTextLabel?.text = book.data[0].text
        cell.detailTextLabel?.textColor = .gray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookview = BookPageView()
        bookview.data = alldata[indexPath.row].data
        bookview.booktitle = alldata[indexPath.row].header
        navigationController?.pushViewController(bookview, animated: true)
    }
    
    
}
