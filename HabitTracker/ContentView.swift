//
//  ContentView.swift
//  HabitTracker
//
//  Created by SCOTT CROWDER on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var habits: [String] = [String]()
    
    var body: some View {
        NavigationStack {
            List(habits, id: \.self) { habit in
                Text(habit)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("Add") {
                    habits.append("New habit \(Int.random(in: 0...100))")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
