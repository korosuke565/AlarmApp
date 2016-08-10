import UIKit
import AVFoundation
import AudioToolbox

class ModalViewController: UIViewController {
    //起床時間
    var wakeUpTime : NSDate? = nil
    var audioPlayer = AVAudioPlayer()
    var soundName = "kara"
    //AppDelegate変数を呼び出す準備
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // FirstViewControllerからの値を保持する変数
    var receiveTime = ""
    var modalBedTime : NSDate? = nil
    //vibeに関する変数
    var timer = NSTimer()

    @IBOutlet weak var receiveTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // ラベルにアラーム時刻の貼り付け
        self.receiveTimeLabel.text = self.receiveTime
        
        // 時間の管理
        _ = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print(delegate.selectedMusic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // アラームを鳴らすか判断
        myAlarm(str)
        
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

    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == receiveTime {
            alert()
        }
    }
    
    func alert(){
        // アラートを作成
        let title = "AlertViewsSample"
        let message = "朝です起きてください"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // OKボタンを作成&追加
        let ok = UIAlertAction(title:"ゲーム開始", style: .Default, handler: {
            action in self.alermStop()
        })
        alert.addAction(ok)
        
        //アラートを表示
        presentViewController(alert,animated: true, completion: nil)
        //alarm
        if delegate.selectedMusic == "iphone" {
            //iphoneから選択された音楽を再生
            delegate.player.play()
        } else {
            playSound(delegate.selectedMusic)
        }
        //vibe
        if delegate.vibeSwitch == true {
            viSwitch()
        }
    }
    
    
    func alermStop() {
        
        if delegate.selectedMusic == "iphone" {
            //iphoneから選択された音楽を再生
            delegate.player.stop()
        } else {
            audioPlayer.stop()
            //曲を頭に戻す
            audioPlayer.currentTime = 0
        }
        //タイマーの停止
        timer.invalidate()
        //起床時間を取得
        wakeUpTime = NSDate()
        
        self.performSegueWithIdentifier("GameSegue", sender: nil)

    }
    
    //sound
    func playSound(soundName: String = "test"){
        let sounds = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3")!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: sounds)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch{
            print("Error getting the audio file")
            
        }
    }
    
    //vibration
    func viSwitch(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "vibrate:", userInfo: nil, repeats: true)

        timer.fire()
    }
    
    func vibrate(timer: NSTimer) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GameSegue" {
            //遷移先のコントローラを取り出す
            let game = segue.destinationViewController as! GameViewController
            game.bedTime = modalBedTime
            game.wakeUpTime = wakeUpTime

        }
    }
}
