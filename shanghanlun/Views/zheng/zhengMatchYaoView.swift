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
  
    var fangList = [SH_fang_final]()
    
    var findedYao = [SH_fang_final]()
    
    var displayAll = [String]()
    
    var fang: SH_fang_final?
    
    var findedfangList = [SH_fang_final]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "推荐方剂"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleCancel))
        
     
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        fangList = myAppdelegate.fanglist
        
        fangList.forEach { (fang) in
            fang.zheng.ti.forEach({ (zheng) in
                if result.contains(zheng) {
                    findedYao.append(fang)
                } else {
                    //findedYao.append("没有找到相关方剂")
                }
            })
        }
        
        displayAll.append("您的体证：")
        
        result.forEach { (zheng) in
            displayAll.append(zheng)
        }
        
        if findedYao.count == 0 {
            displayAll.append("未找到相关方剂。")
        } else {
            
            displayAll.append("根据《伤寒论》给您推荐如下方剂：")
            
            findedYao.forEach { (yao) in
                displayAll.append(yao.name)
            }
            
        }
        
      
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayAll.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let zheng = displayAll[indexPath.row]
        
        cell.textLabel?.text = zheng
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let booklook = fangDetailView()
        
        print(indexPath.row - 2 - result.count)
        print("zheng:", result.count)
        
        findedfangList.forEach({ (fang) in
            print(fang.name)
        })
        
        booklook.fang = findedYao[indexPath.row - 2 - result.count]
        
        navigationController?.pushViewController(booklook, animated: true)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)//这个方法是取消回到上一级
    }
    
    
    
    
}
