import UIKit
import RealmSwift

class Chart2ViewController: UIViewController {
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    let realm = try! Realm()
    let diaryDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickButton(sender: AnyObject) {
        myLabel.text = "押してる"
    }

}
