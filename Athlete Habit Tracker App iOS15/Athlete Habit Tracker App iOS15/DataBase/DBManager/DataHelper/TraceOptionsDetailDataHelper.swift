//
//  TraceOptionsDetailDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/5/29.
//

import Foundation
import SQLite

class TraceOptionsDetailDataHelper: DataHelperProtocol {

    static let TABLE_NAME = "user_trace_options_detail"
    
    static let detailID = Expression<Int>("id")
    static let optionId = Expression<Int>("optionId")
    static let optionName = Expression<String>("optionName")
    static let inputScore = Expression<Int>("inputScore")
    static let score = Expression<Int>("score")
    static let unit = Expression<String>("unit")
    static let createTime = Expression<String>("createTime")
    
    static let table = Table(TABLE_NAME)
    
    typealias T = TraceOptionsDetailDataModel
    
    static func createTable() throws {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(detailID)
                t.column(optionId)
                t.column(optionName)
                t.column(inputScore)
                t.column(score)
                t.column(unit)
                t.column(createTime)
            })
        } catch _ {
            throw DataAccessError.datastoreConnectionError
        }
    }
    
    static func insert(item: T) throws -> Int {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from:item.createTime) as String
        let insert = table.insert(detailID <- item.detailID, optionId <- item.optionId, optionName <- item.optionName,inputScore <- item.inputScore,score <- item.score,unit <- item.unit,createTime <- dateStr)
        do {
            let rowId = try DB.run(insert)
            guard rowId >= 0 else {
                throw DataAccessError.insertError
            }
            return Int(rowId)
        } catch _ {
            throw DataAccessError.insertError
        }
    }
    
    static func update(item: T) throws -> Bool {
        
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }

        let query = table.filter(item.detailID == detailID)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from:item.createTime) as String
        if try DB.run(query.update(detailID <- item.detailID, optionId <- item.optionId, optionName <- item.optionName,inputScore <- item.inputScore,score <- item.score,unit <- item.unit,createTime <- dateStr)) > 0 {
            return true
        } else {
            return try self.insert(item: item) > 0
        }

    }
    static func testDemo() {
        do {
            /////
            /*let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateTime = dateFormatter.date(from: "2022-05-07 6:00:00")!
            let id1 = try TraceOptionsDetailDataHelper.getNewId()
            let  detailModel1 = TraceOptionsDetailDataModel.init(detailID: id1, optionId: 1, optionName:"optionName1",calScore: 1, score: 200.0,unit:"min",createTime: dateFormatter.date(from: "2022-05-01 9:00:00")!)
            try self.insert(item: detailModel1 )
            //////
            let id2 = try TraceOptionsDetailDataHelper.getNewId()
            let  detailModel2 = TraceOptionsDetailDataModel.init(detailID: id2, optionId: 1, optionName:"optionName1", calScore: 1,score: 300.0,unit:"min",createTime: dateFormatter.date(from: "2022-05-05 6:00:00")!)
            try self.insert(item: detailModel2 )
            /////
            let id3 = try TraceOptionsDetailDataHelper.getNewId()
            let  detailModel3 = TraceOptionsDetailDataModel.init(detailID: id3, optionId: 1, optionName:"optionName1",calScore: 1, score: 300.0,unit:"min",createTime: dateFormatter.date(from: "2022-05-07 6:00:00")!)
            try self.insert(item: detailModel3 )
            ///
            let id4 = try TraceOptionsDetailDataHelper.getNewId()
            let  detailModel4 = TraceOptionsDetailDataModel.init(detailID: id4, optionId: 1, optionName:"optionName1",calScore: 1, score: 300.0,unit:"min",createTime: dateFormatter.date(from: "2022-05-09 6:00:00")!)
            try self.insert(item: detailModel4 )
            
            

            let  detailModel2_2 = try TraceOptionsDetailDataHelper.findOneDay(date: dateTime,optionId: 1)
            
            var  dataArray = try TraceOptionsDetailDataHelper.findDataInWeek(date: dateTime,optionId: 1)
            
            var i = 0;*/
            
        } catch _ {
            print("inster userModel error")
        }
    }
    static func checkColumnExists(queryID: Int) throws -> Bool {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }


        let query = table.filter(queryID == detailID).exists

        let isExists = try DB.scalar(query)
        return  isExists

    }
    static func getNewId() throws -> Int {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            let sql = "SELECT * FROM " + TABLE_NAME + " order by id desc limit 1"
            let items = try DB.prepare(sql)
            for row in items {
                guard let Id = row[0] as? Int64 else { return 1 }
                return  NSNumber(value: Id).intValue + 1
            }
        }catch(let error){
            debugPrint(error.localizedDescription)

        }
        return  1

    }
    static func delete (item: T) throws -> Void {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let id = item.detailID
        let query = table.filter(detailID == id)
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.deleteError
            }
        } catch _ {
            throw DataAccessError.deleteError
        }
    }
    
    
    static func find(queryUserID: Int) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let query = table.filter(queryUserID == detailID)
        let items = try DB.prepare(query)
        var retArray = [T]()
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: dateFormatter.date(from: cTime)!))
        }
        
        return retArray
        
    }
    static func findOneDay(date: Date, optionId: Int) throws -> T {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from:date) as String
        let query = table.filter(createTime == dateStr && self.optionId == optionId).order(createTime.desc)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[self.optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        if(retArray.isEmpty)
        {
            return TraceOptionsDetailDataModel()
        }
        
        return retArray[0]
        
    }
    static func findOneDay(date: Date) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from:date) as String
        let query = table.filter(createTime == dateStr).order(detailID.asc)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[self.optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        
        return retArray
        
    }
    static func findWithDayS(dateFrom: Date, dateTo:Date,optionId: Int) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let _dateStart = timeFormatter.string(from:dateFrom) as String
        let _dateEnd = timeFormatter.string(from:dateTo) as String
        let query = table.filter(createTime >= _dateStart && createTime < _dateEnd && self.optionId == optionId)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[self.optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        
        return retArray
        
    }
    // A day of  a week
    static func findDataInWeek(date: Date,optionId: Int) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let now = date
        let calendar = Calendar(identifier: .gregorian)
        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: now)
        let weekNumber  = calendar.component(.weekOfYear, from: now)
        //print("weekNumber", weekNumber)
        print("Date", now.description(with: .current))
        let startDate = DateComponents(calendar: calendar, weekOfYear: weekNumber, yearForWeekOfYear: yearForWeekOfYear).date!
        let endDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
        //print("startDate", startDate.description(with: .current))
        //print("endDate", endDate.description(with: .current))
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let strWeekStart = timeFormatter.string(from:startDate) as String
        let strWeekEnd = timeFormatter.string(from:endDate) as String
        let query = table.filter(createTime >= strWeekStart && createTime < strWeekEnd && self.optionId == optionId)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[self.optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        
        return retArray
        
    }
    static func findDataInWeek(date: Date) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let now = date
        let calendar = Calendar(identifier: .gregorian)
        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: now)
        let weekNumber  = calendar.component(.weekOfYear, from: now)
        //print("weekNumber", weekNumber)
        print("Date", now.description(with: .current))
        let startDate = DateComponents(calendar: calendar, weekOfYear: weekNumber, yearForWeekOfYear: yearForWeekOfYear).date!
        let endDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
        //print("startDate", startDate.description(with: .current))
        //print("endDate", endDate.description(with: .current))
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let strWeekStart = timeFormatter.string(from:startDate) as String
        let strWeekEnd = timeFormatter.string(from:endDate) as String
        let query = table.filter(createTime >= strWeekStart && createTime < strWeekEnd)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[self.optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        
        return retArray
        
    }
    //get table all data
    static func findAll() throws -> [T]? {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        for item in items {
            let cTime = item[createTime]
            retArray.append(TraceOptionsDetailDataModel(detailID: item[detailID], optionId: item[optionId],optionName: item[optionName],inputScore: item[inputScore],score: item[score],unit: item[unit],createTime: timeFormatter.date(from: cTime)!))
        }
        
        return retArray
    }
    
    
}
