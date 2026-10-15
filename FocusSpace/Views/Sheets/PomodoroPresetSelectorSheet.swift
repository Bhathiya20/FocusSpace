//
//  PomodoroPresetSelectorSheet.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import SwiftUI

struct PomodoroPresetSelectorSheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var presetStore = PomodoroPresetStore.shared
    
    @State private var showingCustomModal = false
    @State private var customName = ""
    @State private var customFocusMinutes = 30
    @State private var customShortBreak = 5
    @State private var customLongBreak = 15
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Select Timer Preset")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(FocusSpaceTheme.goldPrimary)
                    .padding(.top, 16)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(presetStore.presets) { preset in
                            let isSelected = presetStore.activePreset.id == preset.id
                            
                            HStack(spacing: 16) {
                                Image(systemName: preset.iconName)
                                    .font(.title2)
                                    .foregroundColor(isSelected ? FocusSpaceTheme.goldPrimary : .gray)
                                    .frame(width: 36)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(preset.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(preset.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    HStack(spacing: 8) {
                                        Label("\(preset.focusDurationMinutes)m focus", systemImage: "timer")
                                        Text("•")
                                        Label("\(preset.shortBreakMinutes)m break", systemImage: "cup.and.saucer")
                                        Text("•")
                                        Label("\(preset.longBreakMinutes)m long", systemImage: "figure.walk")
                                    }
                                    .font(.caption2)
                                    .foregroundColor(FocusSpaceTheme.goldPrimary.opacity(0.8))
                                    .padding(.top, 2)
                                }
                                
                                Spacer()
                                
                                if isSelected {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(FocusSpaceTheme.emeraldSuccess)
                                        .font(.title3)
                                }
                            }
                            .padding(14)
                            .background(isSelected ? FocusSpaceTheme.charcoal700 : FocusSpaceTheme.charcoal850)
                            .cornerRadius(FocusSpaceTheme.cardRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: FocusSpaceTheme.cardRadius)
                                    .stroke(isSelected ? FocusSpaceTheme.goldPrimary : FocusSpaceTheme.glassBorder, lineWidth: 1)
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                presetStore.selectPreset(preset)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // Done button
                Button(action: { dismiss() }) {
                    Text("Apply Preset")
                        .fontWeight(.semibold)
                        .foregroundColor(FocusSpaceTheme.charcoal900)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(FocusSpaceTheme.goldPrimary)
                        .cornerRadius(FocusSpaceTheme.buttonRadius)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .background(FocusSpaceTheme.charcoal900)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
