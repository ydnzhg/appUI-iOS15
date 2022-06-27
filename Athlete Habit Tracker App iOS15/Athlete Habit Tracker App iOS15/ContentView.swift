//
//  ContentView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var user: User
    
    @Binding var trainingHabits: [TrainingHabit]
    
    @Binding var workoutInfo: WorkoutInfo
    
    @State private var selectedHabit: Int = 0

    @State private var date = Date()
    
    @State private var selectedTabIndex = 0
    @State private var isGoalAlter: Bool = false
    @ObservedObject var rehabDataObject = RehabViewDataHelper(date:Date())
    @ObservedObject var traceOptionsObject = DailyViewDataHelper(detail: true, date: Date())
    
    @State private var progressObj = ProgressViewDataHelper(dataType:DataInTime.LastWeek)
    let tabBarImageNames = ["list.bullet.rectangle.portrait.fill", "heart.text.square.fill", "sparkle", "chart.xyaxis.line", "person.fill"]
    
    @State private var isPresentingInfoEditView = true
    
    @State var showDatePicker: Bool = false
    
    var body: some View {
        VStack {
            // custom tab bar
            ZStack {
                switch selectedTabIndex {
                case 0:
                    NavigationView {
                        DailyView( selectedTabIndex: $selectedTabIndex, selectedHabit: $selectedHabit, traceOptionsObject: traceOptionsObject)
                            .navigationTitle("Training Habits")
                            .toolbar {
                                HStack {
                                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                                    Image(systemName: "calendar")
                                }
                            }
                            .onReceive([date].publisher.first())
                            {(value) in
                                traceOptionsObject.changeDate(date: value)
                            }
                    }
                case 1:
                    NavigationView {
                        RehabView(rehabDataObject:rehabDataObject)
                            .navigationTitle("Workout Log")
                            .toolbar {
                                HStack {
                                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                                        .onReceive([date].publisher.first())
                                        {(value) in
                                            rehabDataObject.changeDate(date:date)
                                        }
                                    
                                    Image(systemName: "calendar")
                                }
                                
                            }
                            .onReceive([rehabDataObject.didWorkout].publisher.first())
                            {(value) in
                                    rehabDataObject.commitToDB()
                            }
                    }
                case 2:
                    NavigationView {
                        LoadCapacityPredictionView()
                            .navigationTitle("Load Capacity")
                    }
                case 3:
                    NavigationView {
                        ProgressView(selectedHabit: $selectedHabit,progressObj: progressObj)
                            .navigationTitle("Progress")
                            .toolbar {
                                Picker(
                                    selection: $selectedHabit,
                                    label:
                                        HStack {
                                            Text("Habit: ")
                                            Text("\(progressObj.optionsArray[selectedHabit].title)")
                                        }
                                    ,
                                    content: {
                                        ForEach(0..<progressObj.optionsArray.count) { num in
                                            Text("\(progressObj.optionsArray[num].title)").tag(num)
                                        }
                                    })
                                .pickerStyle(MenuPickerStyle())
                                .padding(.horizontal, 10)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                    }
                case 4:
                    ProfileView(isGoalAlter:$isGoalAlter)
                    .onReceive([isGoalAlter].publisher.first())
                    {(value) in
                         if(isGoalAlter)
                         {
                             traceOptionsObject.updateGoal()
                         }
                        isGoalAlter = false;
                    }
                default:
                    Text("Test")
                }
            }
            
            Spacer()
            
            Divider()
                .padding(.bottom, 10)
            
            HStack {
                ForEach(0..<5) { num in
                    Button(action: {
                        selectedTabIndex = num
                    }) {
                        Spacer()
                        Image(systemName: tabBarImageNames[num])
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(selectedTabIndex == num ? .black : .init(white: 0.8))
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: .constant(User.sampleData), trainingHabits: .constant(TrainingHabit.sampleData), workoutInfo: .constant(WorkoutInfo.today))
    }
}
