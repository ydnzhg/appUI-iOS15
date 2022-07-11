//
//  GoalEditView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/13/22.
//

import SwiftUI

struct GoalEditView: View {
    
    @ObservedObject var traceOptionsObject : ProfileViewDataHelper
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<traceOptionsObject.optionsArray.count) { num in
                    TrainingHabitGoalTextField(trainingHabit: $traceOptionsObject.optionsArray[num])
                }
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    static var previews: some View {
        GoalEditView(traceOptionsObject: ProfileViewDataHelper())
    }
}

struct TrainingHabitGoalTextField: View {
    
    @Binding var trainingHabit: TraceOptionsDataModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: trainingHabit.icon)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(trainingHabit.palette.mainColor)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            HStack {
                Text("\(trainingHabit.title) Goal:")
                    .foregroundColor(Color.black.opacity(0.7))
                TextField("\(trainingHabit.unit)", value: $trainingHabit.goal, format: .number)
                    .font(.body.bold())
                    .foregroundColor(.highblue)
                    .padding(5)
                    .padding(.horizontal, 3)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.4), lineWidth: 1)
                    )
            }
            .padding()
            .padding(.leading, 60)
            .frame(height: 60)
            .background(Color.bluegrey.opacity(0.1))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

