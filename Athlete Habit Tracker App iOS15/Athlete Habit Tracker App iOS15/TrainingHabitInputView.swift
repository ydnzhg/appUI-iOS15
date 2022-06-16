//
//  TrainingHabitInputView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct TrainingHabitInputView: View {
    
   // @Binding var trainingHabits: [TrainingHabit]
    @ObservedObject var traceOptionsObject : DailyViewDataHelper
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0..<traceOptionsObject.optionsArray.count) { num in
                    TrainingHabitInputTextField(trainingHabit: $traceOptionsObject.optionsArray[num], placeholder: "\(traceOptionsObject.optionsArray[num].title)")
                }
                //ForEach($trainingHabits) { $trainingHabit in
                 //   TrainingHabitInputTextField(trainingHabit: $trainingHabit, placeholder: "\(trainingHabit.title)")
                //}
                Spacer()
            }
        }
    }
}

struct TrainingHabitInputView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingHabitInputView(traceOptionsObject: DailyViewDataHelper(detail: true, date: Date()))
    }
}

struct TrainingHabitInputTextField: View {
    
    @Binding var trainingHabit: TraceOptionsDataModel
    var placeholder: String
    
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
                Text("\(placeholder): ")
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                TextField("\(trainingHabit.unit)", value: $trainingHabit.inputScore, format: .number)
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
