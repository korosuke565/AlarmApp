import UIKit
import RealmSwift


class ChartViewController: UIViewController {
    
    let realm = try! Realm()
    let diaryDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func clickButton(sender: AnyObject) {
        myLabel.text = "こんにちわ"
    }
    
    
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shakeArray = [CGFloat?]()
        for diaryData in diaryDatas {
            shakeArray.append(CGFloat(diaryData.shakecount))
            //条件分岐で7つだけにする
            if shakeArray.count > 6  {
                break
            }
        }
        graphView.setupPoints([10,2,3,4,3,2,1],days: ["8/7","8/8","8/9","8/10","8/11","8/12","8/13"])
    }
    
    @IBAction func changeSegument(sender: AnyObject) {
    }
    

}

