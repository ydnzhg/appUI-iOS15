//
//  ProfileView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isPresentingInfoEditView = false
    @State private var isPresentingGoalEditView = false
    @State private var isPresentingQuoteEditView = false

    @Binding var trainingHabits: [TrainingHabit]
    @Binding var user: User

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle.bold())
                .padding()
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            VStack {
                Image(user.profilePicture)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text(user.name)
                    .font(.title.bold())
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
            }
                        
            Spacer(minLength: 10)
            
            HStack(spacing: 30) {
                VStack {
                    Text("\(user.gender == 0 ? "Male" : "Female")")
                        .font(.title2.bold())
                        .foregroundColor(.highblue)
                    Text("Gender")
                        .foregroundColor(.bluegrey)
                }
                VStack {
                    Text("\(user.age) yrs")
                        .font(.title2.bold())
                        .foregroundColor(.highblue)
                    Text("Age")
                        .foregroundColor(.bluegrey)
                }
                VStack {
                    Text("\(user.height / 12 )'\(user.height % 12)\"")
                        .font(.title2.bold())
                        .foregroundColor(.highblue)
                    Text("Height")
                        .foregroundColor(.bluegrey)
                }
                VStack {
                    Text("\(user.weight) lbs")
                        .font(.title2.bold())
                        .foregroundColor(.highblue)
                    Text("Weight")
                        .foregroundColor(.bluegrey)
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 15)
            
            List {
                Button(action: {
                    isPresentingInfoEditView = true
                }) {
                    HStack {
                        Label("Edit User Information", systemImage: "pencil")
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.highblue)
                }
                .sheet(isPresented: $isPresentingInfoEditView) {
                    NavigationView {
                        InfoEditView(user: $user)
                            .navigationTitle("Edit Info")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingInfoEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isPresentingInfoEditView = false
                                    }
                                }
                            }
                    }
                }
                Button(action: {
                    isPresentingGoalEditView = true
                }) {
                    HStack {
                        Label("Change Daily Goals", systemImage: "flag.2.crossed.fill")
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.highblue)
                }
                .sheet(isPresented: $isPresentingGoalEditView) {
                    NavigationView {
                        GoalEditView(trainingHabits: $trainingHabits)
                            .navigationTitle("Change Goals")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingGoalEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isPresentingGoalEditView = false
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(trainingHabits: .constant(TrainingHabit.sampleData), user: .constant(User.sampleData))
    }
}
