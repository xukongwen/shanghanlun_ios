//
//  CreatePeople.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/7.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class CreatePeopleView: UIViewController {
    
    var companyCreateCon : PeopleListView?
    
    let nameLabe : UILabel = {
        let lable = UILabel()
        lable.text = "name"
        //lable.backgroundColor = .red
        //这个是开启自动对齐功能
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let textField : UITextField = {
        let field = UITextField()
        field.placeholder = "写入名称"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PeopleEntity
        
        setupUI()
        
        title = "创建人"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "储存", style: .plain, target: self, action: #selector(save))
   
    }
    
    @objc private func save() {
       
        let context = CoreDataManger.shared.pCon.viewContext //这里是创建可以永久储存的context
     
        let savepeople = NSEntityDescription.insertNewObject(forEntityName: "PeopleEntity", into: context)
        savepeople.setValue(textField.text, forKey: "name")
        
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.companyCreateCon?.addPeople(people: savepeople as! PeopleEntity)
            }
            
        } catch let saveErr {
            print("failed to save: \(saveErr)")
        }
        
  
    
    }
    
    private func setupUI() {
        
        //要先创建一个底层的uiview，然后把其他ui放在这个上面
        let backView = UIView()
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        view.addSubview(nameLabe)
        nameLabe.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true//这里要这样写，否则就跑上面去了
        nameLabe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabe.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabe.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: nameLabe.rightAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: nameLabe.bottomAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: nameLabe.topAnchor).isActive = true
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)//这个方法是取消回到上一级
    }
}
