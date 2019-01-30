//
//  fangDetailView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/23.
//  Copyright © 2019 xuhua. All rights reserved.
//

import Foundation
import UIKit

class fangDetailView: UITableViewController {
    
    var fang: SH_fang_final?
    var fangList = [String]()
    var yaoNameList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for k in fang!.yaoList {
            
            let intext = k.yaoname + ":" + k.weightChina + "(汉制), 约为" + String(Double(k.weight) * 15) + "克"
            yaoNameList.append(k.yaoname)
            fangList.append(intext)
        }
        
        let name = fang!.name
        let text = fang?.zhengtext
        title = name
 
        fangList.append(text!)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fangList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let fangtext = fangList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = fangtext
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row <= yaoNameList.count - 1 {//这里要判断一下，否则出bug
            let yaoname: String = yaoNameList[indexPath.row]
            let yaoDD = YaoDetailView()
            yaoDD.yao = yaoname
            navigationController?.pushViewController(yaoDD, animated: true)
        }
        else {
            return
        }
    }
    
}
