//
//  CreatePeople.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/7.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import CoreData

class CreatePeopleView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var companyCreateCon : PeopleListView?
    
    //下面是做一个可以交互的自定义图片的方法
    lazy var peopleFace : UIImageView = {// 这里写 lazy var 可以让下面的self 成为自己，否则是nil
        let im = UIImageView(image: #imageLiteral(resourceName: "brain"))//这样加载一个图片,shift+cmd+M
        im.isUserInteractionEnabled = true//让这个东西可以和用户手指交互，默认时关闭的
        im.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlepickPhoto)))//这是给这个物件可以交互手势
        
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill// 不会拉伸
        return im
    }()
    
    @objc func handlepickPhoto() {
        let impicker = UIImagePickerController()
        impicker.delegate = self
        impicker.allowsEditing = true
        present(impicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            peopleFace.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            peopleFace.image = originalImage
        }
        
        // 把图片切成一个圆形
//        peopleFace.layer.cornerRadius = peopleFace.frame.width / 2
//        peopleFace.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    //这个有点意思，在创建时就写好内容
    var peopleedit : PeopleEntity? {
        didSet {
            textField.text = peopleedit?.name
            
            if let imageData = peopleedit?.imageData {
                peopleFace.image = UIImage(data: imageData)
//                peopleFace.layer.cornerRadius = peopleFace.frame.width / 2
//                peopleFace.clipsToBounds = true
            }
            
            guard let birthday = peopleedit?.birthday else {
                return
            }
            
            dataPicker.date = birthday
        }
    }
    
    let dataPicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    let nameLabe : UILabel = {
        let lable = UILabel()
        lable.text = "姓名："
     
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.title = peopleedit == nil ? "创建患者" : "编辑患者"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PeopleEntity
        
        setupUI()
        
      
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "储存", style: .plain, target: self, action: #selector(save))
   
    }
    
    
    //=========储存=============
    @objc private func save() {
       
        if peopleedit == nil {
            createPeople()
        } else {
            saveeditChange()
        }
        
  
    
    }
    
    
    //=======保存更改===============
    private func saveeditChange() {
        
        let context = CoreDataManger.shared.pCon.viewContext
        //let savepeople = NSEntityDescription.insertNewObject(forEntityName: "PeopleEntity", into: context)
        peopleedit?.name = textField.text
        peopleedit?.birthday = dataPicker.date
        
        if let ppImage = peopleFace.image {
            let imageData = ppImage.jpegData(compressionQuality: 0.8)
            peopleedit?.imageData = imageData
        }
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.companyCreateCon?.dideditPeople(people: self.peopleedit!)
            }
            
        } catch let saveErr {
            print("savefail: \(saveErr)")
        }
        
        
    }
    //===========创建人物===============
    private func createPeople() {
        
        let context = CoreDataManger.shared.pCon.viewContext //这里是创建可以永久储存的context
        
        let savepeople = NSEntityDescription.insertNewObject(forEntityName: "PeopleEntity", into: context)
        
        savepeople.setValue(textField.text, forKey: "name")
        savepeople.setValue(dataPicker.date, forKey: "birthday")
        
        if let ppImage = peopleFace.image {
            let imageData = ppImage.jpegData(compressionQuality: 0.8)
            savepeople.setValue(imageData, forKey: "imageData")
        }
     
        
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
        
        
        // 设置背景颜色
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        // 设置图片选取
        view.addSubview(peopleFace)
        peopleFace.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true //如果要加一些空间，就在后面加上 constant： 多少
        peopleFace.heightAnchor.constraint(equalToConstant: 100).isActive = true
        peopleFace.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        peopleFace.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // 设置“名字”
        view.addSubview(nameLabe)
        nameLabe.topAnchor.constraint(equalTo: peopleFace.bottomAnchor).isActive = true//这里要这样写，否则就跑上面去了
        nameLabe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabe.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabe.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 设置输入名字区域
        view.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: nameLabe.rightAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: nameLabe.bottomAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: nameLabe.topAnchor).isActive = true
        
        // 设置时间选取
        view.addSubview(dataPicker)
        dataPicker.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        dataPicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dataPicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dataPicker.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
        
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)//这个方法是取消回到上一级
    }
}
