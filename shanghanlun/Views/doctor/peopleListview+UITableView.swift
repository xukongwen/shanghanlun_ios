//
//  peopleListview+UITableView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/11.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

extension PeopleListView { // 这个extension太厉害了，就可以把各种恶心的代码都放在这里，让主代码很清晰
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let people = peopleList[indexPath.row]
        
        
        let peopleInfo = PeopleInfoView()
        
        peopleInfo.people = people
        
        navigationController?.pushViewController(peopleInfo, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            let people = self.peopleList[indexPath.row]
            
            self.peopleList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManger.shared.pCon.viewContext
            context.delete(people)
            
            do {
                try context.save()
            } catch let saveErr {
                print(saveErr)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "编辑", handler: edithandler)
        
        editAction.backgroundColor = .black
        return [deleteAction, editAction]
    }
    
    private func edithandler(action: UITableViewRowAction, indexPath: IndexPath) {
        print("editing")
        let editPeopleView = CreatePeopleView()
        editPeopleView.companyCreateCon = self
        editPeopleView.peopleedit = peopleList[indexPath.row]
        let navCon = UINavigationController(rootViewController: editPeopleView)
        present(navCon, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PeopleCell
        let people = peopleList[indexPath.row]
        cell.people = people
        
        return cell
    }
    
    
    //  每个cell的高度定义
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
