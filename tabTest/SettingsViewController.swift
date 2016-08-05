import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Tableで使用する配列を定義する.
    let dataInSection = [["バイブレーション", "音量"],["musicA", "musicB", "musicC", "musicD"]]
    
    // Sectionで使用する配列を定義する.
    private let mySections:[String] = ["音の設定", "音楽"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
