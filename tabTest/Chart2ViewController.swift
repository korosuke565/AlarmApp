import UIKit
import RealmSwift

class Chart2ViewController: UIViewController {
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    var dateArray = [String]()
    var shakeCount = [Int]()
    
    let realm = try! Realm()
    let sleepDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "MM/dd"
        
        var stringDate: String
        for sleepData in sleepDatas {
            stringDate = dateFormatter.stringFromDate(sleepData.date)
            dateArray.insert(stringDate, atIndex: 0)
            shakeCount.insert(sleepData.shakecount, atIndex: 0)
            
            //条件分岐で7つだけにする
            if dateArray.count > 6 {
                break
            }
        }

        if shakeCount == [] {
            graphView.setupPoints([10,2,3,4,3,2,1],days: ["8/7","8/8","8/9","8/10","8/11","8/12","8/13"])
        } else {
            graphView.setupPoints(shakeCount,days: dateArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickButton(sender: AnyObject) {
        myLabel.text = "押してる"
    }

}
