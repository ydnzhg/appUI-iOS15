//
//  UserinfoDataHelper.swift
//  Swift
//
//  Created by yejf on 2022/5/28.
//  Copyright © 2022年 yejf. All rights reserved.
//

import Foundation
import SQLite

class UserinfoDataHelper: DataHelperProtocol {

    static let TABLE_NAME = "user_info"
    
    static let userID = Expression<Int>("id")
    static let userName = Expression<String>("username")
    static let heightFeetEx = Expression<Int>("heightFeetEx")
    static let heightInchesEx = Expression<Int>("heightInchesEx")
    static let weight = Expression<Double>("weight")
    static let gender = Expression<Int>("gender")
    static let picturePath = Expression<String>("picturepath")
    static let age = Expression<Double>("age")
    static let createTime = Expression<String>("createTime")

    
    static let table = Table(TABLE_NAME)
    
    typealias T = UserInfoModel
    
    static func createTable() throws {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(userID)
                t.column(userName)
                t.column(heightFeetEx)
                t.column(heightInchesEx)
                t.column(weight)
                t.column(gender)
                t.column(picturePath)
                t.column(age)
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
        
        let insert = table.insert(userID <- item.userID, userName <- item.userName, heightFeetEx <- item.heightFeetEx,heightInchesEx <- item.heightInchesEx,weight <- item.weight,gender <- item.gender,picturePath <- item.picturePath,age <- item.age,createTime <- item.createTime)
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

        let query = table.filter(item.userID == userID)

        if try DB.run(query.update(userID <- item.userID, userName <- item.userName, heightFeetEx <- item.heightFeetEx,heightInchesEx <- item.heightInchesEx,weight <- item.weight,gender <- item.gender,picturePath <- item.picturePath,age <- item.age,createTime <- item.createTime)) > 0 {
            return true
        } else {
            let res = try self.insert(item: item )
            return res > 0
        }

    }

    static func checkColumnExists(queryUserID: Int) throws -> Bool {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }


        let query = table.filter(queryUserID == userID).exists

        let isExists = try DB.scalar(query)
        return  isExists

    }

    static func delete (item: T) throws -> Void {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let id = item.userID
        let query = table.filter(userID == id)
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.deleteError
            }
        } catch _ {
            throw DataAccessError.deleteError
        }
    }
    static func getUser() throws -> T {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let query = table.filter(1 == userID)
        let items = try DB.prepare(query)
        for item in  items {
            return UserInfoModel(userID: item[userID], userName: item[userName],heightFeetEx: item[heightFeetEx],heightInchesEx: item[heightInchesEx],weight: item[weight],gender:item[gender], picturePath:item[picturePath],createTime: item[createTime],age: item[age])
        }
        
        return UserInfoModel()
        
    }
    
    static func find(queryUserID: Int) throws -> [T] {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let query = table.filter(queryUserID == userID)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in  items {
            
            retArray.append(UserInfoModel(userID: item[userID], userName: item[userName],heightFeetEx: item[heightFeetEx],heightInchesEx: item[heightInchesEx],weight: item[weight],gender:item[gender], picturePath:item[picturePath],createTime: item[createTime],age: item[age]))
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
            retArray.append(UserInfoModel(userID: item[userID], userName: item[userName],heightFeetEx: item[heightFeetEx],heightInchesEx: item[heightInchesEx],weight: item[weight],gender:item[gender], picturePath:item[picturePath],createTime: item[createTime],age: item[age]))
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
