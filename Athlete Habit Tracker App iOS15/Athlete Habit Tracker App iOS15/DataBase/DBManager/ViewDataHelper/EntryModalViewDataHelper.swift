//
//  EntryModalViewDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/6/10.
//

import Foundation


class EntryModalViewDataHelper{
    var optionModel: TraceOptionsDataModel
    var useDate : Date
    init(optionModel:TraceOptionsDataModel, useDate:Date)
    {
        self.optionModel = optionModel;
        let nextDate:TimeInterval = TimeInterval(-24*60*60*6)
        self.useDate = useDate.addingTimeInterval(nextDate)
        
    }
    func getInoputScore(index: Int) -> Int
    {
        do{
            let uDate = getWeekDate(index: index)
            let data = try TraceOptionsDetailDataHelper.findOneDay(date: uDate, optionId: optionModel.dataID);
            return data.inputScore;
        }catch _ {
            print("inster userModel error")
        }
        
        return 0;
    }
    func getWeekDate(index: Int) -> Date
    {
        let nextDate:TimeInterval = TimeInterval(24*60*60*index)
        let rDate = self.useDate.addingTimeInterval(nextDate)
        return rDate
    }
    func getDateString(index: Int) -> String
    {
        let nextDate:TimeInterval = TimeInterval(24*60*60*index)
        let rDate = self.useDate.addingTimeInterval(nextDate)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "M/d"
        let strWeekStart = timeFormatter.string(from:rDate) as String
        return strWeekStart
    }
}
