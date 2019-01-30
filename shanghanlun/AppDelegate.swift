//
//  AppDelegate.swift
//  shanghanlun
//
//  Created by xuhua on 2019/1/22.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var lovelistView = LoveView()
    
    var fanglist = [SH_fang_final]()
    var yaoList = [CaoYao]()
    var sectionData = [Section_jk]()
   
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let fanglistView = fangView()
        fanglistView.title = "方剂"
        //print("hi:",fanglistView.sectionData)
        let booklistView = yuanwenTableViewController()
        booklistView.title = "原文"
        //print("hi2:", booklistView.sectionsData)
        lovelistView.title = "收藏"
        
        let gridboxView = BoxGird()
        gridboxView.title = "Grid"
        
        let chart1View = PieChartPolylineVC()
        chart1View.title = "数据与研究"
        
        //获得storyboard里的创建好的view
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "MyStory", bundle: nil)
        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "drag") as! DrageandDropView
        setViewController.title = "Drag"
        
        let gamelist1 = GameListView()
        gamelist1.gameList = [gridboxView, setViewController]
        gamelist1.title = "小游戏"
        
   
        let tabVC = UITabBarController(nibName: nil, bundle: nil)
        tabVC.setViewControllers([
            UINavigationController(rootViewController: fanglistView),
            UINavigationController(rootViewController: booklistView),
            UINavigationController(rootViewController: lovelistView),
            UINavigationController(rootViewController: chart1View),
            UINavigationController(rootViewController: gamelist1)
            ], animated: true)
        
        readFileJson(jsonFile: "SH_all_fang1.json")
        readFileJson_yao(jsonFile: "SH_yao.json")
        //print(fanglist)
        window = UIWindow()
        window?.makeKeyAndVisible()

        window?.rootViewController = tabVC
       
        return true
    }
    
    
    
    
    func readFileJson(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_fang_final].self, from: data)
                    self.fanglist = oneJson
                } catch let jsonErr {
                    print("apperr:",jsonErr)
                }
            }
            
            }.resume()
    }
    
    func readFileJson_yao(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([CaoYao].self, from: data)
                    
                    self.yaoList = oneJson
                 
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }
    
    
    
    
    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


class TestView:BaseTableCon<BaseCell> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

func ZHFLog<T>(message : T, file : String = #file, line : Int = #line) {
    //在DEBUG环境下打印，在RELEASE环境下不打印
    #if DEBUG
    let file1 = (file as NSString).lastPathComponent
    let line1 = (line as Int)
    print("\(file1):line\(line1)---\(message)")
    #endif
}
