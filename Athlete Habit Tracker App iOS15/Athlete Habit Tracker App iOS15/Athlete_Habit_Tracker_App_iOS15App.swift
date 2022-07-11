//
//  Athlete_Habit_Tracker_App_iOS15App.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/13/22.
//

import SwiftUI

@main
struct Athlete_Habit_Tracker_App_iOS15App: App {
            
    @State private var trainingHabits = TrainingHabit.sampleData
    
    @State private var workoutInfo = WorkoutInfo.today
    
    @State private var isPresentingInitialInput = true
    
    @State var signInSuccess = false
    
    @ObservedObject var user = UserInfoDataObject()

    var body: some Scene {
        WindowGroup {
            if user.userName != "" {
                ContentView()
            }
            else {
                InitialLaunchView(signUpSuccess: $signInSuccess)
            }
        }
    }
}
