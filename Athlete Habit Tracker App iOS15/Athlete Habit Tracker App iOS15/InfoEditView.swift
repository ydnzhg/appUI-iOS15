//
//  InfoEditView.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

struct InfoEditView: View {
    
    @Binding var user: User
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            NameEditTextField(image: "signature", label: "Name: ", value: $user.name)
            
            GenderPicker(image: "person.fill", label: "Gender: ", value: $user.gender)
            
            InfoEditTextField(image: "calendar", placeholder: "Age: ", units: "yrs",value: $user.age)
            
            InfoEditTextField(image: "ruler.fill", placeholder: "Height: ", units: "in", value: $user.height)
            
            InfoEditTextField(image: "scalemass.fill", placeholder: "Weight: ", units: "lbs", value: $user.weight)

            Spacer()
        }
        .padding(.horizontal, 5)
    }
}


struct InfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        InfoEditView(user: .constant(User.sampleData))
    }
}


struct NameEditTextField: View {
    
    var image: String
    var label: String
    
    @Binding var value: String
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: image)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.fusionred)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            TextField(label, text: $value)
                .padding()
                .padding(.leading, 60)
                .frame(height: 60)
                .background(Color.bluegrey.opacity(0.1))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct GenderPicker: View {
    
    var image: String
    var label: String
    @Binding var value: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: image)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.fusionred)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            HStack {
                Text(label)
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                Picker(label, selection: $value) {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                }
                .frame(width: 135)
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .padding(.leading, 60)
            .padding(.trailing, 10)
            .frame(height: 60)
            .background(Color.bluegrey.opacity(0.1))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct InfoEditTextField: View {
    
    var image: String
    var placeholder: String
    var units: String
    
    @Binding var value: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: image)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.fusionred)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

            HStack {
                Text(placeholder)
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                TextField("info", value: $value, format: .number)
                    .font(.body.bold())
                    .foregroundColor(.highblue)
                    .frame(width: 30)
                Text(units)
                    .foregroundColor(Color.black.opacity(0.7))
                    .padding(.trailing,10)
                    .frame(width: 40)
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
