//
//  ChartFuncs.swift
//  shanghanlun
//
//  Created by xuhua on 2019/2/22.
//  Copyright © 2019 xuhua. All rights reserved.
//

import UIKit
import Charts

class SH_Charts {
    
    let ScreenHeight = UIScreen.main.bounds.size.height
    let ScreenWidth = UIScreen.main.bounds.size.width
    
    var pieChartView: PieChartView  = PieChartView()
    var data: PieChartData = PieChartData()
    
    var barChartView: BarChartView = BarChartView()
    lazy var xVals: NSMutableArray = NSMutableArray.init()
    var bardata: BarChartData = BarChartData()
    let axisMaximum :Double = 100
    
    var fanglist: [SH_fang_final]!
    
    @objc func updataBarData_1(){
        //对应x轴上面需要显示的数据
        let count = 8
        let x1Vals: NSMutableArray  = NSMutableArray.init()
        for i in 0 ..< count {
            //x轴字体展示
            x1Vals.add("\(i)月")
            self.xVals = x1Vals
        }
        //对应Y轴上面需要显示的数据
        let yVals: NSMutableArray  = NSMutableArray.init()
        for i in 0 ..< count {
            let val: Double = Double(arc4random_uniform(UInt32(axisMaximum)))
            let entry:BarChartDataEntry  = BarChartDataEntry.init(x:  Double(i), y: Double(val))
            yVals.add(entry)
        }
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1: BarChartDataSet = BarChartDataSet.init(values: yVals as? [ChartDataEntry], label: "信息")
        set1.barBorderWidth = 0.2 //边线宽
        set1.drawValuesEnabled = true //是否在柱形图上面显示数值
        set1.highlightEnabled = true //点击选中柱形图是否有高亮效果，（单击空白处取消选中）
        set1.setColors(ZHFColor.gray,ZHFColor.green,ZHFColor.yellow,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置柱形图颜色(是一个循环，例如：你设置5个颜色，你设置8个柱形，后三个对应的颜色是该设置中的前三个，依次类推)
        //  set1.setColors(ChartColorTemplates.material(), alpha: 1)
        //  set1.setColor(ZHFColor.gray)//颜色一致
        let dataSets: NSMutableArray  = NSMutableArray.init()
        dataSets.add(set1)
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data:  BarChartData = BarChartData.init(dataSets: dataSets as? [IChartDataSet])
        data.barWidth = 0.7  //默认是0.85  （介于0-1之间）
        data.setValueFont(UIFont.systemFont(ofSize: 10))
        data.setValueTextColor(ZHFColor.orange)
        let formatter: NumberFormatter = NumberFormatter.init()
        formatter.numberStyle = NumberFormatter.Style.currency//自定义数据显示格式  小数点形式(可以尝试不同看效果)
        let forma :DefaultValueFormatter = DefaultValueFormatter.init(formatter: formatter)
        data.setValueFormatter(forma)
        barChartView.data = data
        barChartView.animate(yAxisDuration: 1)//展示方式xAxisDuration 和 yAxisDuration两种
        //  barChartView.animate(xAxisDuration: 2, yAxisDuration: 2)//展示方式xAxisDuration 和 yAxisDuration两种
    }
    
    
    //根据搜索关键词的饼图统计
    @objc func updataData(chartData: [Int]){
      
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        self.fanglist = myAppdelegate.fanglist

        let yVals: NSMutableArray  = NSMutableArray.init()//这个是数据的合集
        
        let entry1 = PieChartDataEntry.init(value: Double(chartData[0]), label: "太阳\(chartData[0])")
        let entry2 = PieChartDataEntry.init(value: Double(chartData[1]), label: "少阳\(chartData[1])")
        let entry3 = PieChartDataEntry.init(value: Double(chartData[2]), label: "阳明\(chartData[2])")
        let entry4 = PieChartDataEntry.init(value: Double(chartData[3]), label: "太阴\(chartData[3])")
        let entry5 = PieChartDataEntry.init(value: Double(chartData[4]), label: "少阴\(chartData[4])")
        let entry6 = PieChartDataEntry.init(value: Double(chartData[5]), label: "厥阴\(chartData[5])")
        
        yVals.add(entry1)
        yVals.add(entry2)
        yVals.add(entry3)
        yVals.add(entry4)
        yVals.add(entry5)
        yVals.add(entry6)
     
        //创建PieChartDataSet对象
        let set1: PieChartDataSet = PieChartDataSet.init(values: yVals as? [ChartDataEntry], label: "饼状图")
        set1.drawIconsEnabled = false //是否在饼状图上面显示图片
        set1.sliceSpace = 2 //相邻区块之间的间距
        set1.selectionShift = 8//选中区块时, 放大的半径
        set1.drawValuesEnabled = true //是否在饼状图上面显示数值
        set1.highlightEnabled = true //点击选饼状图是否有高亮效果，（单击空白处取消选中）
        set1.setColors(ZHFColor.red,ZHFColor.blue,ZHFColor.gray,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置柱形图颜色(是一个循环，例如：你设置5个颜色，你设置8个柱形，后三个对应的颜色是该设置中的前三个，依次类推)
        //  set1.setColors(ChartColorTemplates.material(), alpha: 1)
        //  set1.setColor(ZHFColor.gray)//颜色一致
        
        set1.xValuePosition = PieChartDataSet.ValuePosition.insideSlice//名称位置
        //PieChartDataSet.ValuePosition.insideSlice 数据显示在饼图内部  PieChartDataSet.ValuePosition.outsideSlice外部
        
        //外部条件下有折线
        set1.yValuePosition = PieChartDataSet.ValuePosition.insideSlice//数据位置
        //数据与区块之间的用于指示的折线样式
        set1.valueLinePart1OffsetPercentage = 0.85//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        set1.valueLinePart1Length = 0.5//折线中第一段长度占比
        set1.valueLinePart2Length = 0.4//折线中第二段长度最大占比
        set1.valueLineWidth = 1//折线的粗细
        set1.yValuePosition = .outsideSlice //这个折线外部展示
        set1.valueLineColor = ZHFColor.red//折线颜色
        
        let dataSets: NSMutableArray  = NSMutableArray.init()
        dataSets.add(set1)
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data:  PieChartData = PieChartData.init(dataSets: dataSets as? [IChartDataSet])
        let formatter: NumberFormatter = NumberFormatter.init()
        //formatter.numberStyle = NumberFormatter.Style.currency//自定义数据显示格式  小数点形式(可以尝试不同看效果)
        formatter.numberStyle = NumberFormatter.Style.percent //自定义数据显示格式  小数点形式(可以尝试不同看效果)
        formatter.maximumFractionDigits = 0
        formatter.multiplier = 1
        let forma :DefaultValueFormatter = DefaultValueFormatter.init(formatter: formatter)
        data.setValueFormatter(forma)
        data.setValueFont(UIFont.systemFont(ofSize: 10))
        data.setValueTextColor(ZHFColor.orange)
        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutExpo)
    }
    
   
    
    func addPieChart(view: UIViewController){
        pieChartView.backgroundColor = ZHFColor.white
        pieChartView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 300)
        pieChartView.center = view.view.center
        pieChartView.delegate = view as? ChartViewDelegate
        view.view.addSubview(pieChartView)
        //刷新按钮响应
        //refreshrBtn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
    }
    func setPieChartViewBaseStyle(title: String){
        //基本样式
        pieChartView.setExtraOffsets(left: 30, top: 30, right: 30, bottom: 0)//饼状图距离边缘的间隙
        pieChartView.usePercentValuesEnabled = true//是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.dragDecelerationEnabled = true//拖拽饼状图后是否有惯性效果
        pieChartView.drawSlicesUnderHoleEnabled = true//是否显示区块文本
        
        //空（实）心饼状图样式
        pieChartView.drawHoleEnabled = true//饼状图是否是空心 true为空心 false为实心
        pieChartView.holeRadiusPercent = 0.5//空心半径占比
        pieChartView.holeColor = ZHFColor.white//空心颜色 这个不能设置成clear
        pieChartView.transparentCircleRadiusPercent = 0.54//半透明空心半径占比
        pieChartView.transparentCircleColor = ZHFColor.zhf_colorAlpha(withHex: 0xffffff, alpha: 0.4)//半透明空心的颜色
        //饼状图中间描述
        if pieChartView.isDrawHoleEnabled == true {
            pieChartView.drawCenterTextEnabled = true
            pieChartView.centerText = ""
            //富文本
            //            let centerText : NSMutableAttributedString = NSMutableAttributedString.init(string: "饼状图")
            //            centerText.setAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.foregroundColor: ZHFColor.green], range: NSRange.init(location: 0, length: centerText.length))
            //            pieChartView.centerAttributedText = centerText
        }
        else{}
        //饼状图描述
        pieChartView.chartDescription?.text = title
        pieChartView.chartDescription?.font = UIFont.init(name: "Songti Tc", size: 18)!
        pieChartView.chartDescription?.textColor = ZHFColor.zhf33_titleTextColor
        //饼状图图例
        let l = pieChartView.legend
        l.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        l.formToTextSpace = 5 //文本间隔
        l.font = UIFont.systemFont(ofSize: 10)//字体大小
        l.textColor = ZHFColor.gray//字体颜色
        l.form = Legend.Form.circle//图示样式: 方形、线条、圆形
        //图例在饼状图中的位置(上局中、 水平布局)
        l.horizontalAlignment = Legend.HorizontalAlignment.center
        l.verticalAlignment = Legend.VerticalAlignment.top
        l.orientation = Legend.Orientation.horizontal //水平布局
        l.formSize = 12;//图示大小
    }
    
