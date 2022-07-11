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
