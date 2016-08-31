import UIKit
import RealmSwift
import PySwiftyRegex

class Chart2ViewController: UIViewController {
    

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let dateFormatter = NSDateFormatter()
    
    var dateArray = [String]()
    var shakeCount = [Int]()
    
    let realm = try! Realm()
    let sleepDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    //ダミーデータ
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var stringDate: String
//        for sleepData in sleepDatas {
//            dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
//            dateFormatter.dateFormat = "MM/dd"
//            stringDate = dateFormatter.stringFromDate(sleepData.date)
//            dateArray.insert(stringDate, atIndex: 0)
//            shakeCount.insert(sleepData.shakecount, atIndex: 0)
//            
//            //条件分岐で7つだけにする
//            if dateArray.count > 6 {
//                break
//            }
//        }
        
        
        dataFromDB()

        if shakeCount == [] {
            graphView.setupPoints([],days: [])
        } else {
            graphView.setupPoints(shakeCount,days: dateArray)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataFromDB(num:Int = 6) {
        var stringDate: String
        var monthNum = "test"
        for sleepData in sleepDatas {
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
            dateFormatter.dateFormat = "MM/dd"
            stringDate = dateFormatter.stringFromDate(sleepData.date)
            dateArray.insert(stringDate, atIndex: 0)
            shakeCount.insert(sleepData.shakecount, atIndex: 0)
            
            //条件分岐で7つだけにする
            if dateArray.count > num {
                break
            }

            if num > 29 {
                print(stringDate)
                let regex = re.compile("/")
                let test = regex.split(stringDate)
                if monthNum == test[0] || monthNum ==  "test" {
                    print("same number")
                } else {
                    print("else number")
                    dateArray.removeFirst()
                    shakeCount.removeFirst()
                    print(dateArray)
                    break
                }
                monthNum = test[0]!

            }
        }
    }
    
    func labelInitialization() {
        for subview in self.graphView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    
    @IBAction func changeSelect(sender: AnyObject) {
        let num = segmentedControl.selectedSegmentIndex
        //switch文
        switch num {
            case 0:
                labelInitialization()
                if shakeCount == [] {
                    graphView.setupPoints([],days: [])
                } else {
                    graphView.setupPoints(shakeCount,days: dateArray)
            }
            case 1:
                //月の場合はmemoriをいれない
                labelInitialization()
                let num = sleepDatas.count
                print(num)
                dataFromDB(num)
                if shakeCount == [] {
                    graphView.setupPoints(shakeCount, days: dateArray)
                } else {
                    graphView.setupPoints(shakeCount, days: [])
                }
            case 2:
                labelInitialization()
                graphView.setupPoints([10,24,30,40,30,100,1],days: ["8","9","10","11","12","1","2","3","4","5","6","7"])
            default:
                graphView.setupPoints([10,2,3,4,3],days: ["8/7","8/8","8/9","8/10","8/11"])
        }
    }
}