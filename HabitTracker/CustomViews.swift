//
//  CustomViews.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/8/23.
//

import SwiftUI

struct HabitSectionView: View {
    var habits: Habits
    var habitType: HabitType
    var onDelete: (IndexSet) -> Void
    
    var body: some View {
        if habits.containsHabit(ofType: habitType) {
            Section(habitType.rawValue) {
                ForEach(habits.habit) {habit in
                    if habit.type == habitType {
                        NavigationLink {
                            HabitDetailView(habitItem: habit)
                        } label: {
                            VStack (alignment: .leading) {
                                Text(habit.title)
                                Text("Target: \(habit.targetDate.formatted(date: .complete, time: .omitted))")
                                    .font(.caption)
                            }
                        }
                    }
                }
                .onDelete(perform: onDelete)
            }
        }
    }
}

struct HabitDetailView: View {
    let habitItem: HabitItem
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HabitDetailTextView(text: habitItem.id.uuidString, label: "ID")
                HabitDetailTextView(text: habitItem.title, label: "Title")
                HabitDetailTextView(text: habitItem.description, label: "Description")
                HabitDetailTextView(text: habitItem.type.rawValue, label: "Type")
                HabitDetailTextView(text: habitItem.targetDate.formatted(date: .long, time: .complete), label: "Target Date")
                HabitDetailTextView(text: habitItem.dateAdded.formatted(date: .long, time: .complete), label: "Creation Date")
                HabitDetailTextView(text: habitItem.dateLastUpdated.formatted(date: .long, time: .complete), label: "Last Updated")
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

struct HabitDetailTextView: View {
    let text: String
    let label: String
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.indigo)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, minHeight: 50)
        .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust corner radius for desired curvature
                        .stroke(Color.gray, lineWidth: 1) // Adjust border color and line width
                )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
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
    
    private var oneMonthFromNow: Date {
            Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Target Date")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            DatePicker("Target Date", selection: $date, in: oneMonthFromNow..., displayedComponents: .date)
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
