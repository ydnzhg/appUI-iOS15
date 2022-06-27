//
//  DataModel.swift
//  TraceOptionsDataModel-Swift
//
//  Created by yejf on 2022/5/28.
//  Copyright © 2022年 yejf. All rights reserved.
//

import Foundation
import UIKit
import SQLite

/// user Info
struct UserInfoModel {

    var userID: Int = 1
    var userName: String = "name"
    var heightFeetEx: Int = 0
    var heightInchesEx: Int = 0
    var weight: Double = 0.0
    var gender: Int = 0
    var picturePath : String = ""
    var createTime:String = ""
    var age: Double = 0.0
    init() {
        
    }
    
    init(userID: Int, userName: String,heightFeetEx: Int,heightInchesEx: Int, weight: Double,gender: Int,picturePath : String,createTime:String,age:Double) {
        self.userID = userID
        self.userName = userName
        self.heightFeetEx = heightFeetEx
        self.heightInchesEx = heightInchesEx
        self.weight = weight
        self.gender = gender
        self.picturePath = picturePath
        self.createTime = createTime
        self.age = age

    }
}

// User Icon store
extension NSData: Value {

    // SQL Type
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    // Decode
    public class func fromDatatypeValue(_ datatypeValue: Blob) -> NSData {
        return NSData(bytes: datatypeValue.bytes, length: datatypeValue.bytes.count)
    }
    // Encode
    public var datatypeValue: Blob {
        return Blob(bytes: self.bytes, length: self.length)
    }
}

extension UIImage: Value {
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    public class func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    public var datatypeValue: Blob {
        return self.pngData()!.datatypeValue
    }

}
// 共享状态  share
class UserInfoDataObject: ObservableObject {
    @Published var userID: Int
    @Published var userName: String
    @Published var heightFeetEx: Int
    @Published var heightInchesEx: Int
    @Published var weight: Int
    @Published var gender: Int
    @Published var age: Int
    @Published var picturePath: String
    var createTime: String
    init() {
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        
        let data = try! UserinfoDataHelper.getUser()
        self.userID = data.userID
        self.userName = data.userName
        self.createTime = data.createTime;
        self.weight = Int(data.weight);
        self.heightFeetEx = data.heightFeetEx
        self.heightInchesEx = data.heightInchesEx
        self.age = Int(data.age)
        self.picturePath = data.picturePath;
        self.gender = data.gender
        if(self.picturePath.isEmpty)
        {
            self.picturePath = "placeholderpfp"
        }
        
    }
    func getHeight() -> Int
    {
        return heightFeetEx * 12 + heightInchesEx
    }
    func commitToDB()-> Bool {
        do {
            let res = try UserinfoDataHelper.update(item: UserInfoModel(userID: userID, userName: userName,heightFeetEx: heightFeetEx,heightInchesEx: heightInchesEx,weight: Double(weight),gender:gender, picturePath:picturePath,createTime: createTime,age: Double(age)))
            return res
        } catch _ {
            print("inster userModel error")
        }
        
        return false
    }
}
