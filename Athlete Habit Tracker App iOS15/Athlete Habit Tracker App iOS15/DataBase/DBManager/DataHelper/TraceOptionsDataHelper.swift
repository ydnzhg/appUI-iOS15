//
//  TraceOptionsDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/5/29.
//

import Foundation
import SQLite

class TraceOptionsDataHelper: DataHelperProtocol {

    static let TABLE_NAME = "user_trace_options"
    
    static let dataID = Expression<Int>("id")
    static let title = Expression<String>("title")
    static let goal = Expression<Int>("goal")
    static let unit = Expression<String>("unit")
    static let shortUnits = Expression<String>("shortUnits")
    static let icon = Expression<String>("icon")
    
    static let table = Table(TABLE_NAME)
    
    typealias T = TraceOptionsDataModel
    
    static func createTable() throws {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(dataID)
                t.column(title)
                t.column(goal)
                t.column(unit)
                t.column(shortUnits)
                t.column(icon)
            })
            try self.initData()
        } catch _ {
            throw DataAccessError.datastoreConnectionError
        }
        
    }
    static func initData() throws -> Void
    {
        do {
            let rowId = try self.getNewId()
            if(rowId > 1)
            {
                return;
            }
            var res = try insert(item: TraceOptionsDataModel(dataID: 1, title: "Sleep",goal: 8,unit: "hours",shortUnits: "hrs",icon: "powersleep"))
            res = try insert(item: TraceOptionsDataModel(dataID: 2, title: "Hydration",goal: 64,unit: "ounces",shortUnits: "oz",icon: "drop.fill"))
            res = try insert(item: TraceOptionsDataModel(dataID: 3, title: "Protein Intake",goal: 160,unit: "grams",shortUnits: "g",icon: "fork.knife"))
            res = try insert(item: TraceOptionsDataModel(dataID: 4, title: "Calorie Intake",goal: 2300,unit: "kcals",shortUnits: "cal",icon: "bolt.fill"))
            res = try insert(item: TraceOptionsDataModel(dataID: 5, title: "Stretching",goal: 15,unit: "minutes",shortUnits: "min",icon: "stopwatch.fill"))
            res = try insert(item: TraceOptionsDataModel(dataID: 6, title: "Workout",goal: 60,unit: "minutes",shortUnits: "min",icon: "figure.walk"))
            res = try insert(item: TraceOptionsDataModel(dataID: 7, title: "Weight",goal: 160,unit: "pounds",shortUnits: "lbs",icon: "scalemass.fill"))
            res = try insert(item: TraceOptionsDataModel(dataID: 8, title: "Heart Rate",goal: 50,unit: "bpm",shortUnits: "bpm",icon: "heart.fill"))
        }catch _ {
            throw DataAccessError.datastoreConnectionError
        }
    }
    static func insert(item: T) throws -> Int {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        
        let insert = table.insert(dataID <- item.dataID, title <- item.title, goal <- item.goal,unit <- item.unit,shortUnits <- item.shortUnits,icon <- item.icon)
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

        let query = table.filter(item.dataID == dataID)

        if try DB.run(query.update(dataID <- item.dataID, title <- item.title, goal <- item.goal,unit <- item.unit,shortUnits <- item.shortUnits,icon <- item.icon)) > 0 {
            return true
        } else {
            return false
        }

    }

    static func checkColumnExists(queryID: Int) throws -> Bool {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }


        let query = table.filter(queryID == dataID).exists

        let isExists = try DB.scalar(query)
        return  isExists

    }

    static func delete (item: T) throws -> Void {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let id = item.dataID
        let query = table.filter(dataID == id)
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
        let query = table.filter(queryUserID == dataID)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            
            retArray.append(TraceOptionsDataModel(dataID: item[dataID], title: item[title],goal: item[goal],unit: item[unit],shortUnits: item[shortUnits],icon: item[icon]))
        }
        
        return retArray
        
    }
    
    static func findAll() throws -> [T]? {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(TraceOptionsDataModel(dataID: item[dataID], title: item[title],goal: item[goal],unit: item[unit],shortUnits: item[shortUnits],icon: item[icon]))
        }
        
        return retArray
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
    
}
