//
//  DailyView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/13/22.
//

import SwiftUI

struct DailyView: View {
    
    @State var isPresentingTrainingHabitInputView = false
        
    @Binding var selectedTabIndex: Int
    
    @Binding var selectedHabit: Int
    
    @ObservedObject var traceOptionsObject: DailyViewDataHelper
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<traceOptionsObject.optionsArray.count) { num in
                    Button(action: {
                        selectedTabIndex = 3
                        selectedHabit = num
                    }) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("\(traceOptionsObject.optionsArray[num].title)")
                                    .foregroundColor(.white)
                                    
                                Text("\(traceOptionsObject.optionsArray[num].inputScore) \(traceOptionsObject.optionsArray[num].shortUnits)")
                                    .font(.title.bold())
                                    .foregroundColor(.white)
                                    
                                HStack {
                                    Text("Goal: \(traceOptionsObject.optionsArray[num].goal) \(traceOptionsObject.optionsArray[num].unit)")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                    Spacer(minLength: 0)
                                        
                                }
                            }
                            .padding()
                            .background(traceOptionsObject.optionsArray[num].inputScore != 0 ? traceOptionsObject.optionsArray[num].palette.mainColor : .twinkleblue)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                
                            Image(systemName: "\(traceOptionsObject.optionsArray[num].icon)")
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
                TrainingHabitInputView(traceOptionsObject:traceOptionsObject)
                    .navigationTitle("Input Today's Info")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingTrainingHabitInputView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                traceOptionsObject.commitToOptionsDetailDB()
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
        DailyView(selectedTabIndex: .constant(0), selectedHabit: .constant(0), traceOptionsObject:DailyViewDataHelper(detail: true, date: Date()))
    }
}
