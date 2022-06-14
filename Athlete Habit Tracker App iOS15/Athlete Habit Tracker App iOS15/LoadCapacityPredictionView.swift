//
//  LoadCapacityPredictionView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI
import SwiftUICharts

struct LoadCapacityPredictionView: View {
        
    @Binding var trainingHabits: [TrainingHabit]
    
    @Binding var workoutInfo: WorkoutInfo
    
    @State private var selectedTimeToo: Int = 0
    
    let painLastWeek: [Double] = [3, 1, 1, 10, 0, 2, 8]
    let painLast2Weeks: [Double] = [5, 10, 1, 6, 5, 0, 7, 4, 7, 1, 6, 3, 9, 5]
    let painLastMonth: [Double] = [5, 1, 10, 3, 6, 10, 4, 5, 6, 9, 2, 4, 10, 2, 7, 6, 0, 2, 5, 6, 10, 3, 0, 4, 0, 10, 9, 2, 10, 3]
                    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Picker(selection: $selectedTimeToo, label: Text("")) {
                    Text("Last Week").tag(0)
                    Text("Last 2 Weeks").tag(1)
                    Text("Last Month").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                let sampleData = [painLastWeek, painLast2Weeks, painLastMonth]
                                
                CardView {
                    ChartLabel("Pain", type: .subTitle)
                    LineChart()
                }
                .data(sampleData[selectedTimeToo])
                .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.4), Color.highblue.opacity(0.7))))
                .frame(height: 275)
                .padding(.horizontal)

                HStack {
                    VStack(spacing: 10) {
                        Text("\(workoutInfo.sets * Int(workoutInfo.intensity))")
                            .font(.title2.bold())
                        Text("Load Calculation")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(recoveryScoreCalculation(trainingHabits: trainingHabits))")
                            .font(.title2.bold())
                        Text("Recovery Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(Int(workoutInfo.pain) * 10)")
                            .font(.title2.bold())
                        Text("Pain Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Load Capacity Estimate:")
                        .font(.body.bold())
                        .padding()
                        .background(Color(.systemGray6))
                    Text("50")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fusionred)
                        .clipShape(RoundedRectangle(cornerSize: CGSize()))
                }
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)

                Spacer()
                
            }
        }
    }
}

struct LoadCapacityPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        LoadCapacityPredictionView(trainingHabits: .constant(TrainingHabit.sampleData), workoutInfo: .constant(WorkoutInfo.today))
    }
}

func recoveryScoreCalculation(trainingHabits: [TrainingHabit]) -> Int {
    var total: Int = 0
    for num in 0...4 {
        total += Int((Double(trainingHabits[num].today) / Double(trainingHabits[num].goal)) * Double(100))
    }
    return total / 5
}
