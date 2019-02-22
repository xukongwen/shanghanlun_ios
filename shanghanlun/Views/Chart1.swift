import UIKit
import Charts

class PieChartPolylineVC: UITableViewController {
   
    var chart1 = SH_Charts()
    var chart2 = SH_Charts()
    var chartList: [SH_Charts?] = []
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        
        chartList.append(chart1)
        chartList.append(chart2)
        
//        chart1.setPieChartViewBaseStyle(title: "第一个")
//        chart2.setPieChartViewBaseStyle(title: "第二个")
        
        tableView.register(ChartCell.self, forCellReuseIdentifier: "Cell")
      

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChartCell
        //print(chartList[indexPath.row].se)
        
        cell.chart = chartList[indexPath.row]!
        
        return cell
    }

    
}



