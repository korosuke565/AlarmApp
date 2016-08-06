import UIKit
import MediaPlayer

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var player = MPMusicPlayerController()
    
    // Tableで使用する配列を定義する.
    let dataInSection = [["バイブレーション", "音量"],["iPhoneからmusicを選択", "musicB", "musicC", "musicD"]]
    
    // Sectionで使用する配列を定義する.
    private let mySections:[String] = ["音の設定", "音楽"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = MPMusicPlayerController.applicationMusicPlayer()

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
