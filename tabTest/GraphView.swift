import UIKit
import RealmSwift

@IBDesignable class GraphView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    
    var dateArray = [String]()
    var shakeCount = [Int]()
    
    
    // グラフのプロットデータ設定用のメソッド
    func setupPoints(points: [Int]?, days: [String]?) {
        shakeCount = points!
        if days != nil  {
             dateArray = days!
        }
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        
        // グラデーション
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.AllCorners,
                                
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        //角丸
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  colors,
                                                  colorLocations)
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    .DrawsBeforeStartLocation)
        
        
        // X座標の計算
        let margin:CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
            
            let spacer = (width - margin*2 - 4) /
                CGFloat((self.shakeCount.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // Y座標の計算
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - (topBorder + bottomBorder)
        let maxValue = shakeCount.maxElement() ?? 1
        let columnYPoint = { (graphPoint:Int) -> CGFloat in
            
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        var maxData = shakeCount.maxElement()
        var minData = shakeCount.minElement()
        
        
        
        func lineGraph() {
            let graphPath = UIBezierPath()
            
            graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
                y:columnYPoint(shakeCount[0])))
            
            
            for i in 1..<shakeCount.count {
                let nextPoint = CGPoint(x:columnXPoint(i),
                                        y:columnYPoint(shakeCount[i]))
                graphPath.addLineToPoint(nextPoint)
            }
            // 塗りつぶしと色の設定
            UIColor.whiteColor().setFill()
            UIColor.whiteColor().setStroke()
            graphPath.stroke()
            // 高さの調整
            let highestYPoint = columnYPoint(maxValue)
            startPoint = CGPoint(x:margin, y: highestYPoint)
            endPoint = CGPoint(x:margin, y:self.bounds.height)
            
            CGContextDrawLinearGradient(context,
                                        gradient,
                                        startPoint,
                                        endPoint,
                                        .DrawsBeforeStartLocation)
            
            graphPath.lineWidth = 2.0
            graphPath.stroke()

            
        }
        
        
        
        // ドットの描画
        func graphDots() {
            for i in 0..<shakeCount.count {
                var point = CGPoint(x:columnXPoint(i), y:columnYPoint(shakeCount[i]))
                point.x -= 5.0/2
                point.y -= 5.0/2
                
                let circle = UIBezierPath(ovalInRect:
                    CGRect(origin: point,
                        size: CGSize(width: 5.0, height: 5.0)))
                
                circle.fill()
            }
        }
        
        
        //横線
        func holizontalLine() {
            let linePath = UIBezierPath()
            linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
            linePath.addLineToPoint(CGPoint(x: width - margin,
                y:topBorder))
            
            
            // 中央のラインの描画
            linePath.moveToPoint(CGPoint(x:margin,
                y: graphHeight/2 + topBorder))
            linePath.addLineToPoint(CGPoint(x:width - margin,
                y:graphHeight/2 + topBorder))
            
            
            // 下のラインの描画
            linePath.moveToPoint(CGPoint(x:margin,
                y:height - bottomBorder))
            linePath.addLineToPoint(CGPoint(x:width - margin,
                y:height - bottomBorder))
            
            //線の設定
            let color = UIColor(white: 1.0, alpha: 0.3)
            color.setStroke()
            linePath.lineWidth = 1.0
            linePath.stroke()
        }
        
        //グラフタイトル
        func graphTitle(title: String) {
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(15)
            
            //ラベルのサイズを取得
            let frame = CGSizeMake(250, CGFloat.max)
            let rect = label.sizeThatFits(frame)
            
            //ラベルの位置
            let lebelX = CGFloat(20)
            let labelY = CGFloat(30)
            
            label.frame = CGRectMake(lebelX , labelY, rect.width, rect.height)
            
            self.addSubview(label)
        
        }
        
        //データがない時のメッセージ
        func initialGraphMessage(title: String) {
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(20)
            
            //ラベルのサイズを取得
            let frame = CGSizeMake(250, CGFloat.max)
            let rect = label.sizeThatFits(frame)
            
            //ラベルの位置
            let lebelX = width / 2 - 90
            let labelY = height / 2 - 10
            
            label.frame = CGRectMake(lebelX , labelY, rect.width, rect.height)
            
            self.addSubview(label)
            
        }

        
        //グラフの日付
        func graphDate() {
            guard dateArray.count == 0 else {
                for i in 0...dateArray.count - 1 {
                    let label = UILabel()
                    if label.text != "" {
                        label.removeFromSuperview()
                    }
                    label.text = String(dateArray[i])
                    label.textColor = UIColor.whiteColor()
                    label.font = UIFont.systemFontOfSize(9)
                    
                    //ラベルのサイズを取得
                    let frame = CGSizeMake(250, CGFloat.max)
                    let rect = label.sizeThatFits(frame)
                    
                    //ラベルの位置
                    var lebelX = columnXPoint(i) - 8
                    var labelY = height - bottomBorder + 20
                    
                    label.frame = CGRectMake(lebelX , labelY, rect.width, rect.height)
                    
                    for subview in label.subviews{
                        subview.removeFromSuperview()
                    }
                    
                    self.addSubview(label)
                }
                return
            }
        }
        //もしデータがなかったらという条件式を書く
        if shakeCount.count == 0 {
            initialGraphMessage("データを登録しよう!")
        } else {
            lineGraph()
            graphDots()
            holizontalLine()
            graphTitle("ShakeCount")
            graphDate()
        }
    }
}
