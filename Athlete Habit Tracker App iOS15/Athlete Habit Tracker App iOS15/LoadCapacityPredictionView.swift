//
//  LoadCapacityPredictionView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/13/22.
//

import SwiftUI
import SwiftUICharts

struct LoadCapacityPredictionView: View {
    @State   var dataObject = LoadCapacityPredictionViewDataHelper(dataType : DataInTime.LastWeek)
  
    @State private var selectedTimeToo: Int = 0
    
    func loadCapacityPredictionCalculation() -> Double {
        
        var todayIndex = dataObject.getDataTypeObj(type:selectedTimeToo).getLoadArray().count-1

        var loadCapacityPrediction:Double =  dataObject.getDataTypeObj(type:selectedTimeToo).getLoadArray()[todayIndex]
        
        if dataObject.getDataTypeObj(type:selectedTimeToo).getPainArray()[todayIndex] < 20 {
            loadCapacityPrediction += 10
        }
        else if dataObject.getDataTypeObj(type:selectedTimeToo).getPainArray()[todayIndex] <= 30 {
            loadCapacityPrediction += 5
        }
        else if dataObject.getDataTypeObj(type:selectedTimeToo).getPainArray()[todayIndex] <= 60 {
            loadCapacityPrediction -= 5
        }
        else if dataObject.getDataTypeObj(type:selectedTimeToo).getPainArray()[todayIndex] <= 100 {
            loadCapacityPrediction -= 10
        }
        
        return loadCapacityPrediction
    }
                    
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
                
                HStack(spacing: 20) {
                    HStack {
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.highblue)
                        Text("Load")
                    }
                    
                    HStack {
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.flirtacious)
                        Text("Recovery")
                    }
                    
                    HStack {
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.fusionred)
                        Text("Pain")
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Load Capacity Estimate:")
                        .font(.body.bold())
                        .padding()
                        .background(Color(.systemGray6))
                    Text("\(Int(loadCapacityPredictionCalculation()))")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fusionred)
                        .clipShape(RoundedRectangle(cornerSize: CGSize()))
                }
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                
                Spacer()

            }
        }
    }
}

struct LoadCapacityPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        LoadCapacityPredictionView()
    }
}
