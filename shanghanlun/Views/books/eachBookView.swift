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
    var hidebar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidebar = false
   
        title = booktitle
     
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if alldata.count == 1 {
            return alldata[0].data.count
        } else {
            return alldata.count
        }
    
    }
    
    override var prefersStatusBarHidden: Bool {
        return hidebar
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return hidebar
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if alldata.count == 1 {
            
            navigationController?.hidesBarsOnSwipe = true
            hidebar = true
          
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
            let book = alldata[0].data[indexPath.row]
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.init(name: "STSongti-TC-Regular", size: 22)
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textColor = .gray
            cell.textLabel?.text = book.text
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10000)
            
            return cell
            
        } else {
            navigationController?.hidesBarsOnSwipe = false
            hidebar = false
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
        
        //看原文时隐藏tabbar
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(bookview, animated: true)
        //回来时再次显示
        //self.hidesBottomBarWhenPushed = false
    }
    
    
}
