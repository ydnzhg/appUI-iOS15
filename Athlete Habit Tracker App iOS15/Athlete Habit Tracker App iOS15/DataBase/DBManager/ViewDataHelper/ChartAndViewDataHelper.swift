//
//  ChartAndDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/6/8.
//

import Foundation
// 定义枚举
enum DataInTime {
    case LastWeek
    case LastTwoWeek
    case LastMonth
}

class ChartAndDataViewHelper
{
    var optionsArray:[TraceOptionsDataModel]
    var dataType:DataInTime
    var date:Date
    init(dataType:DataInTime)
    {
        self.dataType = dataType
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        self.optionsArray = try! TraceOptionsDataHelper.findAll()!;
        self.date = Date()
        if(dataType == DataInTime.LastWeek)
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*6)
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else if(dataType == DataInTime.LastTwoWeek)
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*2-1))
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*4-1))
            self.date = nowDate.addingTimeInterval(nextDate)
        }
    }
    //index  0，1，2，3，4，5，6
    func getDetailModel(index: Int,optionId: Int) -> TraceOptionsDetailDataModel
    {
        do{
            let uDate = getDate(index: index)
            let data = try TraceOptionsDetailDataHelper.findOneDay(date: uDate, optionId: optionId);
            return data;
        }catch _ {
            print("inster userModel error")
        }
        
        return TraceOptionsDetailDataModel();
    }
    func changeDataType(dataType:DataInTime) -> Void {
        self.dataType = dataType
        if(dataType == DataInTime.LastWeek)
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*6)
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else if(dataType == DataInTime.LastTwoWeek)
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*2-1))
            self.date = nowDate.addingTimeInterval(nextDate)//getWeekFirstDate(date:nowDate.addingTimeInterval(nextDate))
        }else
        {
            let nowDate = Date()
            let nextDate:TimeInterval = TimeInterval(-24*60*60*(7*4-1))
            self.date = nowDate.addingTimeInterval(nextDate)
        }
    }
    func getDate(index: Int) -> Date
    {
        let nextDate:TimeInterval = TimeInterval(24*60*60*index)
        let rDate = self.date.addingTimeInterval(nextDate)
        return rDate
    }
    //get date with  index
    func getDateString(index: Int) -> String
    {
        let nextDate:TimeInterval = TimeInterval(24*60*60*index)
        let rDate = self.date.addingTimeInterval(nextDate)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "M/d"
        let strWeekStart = timeFormatter.string(from:rDate) as String
        return strWeekStart
    }
    
    //month total days
    /*func getMonthDays()->Int
    {
        let calendar = Calendar.current
        let y = calendar.component(.year, from: date)
        let m = calendar.component(.month, from: date)
        let dateComponents = DateComponents(year: y, month: m)

        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }*/
    //get月开始日期
    /*func startOfLastMonth() -> Date {
        let uDate = Date()
        let calendar = Calendar.current
        var y = calendar.component(.year, from: uDate)
        var m = calendar.component(.month, from: uDate)
        if(m > 1)
        {
            m -= 1
        }else
        {
            y -= 1
            m = 12
        }
        var components2 = DateComponents()
        components2.year = y
        components2.month = m
        components2.day = 1
        let userDate2 = calendar.date(from: components2)
        return userDate2!
    }*/
}
/*
func getWeekFirstDate(date: Date) ->Date
{
    let now = date
    let calendar = Calendar(identifier: .gregorian)
    let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: now)
    let weekNumber  = calendar.component(.weekOfYear, from: now)
    //print("weekNumber", weekNumber)
    print("Date", now.description(with: .current))
    let startDate = DateComponents(calendar: calendar, weekOfYear: weekNumber, yearForWeekOfYear: yearForWeekOfYear).date!
    
    return startDate
}
*/
