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

    @Binding var isGoalAlter : Bool
    @ObservedObject var user = UserInfoDataObject()
    @ObservedObject var traceOptionsObject = ProfileViewDataHelper()
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle.bold())
                .padding()
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            VStack {
                Image(user.picturePath)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text(user.userName)
                    .font(.title.bold())
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
            }
                                    
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
                    Text("\(user.heightInchesEx / 12 )'\(user.heightInchesEx % 12)\"")
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
            
            VStack(spacing: 15) {
                Button(action: {
                    isPresentingInfoEditView = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(.systemGray6))
                            .frame(height: 45)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        HStack {
                            Label("Edit User Information", systemImage: "pencil")
                                .font(.body.bold())
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.highblue)
                        .padding(.horizontal, 30)
                    }
                    
                }
                .sheet(isPresented: $isPresentingInfoEditView) {
                    NavigationView {
                        InfoEditView(user: user)
                            .navigationTitle("Edit Info")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingInfoEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        user.commitToDB()
                                        isPresentingInfoEditView = false
                                    }
                                }
                            }
                    }
                }
                
                Button(action: {
                    isPresentingGoalEditView = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(.systemGray6))
                            .frame(height: 45)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        
                        HStack {
                            Label("Change Daily Goals", systemImage: "flag.2.crossed.fill")
                                .font(.body.bold())
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.highblue)
                        .padding(.horizontal, 30)
                    }
                }
                .sheet(isPresented: $isPresentingGoalEditView) {
                    NavigationView {
                        GoalEditView(traceOptionsObject: traceOptionsObject)
                            .navigationTitle("Change Goals")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingGoalEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isGoalAlter = true
                                        traceOptionsObject.commitToOptionsDB()
                                        isPresentingGoalEditView = false
                                    }
                                }
                            }
                    }
                }
            }
            
            
            Spacer()

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isGoalAlter:.constant(false), user: UserInfoDataObject())
    }
}
