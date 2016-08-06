import UIKit
import MediaPlayer
import AVFoundation

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var player = MPMusicPlayerController()
    
    // Tableで使用する配列を定義する.
    let dataInSection = [["バイブレーション", "音量"],["iPhoneからmusicを選択", "天使の夢", "夢見るクジラ", "南十字星","森を流れる川","春の予感","小春日和","スフィンクス","神々の宿る場所"]]
    
    // Sectionで使用する配列を定義する.
    private let mySections:[String] = ["音の設定", "音楽"]
    
    // 音楽の設定
    let audioPath1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("天使の夢", ofType: "mp3")!)
    let audioPath2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("夢見るクジラ", ofType: "mp3")!)
    let audioPath3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("南十字星", ofType: "mp3")!)
    let audioPath4 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("森を流れる川", ofType: "mp3")!)
    let audioPath5 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("春の予感", ofType: "mp3")!)
    let audioPath6 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("小春日和", ofType: "mp3")!)
    let audioPath7 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("スフィンクス", ofType: "mp3")!)
    let audioPath8 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("神々の宿る場所", ofType: "mp3")!)
    
    // プレイヤーの準備
    var audioPlayer1 = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    var audioPlayer4 = AVAudioPlayer()
    var audioPlayer5 = AVAudioPlayer()
    var audioPlayer6 = AVAudioPlayer()
    var audioPlayer7 = AVAudioPlayer()
    var audioPlayer8 = AVAudioPlayer()




    override func viewDidLoad() {
        super.viewDidLoad()
        print("Settings Screen")
        
        player = MPMusicPlayerController.applicationMusicPlayer()
        // 曲再生の準備
        audioPlayer1 = try! AVAudioPlayer(contentsOfURL: audioPath1)
        audioPlayer1.prepareToPlay()
        audioPlayer2 = try! AVAudioPlayer(contentsOfURL: audioPath2)
        audioPlayer2.prepareToPlay()
        audioPlayer3 = try! AVAudioPlayer(contentsOfURL: audioPath3)
        audioPlayer3.prepareToPlay()
        audioPlayer4 = try! AVAudioPlayer(contentsOfURL: audioPath4)
        audioPlayer4.prepareToPlay()
        audioPlayer5 = try! AVAudioPlayer(contentsOfURL: audioPath5)
        audioPlayer5.prepareToPlay()
        audioPlayer6 = try! AVAudioPlayer(contentsOfURL: audioPath6)
        audioPlayer6.prepareToPlay()
        audioPlayer7 = try! AVAudioPlayer(contentsOfURL: audioPath7)
        audioPlayer7.prepareToPlay()
        audioPlayer8 = try! AVAudioPlayer(contentsOfURL: audioPath8)
        audioPlayer8.prepareToPlay()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //セクションの数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  mySections.count
    }
    
    //セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section]
    }
    
    //セルが選択された際に呼び出される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //swiftでの多重配列の扱いについて調べる
        if indexPath.section == 0 {
            print("Value: \(dataInSection[0][indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(dataInSection[1][indexPath.row])")
        }
        //sectionが1かつrowが0の時の処理を書こう
        if(indexPath.section == 1 && indexPath.row == 0){
            print("音楽を選ぶ処理を加える")
            let picker = MPMediaPickerController()
            picker.delegate = self
            picker.allowsPickingMultipleItems = false
            presentViewController(picker, animated: true, completion: nil)
            
        } else if(indexPath.section == 1 && indexPath.row == 1) {
            audioPlayer1.play()
        } else if(indexPath.section == 1 && indexPath.row == 2) {
            audioPlayer2.play()
        } else if(indexPath.section == 1 && indexPath.row == 3) {
            audioPlayer3.play()
        } else if(indexPath.section == 1 && indexPath.row == 4) {
            audioPlayer4.play()
        } else if(indexPath.section == 1 && indexPath.row == 5) {
            audioPlayer5.play()
        } else if(indexPath.section == 1 && indexPath.row == 6) {
            audioPlayer6.play()
        } else if(indexPath.section == 1 && indexPath.row == 7) {
            audioPlayer7.play()
        } else if(indexPath.section == 1 && indexPath.row == 8) {
            audioPlayer8.play()
        }
    }
    
    //メディアアイテムピッカーでアイテムを選択完了した時に呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        //選択した曲情報がmediaItemCollectionに入ってるのでこれをplayerにセット
        player.setQueueWithItemCollection(mediaItemCollection)
        //再生開始
        player.play()
        //ピッカーを閉じ破棄する
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //選択がキャンセルされた場合に呼び出される
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInSection[section].count
    }
    
    //各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        var test = dataInSection[indexPath.section]
        cell.textLabel?.text = test[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToTop" {
            //遷移先のコントローラを取り出す
            let nav = segue.destinationViewController as! UINavigationController
            let first = nav.topViewController as! FirstViewController
            first.test = "korosuke"
            
        }
    }
}
