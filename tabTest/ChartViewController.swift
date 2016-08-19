import UIKit
import RealmSwift

class ChartViewController: UIViewController {
    
    
    //Realmインスタンスを生成
    let realm = try! Realm()
    let diaryDatas = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    
    
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
        graphView.setupPoints([10,2,3,4,3,2,1])
    }

}

