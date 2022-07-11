//
//  InitialLaunchView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Andy on 6/30/22.
//

import SwiftUI

struct InitialLaunchView: View {
    
    @Binding var signUpSuccess: Bool
    
    @ObservedObject var user = UserInfoDataObject()
    
    var body: some View {
        VStack {
            Image("icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                
            HStack {
                Text("Welcome to")
                    .font(.largeTitle.bold())
                Image("logo")
                    .resizable()
                    .frame(width: 135, height: 42)
            }
            
            InfoEditView(user: user)
            
            Button(action: {
                signUpSuccess = true
                user.commitToDB()
            }) {
                Text("Get Started")
            }
            .padding()
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .background(Color.highblue)
            .font(.title2.bold())
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            
            Spacer()
            
        }
        .navigationTitle("Welcome!")
    }
}

struct InitialLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        InitialLaunchView(signUpSuccess: .constant(false))
    }
}
