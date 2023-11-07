//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

struct AddHabitView: View {
    @State private var habitTitle: String = ""
    @State private var description: String = ""
    @State private var targetDate: Date = Date()
    @State private var creationDate: Date = Date()
    @State private var habitType: HabitType = .personal
    
    @Binding var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HabitFormTextField(text: $habitTitle, label: "title")
                    .padding(.top, 30)
                
                HabitFormPicker(selection: $habitType, pickerStyle: SegmentedPickerStyle())
                
                HabitFormTextEditor(text: $description, label: "purpose")
                
                HabitFormDatePicker(date: $targetDate)
            }
            .navigationTitle("Create a New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newHabit: HabitItem = HabitItem(title: habitTitle, description: description, type: habitType, targetDate: targetDate, dateAdded: creationDate, dateLastUpdated: creationDate)
                        habits.habit.append(newHabit)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
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
        .padding(.horizontal, 20)
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

struct HabitFormTextEditor: View {
    @Binding var text: String
    var label: String
    var body: some View {
        VStack (alignment: .leading){
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.indigo)
            TextEditor(text: $text)
                .frame(height: 100)
        }
        .padding(.horizontal, 20)
        .frame(height: 150)
        .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius for desired curvature
                        .stroke(Color.gray, lineWidth: 1) // Adjust border color and line width
                )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        //.padding(.vertical, 10)
    }
}

struct HabitFormPicker<Style>: View where Style: PickerStyle{
    @Binding var selection: HabitType
    var pickerStyle: Style
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("habit type")
                .font(.caption)
                .foregroundStyle(Color(.indigo))
                .padding(.leading, 20)
            Picker("Type", selection: $selection) {
                ForEach(HabitType.allCases, id: \.self) { habitType in
                    Text(habitType.rawValue)
                }
            }
            .padding(.horizontal, 20)
            .pickerStyle(pickerStyle)
        }
        .frame(width: 350, height: 75)
        .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius for desired curvature
                        .stroke(Color.gray, lineWidth: 1) // Adjust border color and line width
                )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct HabitFormDatePicker: View {
    @Binding var date: Date
    var body: some View {
        VStack (alignment: .leading) {
            Text("Target Date")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            DatePicker("Target Date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
        }
            .padding(.horizontal, 20)
            .frame(width: 350, height: 425)
            .overlay(
                        RoundedRectangle(cornerRadius: 10) // Adjust corner radius for desired curvature
                            .stroke(Color.gray, lineWidth: 1) // Adjust border color and line width
                    )
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

#Preview {
    @State var habits: Habits = Habits()
    return AddHabitView(habits: $habits)
}
