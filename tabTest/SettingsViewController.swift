import UIKit
import MediaPlayer
import AVFoundation

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var player = MPMusicPlayerController()
    var audioPlayer = AVAudioPlayer()
    
    // Tableで使用する配列を定義する.
    let dataInSection = [["バイブレーション", "音量"],["iPhoneからmusicを選択", "天使の夢", "夢見るクジラ", "南十字星","森を流れる川","春の予感","小春日和","スフィンクス","神々の宿る場所"]]
    
    // Sectionで使用する配列を定義する.
    private let mySections:[String] = ["音の設定", "音楽"]
    
    //AppDelegateのselectedMusicを呼び出す準備
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = MPMusicPlayerController.applicationMusicPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print(delegate.selectedMusic)
    }
    
    //セクションの数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  mySections.count
    }
    
    //セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section]
    }
    
    //音楽
    func playSound(soundName: String){
        let sounds = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3")!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: sounds)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch{
            print("Error getting the audio file")
            
        }
    }

    //セルが選択された際に呼び出される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //check selected row
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
            delegate.selectedMusic = "天使の夢"
//            playSound("天使の夢")
        } else if(indexPath.section == 1 && indexPath.row == 2) {
            delegate.selectedMusic = "夢見るクジラ"
//            playSound("夢見るクジラ")
        } else if(indexPath.section == 1 && indexPath.row == 3) {
            delegate.selectedMusic = "南十字星"
//            playSound("南十字星")
        } else if(indexPath.section == 1 && indexPath.row == 4) {
            delegate.selectedMusic = "森を流れる川"
//            playSound("森を流れる川")
        } else if(indexPath.section == 1 && indexPath.row == 5) {
            delegate.selectedMusic = "春の予感"
//            playSound("春の予感")
        } else if(indexPath.section == 1 && indexPath.row == 6) {
            delegate.selectedMusic = "小春日和"
//            playSound("小春日和")
        } else if(indexPath.section == 1 && indexPath.row == 7) {
            delegate.selectedMusic = "スフィンクス"
            playSound("スフィンクス")
        } else if(indexPath.section == 1 && indexPath.row == 8) {
            delegate.selectedMusic = "神々の宿る場所"
//            playSound("神々の宿る場所")
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
}
