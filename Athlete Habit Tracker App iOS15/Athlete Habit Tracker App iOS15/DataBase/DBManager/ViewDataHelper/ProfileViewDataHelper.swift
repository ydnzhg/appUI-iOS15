//
//  ProfileViewDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/6/8.
//

import Foundation

class ProfileViewDataHelper: ObservableObject {
    var optionsArray:[TraceOptionsDataModel]
    var detailArray:[TraceOptionsDetailDataModel]
    var useDate : Date
    //today
    init() {
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        useDate = Date();
        self.detailArray = [TraceOptionsDetailDataModel]()
        self.optionsArray = try! TraceOptionsDataHelper.findAll()!;
        self.optionsArray[0].palette = .lighterpurple;
        self.optionsArray[1].palette = .royalblue;
        self.optionsArray[2].palette = .orangehibiscus;
        self.optionsArray[3].palette = .maximumbluegreen;
        self.optionsArray[4].palette = .reptilegreen;
        self.optionsArray[5].palette = .fusionred;
        self.optionsArray[6].palette = .bluegrey;
        self.optionsArray[7].palette = .bluehorizon;
    }
    func inputGoal() -> Bool
    {
        var res = false;
        for m in optionsArray {
            if m.goal == 0
            {
                res = true
                break
            }
        }
        return res
    }
    func commitToOptionsDB()-> Bool {
        do {
            var res = true
            for item in  optionsArray {
                res = try TraceOptionsDataHelper.update(item: item)
            }
            return res
        } catch _ {
            print("inster userModel error")
        }
        
        return false
    }
}
