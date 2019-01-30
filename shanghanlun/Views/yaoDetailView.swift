//
//  yaoDetailView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/27.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class YaoDetailView: UITableViewController {
    
    var yaoList = [CaoYao]()
    var yao: String!
    var selectYao: CaoYao!
    var yaoDetail = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = yao
        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        yaoList = myAppdelegate.yaoList
        findYao()
   
        
    }
    
    
    func findYao() {
        for y in yaoList {
            if yao == y.name {
                selectYao = y
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = selectYao.text
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
}
