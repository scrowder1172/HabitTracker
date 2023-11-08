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
    private let creationDate: Date = Date()
    private let lastUpdateDate: Date = Date()
    @State private var habitType: HabitType = .personal
    
    @State private var isShowingAlert: Bool = false
    
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
                        let newHabit: HabitItem = HabitItem(title: habitTitle, description: description, type: habitType, targetDate: targetDate, dateAdded: creationDate, dateLastUpdated: lastUpdateDate)
                        if newHabit.canSave {
                            habits.habit.append(newHabit)
                            dismiss()
                        } else {
                            isShowingAlert = true
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $isShowingAlert) {
                Button("OK") {}
            } message: {
                Text("Please provide a title before saving.")
            }
        }
    }
}

#Preview {
    @State var habits: Habits = Habits()
    return AddHabitView(habits: $habits)
}
