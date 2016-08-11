import UIKit
import AVFoundation
import AudioToolbox

class ModalViewController: UIViewController {
    //起床時間
    var wakeUpTime : NSDate? = nil
    var audioPlayer = AVAudioPlayer()
    var soundName = "kara"
    var alarmSwitch = true
    //AppDelegate変数を呼び出す準備
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // FirstViewControllerからの値
    var receiveTime = ""
    var modalBedTime : NSDate? = nil
    //timer処理
    var timer = NSTimer()
    var wakeTiemr = NSTimer()
    

    @IBOutlet weak var receiveTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // ラベルにアラーム時刻の貼り付け
        self.receiveTimeLabel.text = self.receiveTime
        
        // 時間の管理
         wakeTiemr = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "update", userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // alarmSwithc = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // アラームを鳴らすか判断
        print("現在の時刻は" + str)
        print("設定時刻は" + receiveTime)
        if str == receiveTime {
            alert()
            wakeTiemr.invalidate()
        }

        
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
