import Foundation
import UIKit
import SQLite
/// RehabData
struct RehabDataModel {
    var dataID: Int = 0
    var didWorkout: Int = 0
    var partOfBody: Int = 1
    var intensity: Double = 0.0
    var sets: Int = 0
    var pain: Double = 0.0
    var createTime:String = ""
    init() {
        
    }
    
    init(dataID: Int, didWorkout: Int,partOfBody: Int,intensity: Double, sets: Int,pain: Double,createTime:String) {
        self.dataID = dataID
        self.didWorkout = didWorkout
        self.partOfBody = partOfBody
        self.intensity = intensity
        self.sets = sets
        self.pain = pain
        self.createTime = createTime

    }
}



