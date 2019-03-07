
import UIKit

class ImageTableViewCell: UITableViewCell {
    
    let ScreenHeight = UIScreen.main.bounds.size.height
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    var chart = SH_Charts()

    override func layoutSubviews() {
        super.layoutSubviews()

        // we should use a custom imageView, but this will do for demonstrational purposes
        imageView?.frame = bounds
        imageView?.contentMode = .scaleAspectFit

        resetSeparators()
    }

    func update(viewData: ImageCellViewData) {
        imageView?.image = viewData.image
  
        let pieView = chart.pieChartView
    
        pieView.backgroundColor = ZHFColor.white
        pieView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 300)
        pieView.translatesAutoresizingMaskIntoConstraints = false
    
        chart.setPieChartViewBaseStyle(title: "")
        chart.updataData(chartData: viewData.data)
        
        addSubview(pieView)
        pieView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pieView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        pieView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pieView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pieView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}

extension ImageTableViewCell: Updatable {
    typealias ViewData = ImageCellViewData
}
