//
//  RehabView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct RehabView: View {
    
    @Binding var workoutInfo: WorkoutInfo

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                WorkoutQuestion(selection: $workoutInfo.completed)
                
                if workoutInfo.completed == 1 {
                    BodyPartQuestion(selection: $workoutInfo.bodyPart)
                    
                    SetsAndIntensityQuestion(sets: $workoutInfo.sets, intensity: $workoutInfo.intensity)
                    
                    PainQuestion(pain: $workoutInfo.pain)
                    
                    Spacer()
                }
            }
        }
    }
}

struct RehabView_Previews: PreviewProvider {
    static var previews: some View {
        RehabView(workoutInfo: .constant(WorkoutInfo.today))
    }
}

struct WorkoutQuestion: View {
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.highblue)
                .padding(.horizontal)
                .frame(width: 400, height: 100)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            VStack {
                Text("Did you workout today?")
                    .foregroundColor(.white)
                    .font(.title3.bold())
                    .padding(5)
                Picker(selection: $selection, label: Text("Picker")) {
                    Text("Yes").tag(1)
                    Text("No").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct BodyPartQuestion: View {
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .padding(.horizontal)
                .foregroundColor(.fusionred)
                .frame(width: 400, height: 100)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            VStack {
                Text("Which body part did you workout?")
                    .foregroundColor(.white)
                    .font(.title3.bold())
                    .padding(5)
                Picker(selection: $selection, label: Text("Picker")) {
                    Text("Upper").tag(0)
                    Text("Lower").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct SetsAndIntensityQuestion: View {
    @Binding var sets: Int
    @Binding var intensity: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.reptilegreen)
                .padding(.horizontal)
                .frame(width: 400, height: 160)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            VStack {
                Text("What was the number of sets and the intensity?")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title3.bold())
                VStack {
                    HStack {
                        Text("\(sets) sets")
                            .foregroundColor(.white)
                            .font(.body.bold())
                        Stepper(value: $sets, in: 0...10) {
                        }
                    }
                    HStack {
                        Text("\(Int(intensity)) RPE")
                            .foregroundColor(.white)
                            .font(.body.bold())
                        Spacer(minLength: 20)
                        Slider(value: $intensity, in: 0...10, step: 1) {
                            Text("RPE")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct PainQuestion: View {
    
    @Binding var pain: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.orangehibiscus)
                .padding(.horizontal)
                .frame(width: 400, height: 100)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            VStack {
                Text("How much pain were you in?")
                    .foregroundColor(.white)
                    .font(.title3.bold())
                    .padding(5)
                HStack {
                    Text("\(Int(pain))")
                        .foregroundColor(.white)
                        .font(.body.bold())
                    Spacer(minLength: 20)
                    Slider(value: $pain, in: 0...10, step: 1) {
                        Text("RPE")
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}
