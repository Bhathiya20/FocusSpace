//
//  PomodoroPresetModel.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation
import SwiftUI

// MARK: - Pomodoro Preset Configuration
struct PomodoroPreset: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var focusDurationMinutes: Int
    var shortBreakMinutes: Int
    var longBreakMinutes: Int
    var cyclesBeforeLongBreak: Int
    var iconName: String
    var isDefault: Bool = false
    
    static let defaults: [PomodoroPreset] = [
        PomodoroPreset(
            name: "Classic Pomodoro",
            description: "Standard interval for everyday productivity",
            focusDurationMinutes: 25,
            shortBreakMinutes: 5,
            longBreakMinutes: 15,
            cyclesBeforeLongBreak: 4,
            iconName: "timer",
            isDefault: true
        ),
        PomodoroPreset(
            name: "Deep Flow State",
            description: "Extended focus for complex engineering and research",
            focusDurationMinutes: 50,
            shortBreakMinutes: 10,
            longBreakMinutes: 25,
            cyclesBeforeLongBreak: 3,
            iconName: "bolt.shield.fill"
        ),
        PomodoroPreset(
            name: "Ultradian Rhythm",
            description: "Natural 90-minute human biological energy cycle",
            focusDurationMinutes: 90,
            shortBreakMinutes: 20,
            longBreakMinutes: 30,
            cyclesBeforeLongBreak: 2,
            iconName: "brain.head.profile"
        ),
        PomodoroPreset(
            name: "Quick Sprint",
            description: "Bite-sized burst to conquer procrastination",
            focusDurationMinutes: 15,
            shortBreakMinutes: 3,
            longBreakMinutes: 10,
            cyclesBeforeLongBreak: 4,
            iconName: "hare.fill"
        )
    ]
}

// MARK: - Break Activity Suggestion
struct BreakActivitySuggestion: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var icon: String
    var durationMinutes: Int
    var category: String
    
    static let suggestions: [BreakActivitySuggestion] = [
        BreakActivitySuggestion(title: "Eye Relief 20-20-20", icon: "eye.fill", durationMinutes: 1, category: "Physical"),
        BreakActivitySuggestion(title: "Hydration & Neck Stretch", icon: "drop.fill", durationMinutes: 3, category: "Wellness"),
        BreakActivitySuggestion(title: "Mindful Box Breathing", icon: "wind", durationMinutes: 5, category: "Mental"),
        BreakActivitySuggestion(title: "Brisk Outdoor Walk", icon: "figure.walk", durationMinutes: 10, category: "Movement")
    ]
}
