//
//  ProgressView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI
import SwiftUICharts

struct ProgressView: View {
    
   // @Binding var trainingHabits: [TrainingHabit]
    
    @State private var selectedTime: Int = 0
    
    @Binding var selectedHabit: Int
    @State var progressObj : ProgressViewDataHelper
   // let daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

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
                //progressObj.changeDataType(dataType: DataInTime.LastMonth)
                CardView {
                    ChartLabel("\(progressObj.getDataTypeObj(dataType:selectedTime).optionsArray[selectedHabit].title)", type: .subTitle)
                   // if trainingHabits[selectedHabit].type == "trainingHabit" {
                        BarChart()
                   // }
                    //else {
                        //LineChart()
                    //}
                }
                .data(progressObj.getDataTypeObj(dataType:selectedTime).getTypeAllData(optionId: selectedHabit).map { Double($0) })
                .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.5), Color.highblue.opacity(0.8))))
                .frame(height: 275)
                .padding(.horizontal)
                .padding(.top, 10)

                HStack {
                    ForEach(0..<progressObj.getDataTypeCount()) { num in
                        Text("\(progressObj.getDateString(index: num))")
                            .frame(width: 45)
                            .foregroundColor(.gray)
                    }
                }
                
                LazyVGrid(columns: columns) {
                    Text("Date")
                        .frame(width: 100)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    Text("\(progressObj.optionsArray[selectedHabit].unit.capitalized)")
                        .frame(width: 100)

                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    Text("Goal Met")
                        .frame(width: 100)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    ForEach(0..<progressObj.getDataTypeCount()) { num in
                        let m = progressObj.getDetailModel(index: num, optionId: selectedHabit + 1)
                        Text("\(progressObj.getDateString(index: num))")
                            .font(.body.bold())
                            .frame(width: 80, height: 30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Text("\(m.inputScore)")
                            .font(.body.bold())
                            .frame(width: 80, height: 30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Text(m.inputScore >= progressObj.optionsArray[selectedHabit].goal ? "Yes" : "No")
                            .foregroundColor(m.inputScore >= progressObj.optionsArray[selectedHabit].goal ? Color.reptilegreen : Color.fusionred)
                            .font(.body.bold())
                            .frame(width: 80, height: 30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
                
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(selectedHabit: .constant(0),progressObj: ProgressViewDataHelper(dataType:DataInTime.LastWeek))
    }
}
