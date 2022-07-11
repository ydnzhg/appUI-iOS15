//
//  TrainingHabitView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/13/22.
//

import SwiftUI

struct TrainingHabitView: View {
    
    @Binding var trainingHabit: TrainingHabit

    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    Text("Daily Goal: ")
                        .font(.body.bold())
                        .padding()
                        .background(Color(.systemGray6))
                    Text("\(trainingHabit.goal) \(trainingHabit.units)")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fusionred)
                        .clipShape(RoundedRectangle(cornerSize: CGSize()))
                }
                .cornerRadius(10)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .padding()
                Spacer()
                
            }
            .navigationTitle("\(trainingHabit.title)")
        }
    }
}

struct TrainingHabitView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingHabitView(trainingHabit: .constant(TrainingHabit.sampleData[0]))
    }
}
