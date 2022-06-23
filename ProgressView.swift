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
    
    @State private var isExpanded: Bool = false
    
    let daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
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
                .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.5), Color.highblue.opacity(0.8))))
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
                
                DisclosureGroup {
                    HStack(spacing: 10) {
                        VStack(spacing: 5) {
                            
                            let sum = trainingHabits[selectedHabit].lastWeek.reduce(0, +)
                            
                            Text("\(sum / trainingHabits[selectedHabit].lastWeek.count) \(trainingHabits[selectedHabit].shortUnits)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("Weekly Average")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 80)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 1)
                        
                        VStack(spacing: 5) {
                            Text("\(trainingHabits[selectedHabit].lastWeek.min() ?? 8)  |  \(trainingHabits[selectedHabit].lastWeek.max() ?? 8)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("Min and Max")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 80)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 1)
                        
                        VStack(spacing: 5) {
                            Text("Test%")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("Trend")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 80)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 1)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                } label: {
                    Label("Insights", systemImage: "lightbulb.fill")
                        .font(.title3.bold())
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .accentColor(Color.highblue)
                .background(RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.systemGray6))
                )
                .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    Text("Date")
                        .frame(width: 100)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.highblue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    Text("\(trainingHabits[selectedHabit].units.capitalized)")
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
                    ForEach(0..<7) { num in
                        Text("\(daysOfTheWeek[num])")
                            .font(.body.bold())
                            .frame(width: 80, height: 30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Text("\(trainingHabits[selectedHabit].lastWeek[num])")
                            .font(.body.bold())
                            .foregroundColor(.highblue)
                            .frame(width: 80, height: 30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Text(trainingHabits[selectedHabit].lastWeek[num] >= trainingHabits[selectedHabit].goal ? "Yes" : "No")
                            .foregroundColor(trainingHabits[selectedHabit].lastWeek[num] >= trainingHabits[selectedHabit].goal ? Color.reptilegreen : Color.fusionred)
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
        ProgressView(trainingHabits: .constant(TrainingHabit.sampleData), selectedHabit: .constant(0))
    }
}
