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
    
    
    //自己的字体
    //WenYue GuDianMingChaoTi (Non-Commercial Use) Font names: ["WenYue-GuDianMingChaoTi-NC-W5"]
    //Family: WenyueType GutiFangsong (Non-Commercial Use) Font names: ["Wyue-GutiFangsong-NC"]
    //Songti SC Font names: ["STSongti-SC-Black", "STSongti-SC-Regular", "STSongti-SC-Bold", "STSongti-SC-Light"]
    //Family: Songti TC Font names: ["STSongti-TC-Light", "STSongti-TC-Bold", "STSongti-TC-Regular

    var window: UIWindow?
    var lovelistView = LoveView()
    
    var fanglist = [SH_fang_final]()
    var yaoList = [CaoYao]()
    var benCaoList = [BenCao]()
    
    var allbook = [Book]()
    var SHbook = [SH_book]()
    
    var sectionsData = [Section_jk]()
    var sectionJk = [SH_fang_final]()
    
    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: "STSongti-SC-Black", size: 35)!]
   
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //===========用以下方法一次性定义导航栏的属性==================
        UINavigationBar.appearance().prefersLargeTitles = true
        
        //导航栏的颜色和返回的颜色
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        //自定义小字体导航栏
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "STSongti-SC-Black", size: 25)!]
        
        UINavigationBar.appearance().largeTitleTextAttributes = attrs
        
        //=====================创建这些view的实例=======================
        
        let fangandyuanwenView = FangAndYuanwenViewCon()
        fangandyuanwenView.title = "方剂与原文"
        
        let fanglistView = fangView()
        fanglistView.title = "方剂"
       
        let booklistView = yuanwenTableViewController()
        booklistView.title = "原文"
       
        lovelistView.title = "收藏"
        
        let swip = SwipingController(collectionViewLayout: UICollectionViewFlowLayout())
        swip.title = "方剂与原文"
        
        let gridboxView = BoxGird()
        gridboxView.title = "Grid"
        
        let chart1View = PieChartPolylineVC()
        chart1View.title = "数据与研究"
        
        let peopleList1 = PeopleListView()
        peopleList1.title = "患者档案"
        
        let zhengFindYao = ZhengTestCon()
        zhengFindYao.title = "自医"
        
        let allbookView = AllBookView()
        allbookView.title = "古籍"
        
        let yinyangView = YinYangWord()
        yinyangView.title = "阴阳动画实验"
        
        
        //获得storyboard里的创建好的view
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "MyStory", bundle: nil)
        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "drag") as! DrageandDropView
        setViewController.title = "Drag"
        
        let gamelist1 = GameListView()
        gamelist1.gameList = [yinyangView, gridboxView, setViewController, peopleList1, chart1View, allbookView]
        gamelist1.title = "其他"
        
        //======================tab view========================
        let tabVC = UITabBarController(nibName: nil, bundle: nil)
        tabVC.setViewControllers([
            UINavigationController(rootViewController: fanglistView),
            UINavigationController(rootViewController: booklistView),
            UINavigationController(rootViewController: zhengFindYao),
            UINavigationController(rootViewController: lovelistView),
            UINavigationController(rootViewController: gamelist1)
            ], animated: true)
        
        //============read json==========================
        readFileJson(jsonFile: "SH_all_fang1.json")
        readFile_BenCao(jsonFile: "SH_yao_1.json")
        readSH_book(jsonFile: "SH_book.json")
        readFile_book(jsonFile: "Book_XinJing.json")
        readFile_book(jsonFile: "Book_TanJing.json")
        readFile_book(jsonFile: "Book_NeiJing.json")
        readFile_book(jsonFile: "Book_NeiJing_ls.json")

    
        window = UIWindow()
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
        //打印所有字体
        //findfont()
    
        return true
    }
    
    // 这个太好了，可以获取所有字体的名字！
    func findfont() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
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
                    
                    var sh_fang_list = [SH_fang_final]()
                    var jk_fang_list = [SH_fang_final]()
                    for i in oneJson {
                        if i.book == "伤寒论" {
                            sh_fang_list.append(i)
                        }
                        if i.book == "金匮" {
                            jk_fang_list.append(i)
                        }
                    }
                    self.sectionsData.append(Section_jk(name: "伤寒方剂", items: sh_fang_list))
                    self.sectionsData.append(Section_jk(name: "金匮方剂", items: jk_fang_list))
                    
                } catch let jsonErr {
                    print("apperr:",jsonErr)
                }
            }
            
            }.resume()
    }

    
    func readFile_BenCao(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([BenCao].self, from: data)
                    
                    self.benCaoList = oneJson
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }
    
    func readFile_book(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode(Book.self, from: data)
                    
                    self.allbook.append(oneJson)
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            }.resume()
    }
    
    func readSH_book(jsonFile: String) {
        
        guard let fileURL = Bundle.main.url(forResource: jsonFile, withExtension: nil),
            let _ = try? Data.init(contentsOf: fileURL) else{
                fatalError("`JSON File Fetch Failed`")
        }
        
        URLSession.shared.dataTask(with: fileURL) { (data, response, err) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let oneJson = try JSONDecoder().decode([SH_book].self, from: data)
                    
                    self.SHbook = oneJson
                    
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
