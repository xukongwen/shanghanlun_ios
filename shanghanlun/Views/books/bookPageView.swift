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
        
        //在阅读的时候隐藏整个navbar
        navigationController?.hidesBarsOnSwipe = true
        //其他时候要改回来，这是一个bug
    
    }
    
    //隐藏电量这些的状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //隐藏iphone x 的返回home line
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let book = data[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.init(name: "STSongti-TC-Regular", size: 22)
        cell.textLabel?.textColor = .gray
        cell.textLabel?.text = book
        cell.isUserInteractionEnabled = false
        return cell
    }
    
}
