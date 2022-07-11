import Foundation
import SQLite

class RehabDataHelper: DataHelperProtocol {

    static let TABLE_NAME = "user_reha_data"
    
    static let dataID = Expression<Int>("id")
    static let didWorkout = Expression<Int>("didWorkout")
    static let partOfBody = Expression<Int>("partOfBody")
    static let intensity = Expression<Double>("intensity")
    static let sets = Expression<Int>("sets")
    static let pain = Expression<Double>("pain")
    static let createTime = Expression<String>("createTime")
    
    static let table = Table(TABLE_NAME)
    
    typealias T = RehabDataModel
    
    static func createTable() throws {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(dataID)
                t.column(didWorkout)
                t.column(partOfBody)
                t.column(intensity)
                t.column(sets)
                t.column(pain)
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
        
        let insert = table.insert(dataID <- item.dataID, didWorkout <- item.didWorkout, partOfBody <- item.partOfBody,intensity <- item.intensity,sets <- item.sets,pain <- item.pain,createTime <- item.createTime)
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
    static func updateColumn(columnId:Int,value:Double,dataID:Int) throws -> Bool{
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let query = table.filter(dataID == self.dataID)
        var res  = false
        switch columnId {
            case 0:
                if try DB.run(query.update(didWorkout <- Int(value))) > 0 {
                    res = true;
                }
                break
            
            case 1:
                if try DB.run(query.update(partOfBody <- Int(value))) > 0 {
                    res = true;
                }
                break
            case 2:
                if try DB.run(query.update(intensity <- value)) > 0 {
                    res = true;
                }
                break
            case 3:
                if try DB.run(query.update(sets <- Int(value))) > 0 {
                    res = true;
                }
                break
            case 4:
                if try DB.run(query.update(pain <- value)) > 0 {
                    res = true;
                }
            break
                
        default:
            res = false
        }
        return res
    }
    static func update(item: T) throws -> Bool {
        
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }

        let query = table.filter(item.dataID == dataID)

        if try DB.run(query.update(dataID <- item.dataID, didWorkout <- item.didWorkout, partOfBody <- item.partOfBody,intensity <- item.intensity,sets <- item.sets,pain <- item.pain,createTime <- item.createTime)) > 0 {
            return true
        } else {
            let res = try self.insert(item: item )
            return res > 0
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
            
            retArray.append(RehabDataModel(dataID: item[dataID], didWorkout: item[didWorkout],partOfBody: item[partOfBody],intensity: item[intensity],sets: item[sets],pain: item[pain],createTime: item[createTime]))
        }
        
        return retArray
        
    }
    static func findOneDay(date: Date) throws -> T {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from:date) as String
        let query = table.filter(createTime == dateStr)
        let items = try DB.prepare(query)
        //var retArray = [T]()
        for item in  items {
            //let cTime = item[createTime]
            return RehabDataModel(dataID: item[dataID], didWorkout: item[didWorkout],partOfBody: item[partOfBody],intensity: item[intensity],sets: item[sets],pain: item[pain],createTime: item[createTime])
        }
        
        return RehabDataModel()
        
    }
    static func findAll() throws -> [T]? {

        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.datastoreConnectionError
        }
        var retArray = [T]()
        let items = try DB.prepare(table)
        for item in items {
            retArray.append(RehabDataModel(dataID: item[dataID], didWorkout: item[didWorkout],partOfBody: item[partOfBody],intensity: item[intensity],sets: item[sets],pain: item[pain],createTime: item[createTime]))
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
