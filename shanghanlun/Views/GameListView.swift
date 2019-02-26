//
//  GameListView.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/25.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit

class GameListView: UITableViewController {

    var gameList = [UIViewController]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "小游戏和测试"
   
    }

 
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gameList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = gameList[indexPath.row].title
        cell.textLabel?.font = UIFont.init(name: "Songti Tc", size: 20)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(gameList[indexPath.row], animated: true)
    }
 

    
}
