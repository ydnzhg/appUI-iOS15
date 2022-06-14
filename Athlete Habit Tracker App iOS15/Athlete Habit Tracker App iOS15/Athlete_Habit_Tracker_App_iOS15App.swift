//
//  Athlete_Habit_Tracker_App_iOS15App.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

@main
struct Athlete_Habit_Tracker_App_iOS15App: App {
    
    @State private var user = User.sampleData
        
    @State private var trainingHabits = TrainingHabit.sampleData
    
    @State private var workoutInfo = WorkoutInfo.today
    
    @State private var isPresentingInitialInput = true
    
    var body: some Scene {
        WindowGroup {
            ContentView(user: $user, trainingHabits: $trainingHabits, workoutInfo: $workoutInfo)
        }
    }
}
