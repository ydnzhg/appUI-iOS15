//
//  GoalEditView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct GoalEditView: View {
    
    @Binding var trainingHabits: [TrainingHabit]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach($trainingHabits) { $trainingHabit in
                    TrainingHabitGoalTextField(trainingHabit: $trainingHabit)
                }
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    static var previews: some View {
        GoalEditView(trainingHabits: .constant(TrainingHabit.sampleData))
    }
}

struct TrainingHabitGoalTextField: View {
    
    @Binding var trainingHabit: TrainingHabit
    
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
                Spacer()
                TextField("\(trainingHabit.units)", value: $trainingHabit.goal, format: .number)
                    .font(.body.bold())
                    .foregroundColor(.highblue)
                    .frame(width: 100)
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

