//
//  WorkoutInfo.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import Foundation

struct WorkoutInfo {
    var completed: Int  // 1 for completed, 0 for did not complete
    var bodyPart: Int  // 0 for upper, 1 for lower
    var sets: Int
    var intensity: Double  // 0 - 10
    var pain: Double  // 0 - 10
    
    init(completed: Int, bodyPart: Int, sets: Int, intensity: Double, pain: Double) {
        self.completed = completed
        self.bodyPart = bodyPart
        self.sets = sets
        self.intensity = intensity
        self.pain = pain
    }
}

extension WorkoutInfo {
    static let today: WorkoutInfo = WorkoutInfo(completed: 0, bodyPart: 0, sets: 0, intensity: 0, pain: 0)
}
