import UIKit
import RealmSwift

class Chart2ViewController: UIViewController {
    

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
    
    @IBAction func changeSelect(sender: AnyObject) {
        let num = segmentedControl.selectedSegmentIndex
        //switch文
        switch num {
            case 0:
                print("週だよ")
                graphView.setupPoints([10,2,3,4,3,2,1],days: ["8/7","8/8","8/9","8/10","8/11","8/12","8/13"])
            case 1:
//                graphView.setupPoints([10,2,3,4,3,2,1,10,2,3,4,3,2,1],days: ["8/7","8/8","8/9","8/7","8/8","8/9","8/10","8/11","8/12","8/13","8/14","8/15","8/16","8/17"])
                graphView.setupPoints([10,2,3,4,3,2,1,10,2,3,4,3,2,1],days:[])
            case 2:
                print("年だよ")
                graphView.setupPoints([10,24,30,40,30,100,1],days: ["8","9","10","11","12","1","2"])
            default:
                print("週だよ")
                graphView.setupPoints([10,2,3,4,3,2,1],days: ["8/7","8/8","8/9","8/10","8/11","8/12","8/13"])
        }
    }
}