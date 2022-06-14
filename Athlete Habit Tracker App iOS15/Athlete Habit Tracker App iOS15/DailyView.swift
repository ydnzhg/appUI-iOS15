//
//  DailyView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct DailyView: View {
    
    @State var isPresentingTrainingHabitInputView = false
    
    @Binding var trainingHabits: [TrainingHabit]
    
    @Binding var selectedTabIndex: Int
    
    @Binding var selectedHabit: Int
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
            // if values are inputted, card will light up
            // if havent inputted yet, card will be grey
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                // cards
                
                /*
                ForEach($trainingHabits) { $trainingHabit in
                    NavigationLink(destination: TrainingHabitView(trainingHabit: $trainingHabit)) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("\(trainingHabit.title)")
                                    .foregroundColor(.white)
                                    
                                Text("\(trainingHabit.today) \(trainingHabit.shortUnits)")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                    
                                HStack {
                                    Text("Goal: \(trainingHabit.goal) \(trainingHabit.units)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)
                                        
                                }
                            }
                            .padding()
                            .background(trainingHabit.today != 0 ? trainingHabit.palette.mainColor : .twinkleblue)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                
                            Image(systemName: "\(trainingHabit.icon)")
                                .padding()
                                .foregroundColor(.white)
                        }
                    }
                 }
                 */
                ForEach(0..<trainingHabits.count) { num in
                    Button(action: {
                        selectedTabIndex = 3
                        selectedHabit = num
                    }) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("\(trainingHabits[num].title)")
                                    .foregroundColor(.white)
                                    
                                Text("\(trainingHabits[num].today) \(trainingHabits[num].shortUnits)")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                    
                                HStack {
                                    Text("Goal: \(trainingHabits[num].goal) \(trainingHabits[num].units)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)
                                        
                                }
                            }
                            .padding()
                            .background(trainingHabits[num].today != 0 ? trainingHabits[num].palette.mainColor : .twinkleblue)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                
                            Image(systemName: "\(trainingHabits[num].icon)")
                                .padding()
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                }
            }
            .padding(.horizontal)
            .padding(.top,5)
        }
        .overlay(
                Button(action: {
                    isPresentingTrainingHabitInputView = true
                }) {
                    Image(systemName: "pencil")
                }
                    .font(.system(size: 25).bold())
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Color.highblue)
                    .clipShape(Circle())
                    .padding()
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                , alignment: .bottomTrailing)
        .sheet(isPresented: $isPresentingTrainingHabitInputView) {
            NavigationView {
                TrainingHabitInputView(trainingHabits: $trainingHabits)
                    .navigationTitle("Input Today's Info")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingTrainingHabitInputView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingTrainingHabitInputView = false
                            }
                        }
                    }
            }
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(trainingHabits: .constant(TrainingHabit.sampleData), selectedTabIndex: .constant(0), selectedHabit: .constant(0))
    }
}
