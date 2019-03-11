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
    var booktitle : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = booktitle
        
        
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if alldata.count == 1 {
            return alldata[0].data.count
        } else {
            return alldata.count
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if alldata.count == 1 {
            
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
            let book = alldata[0].data[indexPath.row]
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = book.text
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10000)
            
            return cell
            
        } else {
            
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
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookview = BookPageView()
        bookview.data = alldata[indexPath.row].data
        bookview.booktitle = alldata[indexPath.row].header
        navigationController?.pushViewController(bookview, animated: true)
    }
    
    
}
