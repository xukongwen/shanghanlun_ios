//
//  Test_zheng_con.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/26.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class ZhengTestCon: UITableViewController {
    
    
    var selectedIndexs: [Int] = []
    var selectedZheng = [String]()
    
    let allZheng = [
        "汗出",
        "恶寒",
        "头痛",
        "恶风",
        "发热",
        "不出汗",
        "欲吐",
        "渴",
        "喜睡",
        "鼻鸣干呕",
        "气上冲",
        "小便难",
        "身痒",
        "大烦而渴",
        "小便多",
        "手脚寒冷",
        "骨节痛",
        "身痛腰痛",
        "咳而微喘",
        "咳",
        "心悸",
        "脐下悸",
        "腹胀满",
        "往来寒热",
        "口苦"
    ]
    
    var selectedRow = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNext(selector: #selector(findYao))
        tableView.allowsMultipleSelection = true
        tableView.register(ZhengCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    
    @objc func findYao() {
        let getYao = ZhengMatchYao()
        let navCon = UINavigationController(rootViewController: getYao)
        present(navCon, animated: true, completion: nil)
        
        getYao.result = selectedZheng
        getYao.tableView.reloadData()
        //createPeopleView1.companyCreateCon = self//这个就是把自己交给了另外的view
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allZheng.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ZhengCell
        
        cell.tintColor = UIColor.brown
        
        if selectedIndexs.contains(indexPath.row) {
           
            cell.peopleimageivew.image = UIImage(named:"select")
        } else {
           
            cell.peopleimageivew.image = UIImage(named:"deselect")
        }
        
        let zheng = allZheng[indexPath.row]
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        cell.peoplename.text = zheng
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ZhengCell
        let zheng = allZheng[indexPath.row]
      
        if let index = selectedIndexs.index(of: indexPath.row){
            selectedIndexs.remove(at: index)
            selectedZheng.remove(at: index)
            cell.peopleimageivew.image = UIImage(named:"deselect")
        }else{
            selectedIndexs.append(indexPath.row)
            selectedZheng.append(zheng)
            cell.peopleimageivew.image = UIImage(named:"select")
        }
        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
        print(selectedZheng)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
}
