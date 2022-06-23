//
//  LoadCapacityPredictionView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI
import SwiftUICharts

struct LoadCapacityPredictionView: View {
    @State   var dataObject = LoadCapacityPredictionViewDataHelper(dataType : DataInTime.LastWeek)
    //@Binding var trainingHabits: [TrainingHabit]
    
    //@Binding var workoutInfo: WorkoutInfo
    
    @State private var selectedTimeToo: Int = 0
    
    //let loadLastWeek: [Double] = [93,75,32,14,23,59,23]
    //let recoveryLastWeek: [Double] = [35,22,28,71,1,0,7]
    //let painLastWeek: [Double] = [72,78,61,5,8,25,31]

    //let loadLast2Weeks: [Double] = [51,24,64,75,61,46,56,41,91,62,21,100,95,19]
    //let recoveryLast2Weeks: [Double] = [58,26,29,75,19,39,99,27,79,76,29,87,52,41]
    //let painLast2Weeks: [Double] = [97,46,52,69,48,41,62,15,57,16,68,57,96,5]
    
    //let loadLastMonth: [Double] = [25,48,90,34,3,59,8,86,78,15,68,70,77,47,23,75,20,57,48,71,71,28,49,2,5,31,47,4,89,0]
    //let recoveryLastMonth: [Double] = [57,40,91,30,84,67,56,84,39,1,69,0,59,97,93,25,0,8,20,64,68,38,36,65,22,87,39,11,60,57]
    //let painLastMonth: [Double] = [10,49,84,40,5,12,51,86,47,56,87,48,24,40,85,34,98,0,82,21,85,74,6,78,24,1,3,51,99,51]
                    
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
                
                //let sampleData = [[loadLastWeek, recoveryLastWeek, painLastWeek], [loadLast2Weeks, recoveryLast2Weeks, painLast2Weeks], [loadLastMonth, recoveryLastMonth, painLastMonth]]
                
                ZStack {
                    CardView {
                        ChartLabel("Pain", type: .subTitle)
                        LineChart()
                    }
                    .data(dataObject.getDataTypeObj(type:selectedTimeToo).getPainArray())
                    .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.fusionred.opacity(0.4), Color.fusionred)))
                    .frame(height: 275)
                    
                    LineChart()
                        .data(dataObject.getDataTypeObj(type:selectedTimeToo).getRecoveryArray())
                        .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.flirtacious.opacity(0.4), Color.flirtacious)))
                        .frame(height: 275)
                    
                    LineChart()
                        .data(dataObject.getDataTypeObj(type:selectedTimeToo).getLoadArray())
                        .chartStyle(ChartStyle(backgroundColor: .white.opacity(0.1), foregroundColor: ColorGradient(Color.highblue.opacity(0.4), Color.highblue)))
                        .frame(height: 275)
                }
                .padding(.horizontal)
                
                
                HStack {
                    VStack(spacing: 10) {
                        Text("\(0)")
                            .font(.title2.bold())
                        Text("Load Calculation")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.highblue.opacity(0.95))
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(0)")
                            .font(.title2.bold())
                        Text("Recovery Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.flirtacious.opacity(0.95))
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(Int(0) * 10)")
                            .font(.title2.bold())
                        Text("Pain Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 75)
                    .background(Color.fusionred.opacity(0.95))
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

//struct LoadCapacityPredictionView_Previews: PreviewProvider {
 //   static var previews: some View {
  //      LoadCapacityPredictionView(trainingHabits: .constant(TrainingHabit.sampleData), workoutInfo: .constant(WorkoutInfo.today))
  //  }
//}

