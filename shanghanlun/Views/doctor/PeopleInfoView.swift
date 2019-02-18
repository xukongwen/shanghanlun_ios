//
//  PeopleInfoView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class NewHeader: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
}

class PeopleInfoView: UITableViewController, CreateDocdelgate {

    func didAddDoc(doc: DoctorEntity) {
       
        fetchdoc()
        tableView.reloadData()
        
    }
    
    
    var people : PeopleEntity?
    var doctors = [DoctorEntity]()
    
    // 用一个2维数组解决section问题
    var alldocs = [[DoctorEntity]]()
    
    let cellId = "hicell"
    
    
    // 设定section的类型
    var illtypes = [
        "阴",
        "阳"
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = people?.name
        
    }
    
    
    // 读取名单
    
    // 这里很重要，就是根据seciton类型来制作2维数组
    private func fetchdoc() {
    
        guard let docs = people?.docs?.allObjects as? [DoctorEntity] else {return}
        
        alldocs = []
        
        // 这里面每一个组就对应了那一个数据类型
        illtypes.forEach { (type) in
            alldocs.append(
                docs.filter{ $0.type == type }
            )
        }
        //print(alldocs)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchdoc()
        
        setpupPlus(selector: #selector(handlePlus))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
      
    }
    
    @objc func handlePlus() {
        
        let peopleZheng = PeopleZhengView()
        peopleZheng.delegate = self
        peopleZheng.people = people
        let nav = UINavigationController(rootViewController: peopleZheng)
     
        present(nav, animated: true, completion: nil)
    }
    
    //每个section里有多少行
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return alldocs[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
 
        //根据所在section调出相应cell的数据
        let doctor = alldocs[indexPath.section][indexPath.row]
  
        cell.textLabel?.text = doctor.name
        
        if let illdate = doctor.docinfo?.illdate {
            
            let dataFormter = DateFormatter()
            dataFormter.dateFormat = "yyyy/MM/dd"
            
            cell.textLabel?.text = "\(doctor.name ?? "")    \(dataFormter.string(from: illdate))"
           
        }
        
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return alldocs.count
    }
    
    
    // 根据类型显示section header的文字
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lable = NewHeader()
        lable.backgroundColor = .black
        
        lable.text = illtypes[section]
      
        lable.textColor = .white
        
        
        return lable
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        
        // 隐藏不用的section
        if alldocs[section].count == 0 {
            return 0
        }
        return 50
    }
    
}
