import UIKit
import RealmSwift
import PySwiftyRegex

class Chart2ViewController: UIViewController {
    

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let dateFormatter = NSDateFormatter()
    
    var dateArray = [String]()
    var shakeCount = [Int]()
    var monthRemoveZero = 1
    var yearDict:[Int:[Int]] = [
        1 : [],2 : [],3 : [],4 : [],5 : [],6 : [],7 : [],8 : [],9 : [],
        10 : [], 11 : [], 12 : []]
    var maxDict:[Int:Int] = [
        1 : 0, 2 : 0, 3 : 0, 4 : 0, 5 : 0, 6 : 0, 7 : 0, 8 : 0, 9 : 0, 10 : 0,
        11 : 0, 12 : 0]
    var monthList = [Int]()
    var uniqueMonthList = [Int]()
    
    let realm = try! Realm()
    let sleepDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    //ダミーデータ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func dataFromDB(num:Int = 6,attribute:Int = 0) {
        yearDict = [
            1 : [],2 : [],3 : [],4 : [],5 : [],6 : [],7 : [],8 : [],9 : [],
            10 : [], 11 : [], 12 : []]
        var stringDate: String
        var monthNum = "test"
        let regex = re.compile("/")
        for sleepData in sleepDatas {
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
            dateFormatter.dateFormat = "MM/dd"
            stringDate = dateFormatter.stringFromDate(sleepData.date)

            let day_list = regex.split(stringDate)
            dateArray.insert(stringDate, atIndex: 0)
            shakeCount.insert(sleepData.shakecount, atIndex: 0)
            
            //条件分岐で7つだけにする
            if dateArray.count > num {
                break
            }
            
            switch attribute {
            case 0:
                fallthrough
            case 1:
                //guardで書き直し
                if monthNum == day_list[0] || monthNum ==  "test" {
                } else {
                    dateArray.removeFirst()
                    shakeCount.removeFirst()
                    break
                }
                monthNum = day_list[0]!
            case 2:
                //monthNumをチェックして同じ月かの確認
                let monthInt = Int(monthNum)
                if monthInt != nil {
                    monthList.insert(monthInt!, atIndex: 0)
                }
                
                if monthNum == day_list[0] || monthNum ==  "test" {
                    //先頭が0で始まる月を見つけている
                    let pattern = "^[0]\\d"
                    if (re.match(pattern, monthNum) != nil) {
                        monthRemoveZero = Int((monthNum as NSString).substringFromIndex(1))!
                        yearDict[monthRemoveZero]!.insert(sleepData.shakecount, atIndex: 0)
                    }
                }
                
                let orderSet = NSOrderedSet(array: monthList)
                uniqueMonthList = orderSet.array as! [Int]
                monthNum = day_list[0]!
            default:
                print("test")
            }
        }
        if attribute == 2 {
            dateArray = []
            shakeCount = []
            for i in uniqueMonthList {
                maxDict[i] = yearDict[i]?.maxElement()
                dateArray.append(String(i))
            }
            var keys : Array = Array(maxDict.keys)
            keys.sortInPlace({$0 < $1})
            for sortKey in keys {
                if maxDict[sortKey] != 0 {
                    shakeCount.append(maxDict[sortKey]!)
                }
            }
        }
    }

    
    func labelInitialization() {
        for subview in self.graphView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func dataInitialization() {
        dateArray = []
        shakeCount = []
    }
    
    @IBAction func changeSelect(sender: AnyObject) {
        let num = segmentedControl.selectedSegmentIndex
        //switch文
        switch num {
            case 0:
                labelInitialization()
                dataInitialization()
                dataFromDB()
                print(dateArray)
                if shakeCount == [] {
                    graphView.setupPoints([],days: [])
                } else {
                    graphView.setupPoints(shakeCount,days: dateArray)
            }
            case 1:
                //月の場合はmemoriをいれない
                labelInitialization()
                dataInitialization()
                let num = sleepDatas.count
                dataFromDB(num, attribute: 1)
                if shakeCount == [] {
                    graphView.setupPoints([], days: [])
                } else {
                    graphView.setupPoints(shakeCount, days: [])
                }
            case 2:
                labelInitialization()
                dataInitialization()
                let num = sleepDatas.count
                dataFromDB(num, attribute: 2)
                if shakeCount == [] {
                    graphView.setupPoints([], days: [])
                } else {
                    graphView.setupPoints(shakeCount, days: dateArray)
                }
            default:
                labelInitialization()
                dataInitialization()
                dataFromDB()
                if shakeCount == [] {
                    graphView.setupPoints([],days: [])
                } else {
                    graphView.setupPoints(shakeCount,days: dateArray)
            }

        }
    }
}