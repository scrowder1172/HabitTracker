//
//  ContentView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

/// Last place: Created class and need to add class to add form to save habits
/// wanted to use enum for drop list of habit type
/// integrate class into add process

struct ContentView: View {
    @State private var habits: Habits = Habits()
    
    var body: some View {
        NavigationStack {
            
            List {
                HabitSectionView(habits: habits, habitType: .personal, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .health, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .work, onDelete: removeItem)
                HabitSectionView(habits: habits, habitType: .school, onDelete: removeItem)
            }
            .navigationTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton())
            .toolbar {
                NavigationLink {
                    AddHabitView(habits: $habits)
                } label: {
                    Label("Add Habit", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItem(at offset: IndexSet) {
        habits.habit.remove(atOffsets: offset)
    }
}

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

#Preview {
    ContentView()
}
