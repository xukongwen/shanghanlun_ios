//
//  zhengMatchYaoView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/26.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class ZhengMatchYao: UITableViewController {
    
    var result = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let zheng = result[indexPath.row]
        cell.textLabel?.text = zheng
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)//这个方法是取消回到上一级
    }
    
    
    
    
}
