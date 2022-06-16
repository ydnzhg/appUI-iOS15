//
//  TraceOptionsDataModel.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/5/29.
//

import Foundation


import UIKit
import SQLite

/// TraceOptionsData
struct TraceOptionsDataModel : Identifiable{
    let id: UUID
    

    var dataID: Int = 0
    var title: String = ""
    var goal: Int = 0
    var unit:String = ""
    var shortUnits: String=""
    var icon: String=""
    var lastWeek: [Int] = [1,2,3,4,5,6,7]
    var palette: Palette = .fusionred
    var inputScore: Int = 0
    
    init(dataID: Int, title: String,goal: Int,unit : String,shortUnits :String,icon : String) {
        self.dataID = dataID
        self.title = title
        self.goal = goal
        self.unit = unit
        self.shortUnits = shortUnits
        self.icon = icon
        self.lastWeek = [1,2,3,4,5,6,7] // ？？ 这个lastWeek 是一个星期概念 还是 7天的
        self.palette = .royalblue
        self.inputScore = 0
        self.id = UUID()
    }
   
}

