//
//  GameViewController.swift
//  tabTest
//
//  Created by TsuyoshiTonobe on 2016/02/25.
//  Copyright © 2016年 TsuyoshiTonobe. All rights reserved.
//

import UIKit
import CoreMotion
import RealmSwift
import Foundation

class GameViewController: UIViewController {
    
    // ModalViewControllerからの値を保持する変数
    var bedTime : NSDate? = nil
    var wakeUpTime : NSDate? = nil
    
    //Realmインスタンスを生成
    let realm = try! Realm()
    let dataArray = try! Realm().objects(SleepLog).sorted("date", ascending: false)

    
    //残り時間
    var timeLeft : Float = 10
    //shakecount
    var counter = 0
    //dbに保存するカウント
    var saveCount = 0
    //タイマーを作る
    var timer = NSTimer.init()
    
    
    //振った回数を表示するラベル
    @IBOutlet weak var counterLabel: UILabel!
    //残り時間を表示するラベル
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    let motionManager = CMMotionManager()
    var lastAccelerometer: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        
        //加速度センサの更新間隔を0.1秒とする
        motionManager.accelerometerUpdateInterval = 0.1
        
        //accelerometerUpdateIntervalで設定した更新間隔ごとにハンドラが呼び出される
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (accelerometerData, error) -> Void in
            let x = accelerometerData!.acceleration.x
            let y = accelerometerData!.acceleration.y
            let z = accelerometerData!.acceleration.z
            
            
            //傾きの合計
            let accelerometer = abs(x + y + z - self.lastAccelerometer)
            
            if(accelerometer > 0.5 && self.timeLeft > 0.0) {
                self.counterLabel.text = String(self.counter++)
            }
            
            //値を覚える
            self.lastAccelerometer = x + y + z
        }

    }
    
    //残り時間を計測
    func onUpdate(timer : NSTimer) {
        timeLeft -= 1
        
        //桁数を指定して文字列を作る.
        let str = "残り時間:".stringByAppendingFormat("%.1f",timeLeft)
        
        timeLeftLabel.text = str
        //タイマーが終わった後の処理
        //twitterを走らせて共有
        if timeLeft == 0.0 {
            timer.invalidate()
            saveCount = counter - 1
            //カウントが何回できたかを知らせるアラートメニュー
            alert()
            print(bedTime)
        }
    }
    
    func alert(){
        // アラートを作成
        let title = "AlertViewsSample"
        let message = "今日のcountは\(saveCount)です"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // OKボタンを作成&追加
        let ok = UIAlertAction(title:"Twitterに投稿", style: .Default, handler: nil)
        alert.addAction(ok)
        
        // いいえボタンを作成&追加
        let no = UIAlertAction(title:"いいえ", style: .Default, handler: {
            action in self.backToTop()})
        alert.addAction(no)
        
        //アラートを表示
        presentViewController(alert,animated: true, completion: nil)

        
    }
    
    func backToTop() {
        //睡眠時間
        var mySleepTime = Int(wakeUpTime!.timeIntervalSinceDate(bedTime!))
        print("今日の睡眠時間は" + String(mySleepTime))

        //DBへの書き込み
        var sleepLog = SleepLog()
        sleepLog.sleeptime = mySleepTime
        sleepLog.shakecount = saveCount
        sleepLog.date = NSDate()
        if dataArray.count != 0 {
            sleepLog.id = dataArray.max("id")! + 1
        }
        
        try! realm.write{
            realm.add(sleepLog)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

