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
                        NavigationLink(habit.title) {
                            Text(habit.title)
                        }
                    }
                }
                .onDelete(perform: onDelete)
            }
        }
    }
}

#Preview {
    ContentView()
}