    func addBarChartView(view: UIViewController){
        barChartView.backgroundColor = ZHFColor.white
        barChartView.frame.size = CGSize.init(width: ScreenWidth - 20, height: 300)
        barChartView.center = view.view.center
        barChartView.delegate = self
        view.view.addSubview(barChartView)
        //刷新按钮响应
        //refreshrBtn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
    }
    
    func setBarChartViewBaseStyle(){
        //基本样式
        barChartView.noDataText = "暂无数据"//没有数据时的显示
        barChartView.drawValueAboveBarEnabled = true//数值显示是否在条柱上面
        barChartView.drawBarShadowEnabled = false//是否绘制阴影背景
        
        //交互设置 (把煮食逐个取消试试)
        //        barChartView.scaleXEnabled = false//取消X轴缩放
        barChartView.scaleYEnabled = false//取消Y轴缩放
        barChartView.doubleTapToZoomEnabled = false//取消双击是否缩放
        //        barChartView.pinchZoomEnabled = false//取消XY轴是否同时缩放
        barChartView.dragEnabled = true //启用拖拽图表
        barChartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        barChartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    }
    
    func setBarChartViewXY(){
        //1.X轴样式设置（对应界面显示的--->0月到7月）
        let xAxis: XAxis = barChartView.xAxis
        xAxis.valueFormatter = self as? IAxisValueFormatter //重写代理方法  设置x轴数据
        xAxis.axisLineWidth = 1 //设置X轴线宽
        xAxis.labelPosition = XAxis.LabelPosition.bottom //X轴（5种位置显示，根据需求进行设置）
        xAxis.drawGridLinesEnabled = false//不绘制网格
        xAxis.labelWidth = 4 //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)//x轴数值字体大小
        xAxis.labelTextColor = ZHFColor.brown//数值字体颜色
        
        //2.Y轴左样式设置（对应界面显示的--->0 到 100）
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.positiveSuffix = " $"  //数字前缀positivePrefix、 后缀positiveSuffix
        let leftAxis: YAxis = barChartView.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0     //最小值
        leftAxis.axisMaximum = axisMaximum   //最大值
        leftAxis.forceLabelsEnabled = true //不强制绘制制定数量的label
        leftAxis.labelCount = 6    //Y轴label数量，数值不一定，如果forceLabelsEnabled等于true, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.inverted = false   //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5   //Y轴线宽
        leftAxis.axisLineColor = ZHFColor.black   //Y轴颜色
        leftAxis.labelPosition = YAxis.LabelPosition.outsideChart//坐标数值的位置
        leftAxis.labelTextColor = ZHFColor.brown//坐标数值字体颜色
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10) //y轴字体大小
        //设置虚线样式的网格线(对应的是每条横着的虚线[10.0, 3.0]对应实线和虚线的长度)
        leftAxis.drawGridLinesEnabled = true //是否绘制网格线(默认为true)
        leftAxis.gridLineDashLengths = [10.0, 3.0]
        leftAxis.gridColor = ZHFColor.gray //网格线颜色
        leftAxis.gridAntialiasEnabled = true//开启抗锯齿
        leftAxis.spaceTop = 0.15//最大值到顶部的范围比
        //设置限制线
        let limitLine : ChartLimitLine = ChartLimitLine.init(limit: Double(axisMaximum * 0.85), label: "限制线")
        limitLine.lineWidth = 2
        limitLine.lineColor = ZHFColor.green
        limitLine.lineDashLengths = [5.0, 2.0]
        limitLine.labelPosition = ChartLimitLine.LabelPosition.rightTop//位置
        limitLine.valueTextColor = ZHFColor.zhf66_contentTextColor
        limitLine.valueFont = UIFont.systemFont(ofSize: 12)
        leftAxis.addLimitLine(limitLine)
        leftAxis.drawLimitLinesBehindDataEnabled  = true //设置限制线在柱线图后面（默认在前）
        
        //3.Y轴右样式设置（如若设置可参考左样式）
        barChartView.rightAxis.enabled = false //不绘制右边轴线
        
        //4.描述文字设置
        barChartView.chartDescription?.text = "柱形图"//右下角的description文字样式 不设置的话会有默认数据
        barChartView.chartDescription?.position = CGPoint.init(x: 80, y: 5)//位置（及在barChartView的中心点）
        barChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
        barChartView.chartDescription?.textColor = ZHFColor.orange
        
        //5.设置类型试图的对齐方式，右上角 (默认左下角)
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.textColor = ZHFColor.orange
        legend.font = UIFont.systemFont(ofSize: 11.0)
    }
  
}

extension SH_Charts :ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        ZHFLog(message: "点击选中")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        ZHFLog(message: "没有选中")
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        ZHFLog(message: "捏合放大或缩小")
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        ZHFLog(message: "拖拽图表")
    }
}


