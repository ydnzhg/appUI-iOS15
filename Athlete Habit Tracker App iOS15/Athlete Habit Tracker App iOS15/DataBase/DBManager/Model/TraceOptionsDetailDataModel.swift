//
//  TraceOptionsDetailDataModel.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/5/29.
//

import Foundation
import UIKit
import SQLite

/// TraceOptionsDetailDataModel
struct TraceOptionsDetailDataModel {

    var detailID: Int = 0
    var optionId: Int = 0
    var optionName: String = ""
    var inputScore: Int = 0
    var score: Int = 0
    var unit : String = ""
    var createTime:Date = Date() //

    init() {}
    
    init(detailID: Int, optionId: Int,optionName: String,inputScore: Int, score: Int,unit : String,createTime:Date) {
        self.detailID = detailID
        self.optionId = optionId
        self.optionName = optionName
        self.score = score
        self.unit = unit
        self.createTime = createTime
        self.inputScore = inputScore

    }
}
/*
class TraceOptionsDetailDataObject: ObservableObject {
    @Published var sleepGoal: Int
    @Published var hydrationGoal: Int
    @Published var proteinGoal: Int
    @Published var calorieGoal: Int
    @Published var stretchingGoal: Int
    @Published var workoutGoal: Int
    @Published var weightGoal: Int
    @Published var heartrateGoal: Int
    var retArray:[TraceOptionsDetailDataModel]
    init() {
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        
        self.retArray = try! TraceOptionsDetailDataHelper.findOneDay(date: Date());
        self.sleepGoal = self.retArray[0].score;
        self.hydrationGoal = self.retArray[1].score;
        self.proteinGoal = self.retArray[2].score;
        self.calorieGoal = self.retArray[3].score;
        self.stretchingGoal = self.retArray[4].score;
        self.workoutGoal = self.retArray[5].score;
        self.weightGoal = self.retArray[6].score;
        self.heartrateGoal = self.retArray[7].score;
    }
    func commitToDB()-> Bool {
        /*do {
            retArray[0].goal = sleepGoal
            retArray[1].goal = hydrationGoal
            retArray[2].goal = proteinGoal
            retArray[3].goal = calorieGoal
            retArray[4].goal = stretchingGoal
            retArray[5].goal = workoutGoal
            retArray[6].goal = weightGoal
            retArray[7].goal = heartrateGoal
            var res = true
            for item in  retArray {
                res = try TraceOptionsDataHelper.update(item: item)
            }
            return res
        } catch _ {
            print("inster userModel error")
        }*/
        
        return false
    }
}*/
