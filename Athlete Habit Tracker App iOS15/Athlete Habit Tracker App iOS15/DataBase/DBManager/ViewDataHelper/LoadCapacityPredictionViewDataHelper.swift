//
//  RehabDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/6/8.
//

import Foundation


class LoadCapacityPredictionViewDataHelper {
    var dataType: DataInTime
    var date: Date
    var curType: Int
    init(dataType:DataInTime) {
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        
       // dataModel = try! RehabDataHelper.findOneDay(date: Date());
        self.date = Date()
        self.dataType = dataType
        if(dataType == DataInTime.LastWeek)
        {
            curType = 0
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*6)
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else if(dataType == DataInTime.LastTwoWeek)
        {
            let nowDate = Date()
            curType = 1
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*2-1))
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else
        {
            curType = 2
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*4-1))
            self.date = nowDate.addingTimeInterval(nextDate)
        }
    }
    func getDataTypeObj(type:Int) -> LoadCapacityPredictionViewDataHelper {
        if(type == self.curType)
        {
            return self
        }
        self.curType = type
        if(type == 0)
        {
            self.dataType = DataInTime.LastWeek
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*6)
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else if(type == 1)
        {
            self.dataType = DataInTime.LastTwoWeek
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*2-1))
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else
        {
            self.dataType = DataInTime.LastMonth
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*4-1))
            self.date = nowDate.addingTimeInterval(nextDate)
        }
        return self
    }
    func getDataTypeCount() -> Int{
        if(dataType == DataInTime.LastWeek)
        {
            return 7
        }else if(dataType == DataInTime.LastTwoWeek)
        {
            return 14
        }
        
        return 28
    }
    func getDate(index: Int) -> Date
    {
        let nextDate:TimeInterval = TimeInterval(24*60*60*index)
        let rDate = self.date.addingTimeInterval(nextDate)
        return rDate
    }
    func getRehabDataIndex(index: Int) -> RehabDataModel
    {
        do{
            let uDate = getDate(index: index)
            let dataModel = try RehabDataHelper.findOneDay(date: uDate);
            return dataModel

        }catch _ {
            print("inster userModel error")
        }
        
        return RehabDataModel();
    }
    func getLoadArray() ->[Double]
    {
        var retArray = [Double]()
        for index  in 0...self.getDataTypeCount() - 1 {
            let v = self.getRehabDataIndex(index: index)
            retArray.append(v.intensity * Double(v.sets))
        
        }
        
        return retArray
    }
    func getRecoveryArray() ->[Double]
    {
        var retArray = [Double]()
        let dataHelper = ProgressViewDataHelper(dataType: dataType)
        for index  in 0...self.getDataTypeCount() - 1 {
            var total: Double = 0
            for optionIndex in 0...dataHelper.optionsArray.count - 1
            {
 
                total += (Double(dataHelper.getDetailModel(index: index, optionId: optionIndex + 1).inputScore) / Double(dataHelper.optionsArray[optionIndex].goal)) * Double(100)
               
            }
           
            retArray.append(total/8)
        
        }
        
        return retArray
    }
    func getPainArray() ->[Double]
    {
        var retArray = [Double]()
        for index  in 0...self.getDataTypeCount() - 1 {
            let v = self.getRehabDataIndex(index: index)
            retArray.append(v.pain * 10)
        
        }
        
        return retArray
    }
}
