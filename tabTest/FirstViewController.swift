import UIKit
import RealmSwift

class FirstViewController: UIViewController{
    
    
    //Realmインスタンスを生成
    let realm = try! Realm()
    
    @IBOutlet weak var myDP: UIDatePicker!
    @IBOutlet weak var myLabel: UILabel!
    
    //private?
    private var tempTime: String = "00:00"
    private var setTime: String = "00:00"
    var bedTime : NSDate? = nil
    
    @IBAction func myDpFunc(sender: AnyObject) {
        // DPの値を成形
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        var strDate = format.stringFromDate(myDP.date)
        
        //日時を時間の型へ
        var dateda = format.dateFromString(strDate)
        //30分前の時刻を取得
        var halfTimeAgo = NSDate(timeInterval: -60 * 30, sinceDate: dateda!)
        //string型に変換
        var strHalfTimeAgo = format.stringFromDate(halfTimeAgo)
        //表示時刻
        var alarmTime = strHalfTimeAgo + "-" + strDate
        //ラベルへ表示
        self.myLabel.text = alarmTime
        //一時的にDPの値を保持
        tempTime = format.stringFromDate(myDP.date)
        
    }
    
    @IBAction func myButtonFunc(sender: AnyObject) {
        //就寝時間
        bedTime = NSDate()
        //アラームセット
        setTime = tempTime
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view, typically from a nib.
        
        // 起動した時点の時刻をmyLabelに反映
        // 時間の管理
        _ = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "update", userInfo: nil, repeats: true)
        
    }
    
    func getNowTime() -> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // NSDateFormatterで文字列に成形する
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.stringFromDate(nowTime)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // アラームを鳴らすか判断
        myAlarm(str)
    
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == setTime {
            alert()
        }
    }
    
    func alert() {
        let myAlert = UIAlertController(title: "alert", message: "時間です。起きてください", preferredStyle: .Alert)
        let myAction = UIAlertAction(title: "dong", style: .Default) {
            action in print("foo")
        }
        
        myAlert.addAction(myAction)
        presentViewController(myAlert, animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(segue:UIStoryboardSegue){
    }
    
    //セグエに移動する時に呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NextSegue" {
            //遷移先のコントローラを取り出す
            //let modal = segue.destinationViewController as! ModalViewController
            
            let nav = segue.destinationViewController as! UINavigationController
            let modal = nav.topViewController as! ModalViewController
            modal.receiveTime = self.setTime
            modal.modalBedTime = self.bedTime
        
        }
    }
}