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
    var yaoall = 0.0
    var yaoAllCost: String!
    var benCaoList = [BenCao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WenYue-GuDianMingChaoTi-NC-W5
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        benCaoList = myAppdelegate.benCaoList
      
        
        
        fangList.append("用药\(fang!.yaoList.count)味:")
        
        // 隐藏separator line 设置颜色
        //self.tableView.separatorColor = UIColor.clear
   
        // 分配每个cell-fangList
        for k in fang!.yaoList {
            
            let intext = k.yaoname + ":" + k.weightChina + "(汉制), 约为" + String(format: "%.2f", Double(k.weight) * 0.15) + "克"
            yaoNameList.append(k.yaoname)
            fangList.append("     \(intext)")
        }
        
        let name = fang!.name
        let text = fang?.zhengtext
        title = name
        fangList.append("原文辨证：")
        fangList.append(text!)
        fangList.append("原文用药法：")
        fangList.append((fang?.fuyaotext)!)
        
        
        // 蛋疼的计算价格
        fang?.yaoList.forEach({ (yao) in
            for cao in benCaoList {
                if yao.yaoname == cao.name {
                    var chu: Double
                    var new: Double
                    chu = Double(cao.cost) / 1000.0
                    new = chu * Double(yao.weight) * 0.15
                    yaoall = yaoall + new
                    yaoAllCost = String(format: "%.2f", yaoall) // 只显示小数点两位
                }
            }

        })
        
        fangList.append("一副药之大约市场价格：\(yaoAllCost ?? "")圆")
        
        
    }
    
    // 这个太好了，可以获取所有字体的名字！
    func findfont() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fangList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let fangtext = fangList[indexPath.row]
        if indexPath.row == 0 {
            cell.textLabel?.text = fangtext
            cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.frame.width - 50)
           
            cell.isUserInteractionEnabled = false // 禁止选择
        } else if fangtext == "原文辨证："{
            cell.textLabel?.text = fangtext
            cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.frame.width - 70)
            cell.isUserInteractionEnabled = false
            
        } else if fangtext == "原文用药法："{
            cell.textLabel?.text = fangtext
            cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.frame.width - 90)
            cell.isUserInteractionEnabled = false
            
        }
        else {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = fangtext
            
            //让下面的分割线消失
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10000)
            //cell.textLabel?.textColor = .gray
            cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row <= yaoNameList.count {//这里要判断一下，否则出bug
            let yaoname: String = yaoNameList[indexPath.row - 1]
            let yaoDD = YaoDetailView()
            yaoDD.yao = yaoname
            navigationController?.pushViewController(yaoDD, animated: true)
        }
        else {
            return
        }
    }
    
}
