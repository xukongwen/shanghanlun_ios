//
//  PeopleZhengView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

protocol CreateDocdelgate {
    func didAddDoc(doc: DoctorEntity)
}

class PeopleZhengView: UIViewController {
    
    var people: PeopleEntity?
    
    var delegate: CreateDocdelgate?

    let nameLabe : UILabel = {
        let lable = UILabel()
        lable.text = "病症与病情："
        lable.font = UIFont.init(name: "Songti Tc", size: 18)
        
        //这个是开启自动对齐功能
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let textField : UITextField = {
        let field = UITextField()
        field.placeholder = "写入内容"
        field.font = UIFont.init(name: "Songti Tc", size: 18)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let timeLabe : UILabel = {
        let lable = UILabel()
        lable.text = "患病时间："
        lable.font = UIFont.init(name: "Songti Tc", size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let timeField : UITextField = {
        let field = UITextField()
        field.placeholder = "年/月/日"
        field.font = UIFont.init(name: "Songti Tc", size: 18)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setpupCancle()
        setupUIBackgroud()
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "储存", style: .plain, target: self, action: #selector(handlesave))
        
        title = "创建详细病案"
        view.backgroundColor = .white
        
        
    }
    
    @objc func handlesave () {
        
        guard let doctorName = textField.text else {return}
        guard let peoplep = self.people else {return}
        
        guard let illtime = timeField.text else {return}
        
        
        // 转化文本成为时间
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"
        
        guard let illdate = dateFormater.date(from: illtime) else {
            
            let alertCon = UIAlertController(title: "日期格式错误", message: "请填写正确日期格式", preferredStyle: .alert)
            alertCon.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertCon, animated: true, completion: nil)
            
            
            return
        }
       
        // 警告如果没有填写
        if illtime.isEmpty {
            let alertCon = UIAlertController(title: "未填写日期", message: "请填写患病日期", preferredStyle: .alert)
            alertCon.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertCon, animated: true, completion: nil)
            return
        }
        
        guard let illtype = illType.titleForSegment(at: illType.selectedSegmentIndex) else {return}
        
        let doc = CoreDataManger.shared.createDocetor(doctorName: doctorName, illdate: illdate, people: peoplep, illType: illtype)
        
        dismiss(animated: true) {
            // call the delegate
            self.delegate?.didAddDoc(doc: doc!)
            
        }
    }
    
    
    // 如何创造一个可选择选项
    let illType : UISegmentedControl = {
        let type = ["阴","阳"]
        let sc = UISegmentedControl(items: type)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .black
       
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
  
    private func setupUI() {
        // 设置“名字”
        view.addSubview(nameLabe)
        nameLabe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true//这里要这样写，否则就跑上面去了
        nameLabe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabe.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabe.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 设置输入名字区域
        view.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: nameLabe.rightAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: nameLabe.bottomAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: nameLabe.topAnchor).isActive = true
        
        // 设置时间文字
        view.addSubview(timeLabe)
        timeLabe.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        timeLabe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        timeLabe.widthAnchor.constraint(equalToConstant: 150).isActive = true
        timeLabe.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 设置输入日期区域
        view.addSubview(timeField)
        timeField.leftAnchor.constraint(equalTo: timeLabe.rightAnchor).isActive = true
        timeField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        timeField.bottomAnchor.constraint(equalTo: timeLabe.bottomAnchor).isActive = true
        timeField.topAnchor.constraint(equalTo: timeLabe.topAnchor).isActive = true
        
        view.addSubview(illType)
        illType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        illType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        illType.topAnchor.constraint(equalTo: timeField.bottomAnchor).isActive = true
        illType.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
       
  
}
