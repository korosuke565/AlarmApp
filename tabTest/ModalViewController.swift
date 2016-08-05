//
//  ModalViewController.swift
//  tabTest
//
//  Created by TsuyoshiTonobe on 2016/02/24.
//  Copyright © 2016年 TsuyoshiTonobe. All rights reserved.
//

import UIKit
import AVFoundation

class ModalViewController: UIViewController {
    //起床時間
    var wakeUpTime : NSDate? = nil
    
    
    // 音ファイルのpathの設定
    var audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test", ofType: "mp3")!)
    // プレイヤーの準備
    var player = AVAudioPlayer()

    
    // FirstViewControllerからの値を保持する変数
    var receiveTime = ""
    var modalBedTime : NSDate? = nil

    @IBOutlet weak var receiveTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // ラベルにアラーム時刻の貼り付け
        self.receiveTimeLabel.text = self.receiveTime
        
        // 時間の管理
        _ = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "update", userInfo: nil, repeats: true)
        
        // 曲再生の準備
        player = try! AVAudioPlayer(contentsOfURL: audioPath)
        player.prepareToPlay()
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
        //アラームの再生
        player.play()
    
    }
    
    
    func alermStop() {
        player.stop()
        //曲を頭に戻す
        player.currentTime = 0
        //起床時間を取得
        wakeUpTime = NSDate()
        
        self.performSegueWithIdentifier("GameSegue", sender: nil)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GameSegue" {
            //遷移先のコントローラを取り出す
            let game = segue.destinationViewController as! GameViewController
            game.bedTime = modalBedTime
            game.wakeUpTime = wakeUpTime

        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
