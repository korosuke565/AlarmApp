//
//  SleepLog.swift
//  tabTest
//
//  Created by TsuyoshiTonobe on 2016/03/10.
//  Copyright © 2016年 TsuyoshiTonobe. All rights reserved.
//

import RealmSwift

class SleepLog: Object {
    
    //プライマリーキー
    dynamic var id = 0
    
    //睡眠時間
    dynamic var sleeptime = 0
    
    //シェイクカウント
    dynamic var shakecount = 0
    
    //日付
    dynamic var date = NSDate()
    
    //idをプライマリキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }

}
