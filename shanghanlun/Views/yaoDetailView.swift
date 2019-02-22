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
    
    //var yaoList = [CaoYao]()
    var benCaoList = [BenCao]()
    var yao: String!
    var selectYao: BenCao!
    var yaoDetail = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = yao
        
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        benCaoList = myAppdelegate.benCaoList
        
        findYao()
        
        yaoDetail.append("味：\(selectYao.wei)")
        yaoDetail.append("性：\(selectYao.temp)")
        yaoDetail.append(selectYao.text)
        yaoDetail.append("一公斤市场价格约为：\(selectYao.cost)圆")
   
        
    }
    
    
    func findYao() {
        for y in benCaoList {
            if yao == y.name {
                selectYao = y
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yaoDetail.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let yaotext = yaoDetail[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = yaotext
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.isUserInteractionEnabled = false
        return cell
    }
}
