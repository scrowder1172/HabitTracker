//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

struct AddHabitView: View {
    @State private var habitName: String = ""
    @State private var purpose: String = ""
    @State private var creationDate: Date = Date()
    
    @Binding var habits: [String]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HabitFormTextField(text: $habitName, label: "name")
                    .padding(.top, 30)
                HabitFormTextField(text: $purpose, label: "purpose")
            }
            .frame(maxHeight: 200)
            .navigationTitle("Create a New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        habits.append(habitName)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            Text(creationDate.formatted(date: .abbreviated, time: .shortened))
            Spacer()
        }
    }
}

struct HabitFormTextField: View {
    @Binding var text: String
    var label: String
    var body: some View {
        VStack (alignment: .leading){
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.indigo)
            TextField(label, text: $text)
        }
        .padding(.horizontal, 50)
        .frame(height: 50)
        .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius for desired curvature
                        .stroke(Color.gray, lineWidth: 1) // Adjust border color and line width
                )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        //.padding(.vertical, 10)
    }
}

#Preview {
    @State var habits: [String] = [String]()
    return AddHabitView(habits: $habits)
}
