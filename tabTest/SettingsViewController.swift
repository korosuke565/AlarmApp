//
//  ThirdViewController.swift
//  tabTest
//
//  Created by TsuyoshiTonobe on 2016/02/19.
//  Copyright © 2016年 TsuyoshiTonobe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //とりあえず3個の値を返す
        return 3
    }
    
    //各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //セルのスタイルを設定する
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        //switch文に後で変更
        var identifier = ""
        if indexPath.row == 0 {
            //各セルに値を設定する
            cell.textLabel?.text = "アラーム"
            identifier = "Cell1"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "音楽"
            identifier = "Cell2"
        } else {
            cell.textLabel?.text = "朝への意気込み"
            identifier = "Cell3"
        }
        
        //後で変更
//        let cell = tableView.dequeueReusableCellWithIdentifier() as UITableViewCell
        return cell
    }

}
