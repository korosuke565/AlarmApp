//
//  SecondViewController.swift
//  tabTest
//
//  Created by TsuyoshiTonobe on 2016/02/19.
//  Copyright © 2016年 TsuyoshiTonobe. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    //Realmインスタンスを生成
    let realm = try! Realm()
    
    //日記データが格納される配列
    let dataArray = try! Realm().objects(SleepLog).sorted("date", ascending: false)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //セルのスタイルを設定する
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        //セルに値を設定する
        let object = dataArray[indexPath.row]
        cell.textLabel?.text = String(object.shakecount) + "シェイク"
        cell.detailTextLabel?.text = object.date.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    //Deleteボタン押した時の処理
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            try! realm.write {
                self.realm.delete(self.dataArray[indexPath.row])
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }


}

