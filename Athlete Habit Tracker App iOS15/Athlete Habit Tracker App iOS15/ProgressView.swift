//
//  ProgressView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI
import SwiftUICharts

struct ProgressView: View {
    
    @Binding var trainingHabits: [TrainingHabit]
    
    @State private var selectedTime: Int = 0
    
    @Binding var selectedHabit: Int
    
    let daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        
        ScrollView {
            VStack {
                Picker(selection: $selectedTime, label: Text("")) {
                    Text("Last Week").tag(0)
                    Text("Last 2 Weeks").tag(1)
                    Text("Last Month").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                CardView {
                    ChartLabel("\(trainingHabits[selectedHabit].title)", type: .subTitle)
                    if trainingHabits[selectedHabit].type == "trainingHabit" {
                        BarChart()
                    }
                    else {
                        LineChart()
                    }
                }
                .data(trainingHabits[selectedHabit].lastWeek.map { Double($0) })
                .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.4), Color.highblue.opacity(0.7))))
                .frame(height: 275)
                .padding(.horizontal)
                .padding(.top, 10)
                
                HStack {
                    ForEach(0..<7) { num in
                        Text("\(daysOfTheWeek[num])")
                            .frame(width: 45)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(trainingHabits: .constant(TrainingHabit.sampleData), selectedHabit: .constant(0))
    }
}
