//
//  PomodoroPresetStore.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation
import Combine

@MainActor
final class PomodoroPresetStore: ObservableObject {
    static let shared = PomodoroPresetStore()
    
    @Published var presets: [PomodoroPreset] = PomodoroPreset.defaults
    @Published var activePreset: PomodoroPreset
    @Published var breakSuggestions: [BreakActivitySuggestion] = BreakActivitySuggestion.suggestions
    
    private let storageKey = "focusspace_saved_pomodoro_presets"
    
    init() {
        self.activePreset = PomodoroPreset.defaults.first(where: { $0.isDefault }) ?? PomodoroPreset.defaults[0]
        loadPresets()
    }
    
    func selectPreset(_ preset: PomodoroPreset) {
        activePreset = preset
    }
    
    func addCustomPreset(
        name: String,
        description: String,
        focusDuration: Int,
        shortBreak: Int,
        longBreak: Int,
        cycles: Int
    ) {
        let newPreset = PomodoroPreset(
            name: name,
            description: description,
            focusDurationMinutes: focusDuration,
            shortBreakMinutes: shortBreak,
            longBreakMinutes: longBreak,
            cyclesBeforeLongBreak: cycles,
            iconName: "slider.horizontal.3"
        )
        presets.append(newPreset)
        savePresets()
    }
    
    func removePreset(at offsets: IndexSet) {
        presets.remove(atOffsets: offsets)
        savePresets()
    }
    
    private func savePresets() {
        if let encoded = try? JSONEncoder().encode(presets) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadPresets() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([PomodoroPreset].self, from: data) else {
            return
        }
        self.presets = decoded
    }
}
