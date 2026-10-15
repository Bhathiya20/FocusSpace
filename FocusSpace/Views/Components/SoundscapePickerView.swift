//
//  SoundscapePickerView.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import SwiftUI

struct SoundscapePickerView: View {
    @StateObject private var soundService = SoundscapeAudioService.shared
    @State private var selectedCategory: SoundscapeCategory? = nil
    
    var filteredTracks: [SoundscapeTrack] {
        if let cat = selectedCategory {
            return soundService.availableTracks.filter { $0.category == cat }
        }
        return soundService.availableTracks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Label("Ambient Soundscapes", systemImage: "waveform.path.badge.plus")
                    .font(.headline)
                    .foregroundColor(FocusSpaceTheme.goldPrimary)
                
                Spacer()
                
                Button(action: {
                    soundService.togglePlayback()
                }) {
                    Image(systemName: soundService.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(FocusSpaceTheme.goldPrimary)
                }
                .buttonStyle(.plain)
            }
            
            // Category filter chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Button(action: { selectedCategory = nil }) {
                        Text("All")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedCategory == nil ? FocusSpaceTheme.goldPrimary.opacity(0.25) : FocusSpaceTheme.charcoal700)
                            .foregroundColor(selectedCategory == nil ? FocusSpaceTheme.goldPrimary : .white)
                            .cornerRadius(FocusSpaceTheme.chipRadius)
                    }
                    .buttonStyle(.plain)
                    
                    ForEach(SoundscapeCategory.allCases) { category in
                        Button(action: { selectedCategory = category }) {
                            HStack(spacing: 4) {
                                Image(systemName: category.iconName)
                                Text(category.rawValue)
                            }
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selectedCategory == category ? FocusSpaceTheme.goldPrimary.opacity(0.25) : FocusSpaceTheme.charcoal700)
                            .foregroundColor(selectedCategory == category ? FocusSpaceTheme.goldPrimary : .white)
                            .cornerRadius(FocusSpaceTheme.chipRadius)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            // Track list
            VStack(spacing: 8) {
                ForEach(filteredTracks) { track in
                    let isCurrent = soundService.activeTrack?.id == track.id
                    HStack(spacing: 12) {
                        Image(systemName: track.iconSystemName)
                            .foregroundColor(isCurrent ? FocusSpaceTheme.goldPrimary : .gray)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.name)
                                .font(.subheadline)
                                .fontWeight(isCurrent ? .semibold : .regular)
                                .foregroundColor(.white)
                            
                            Text(track.subtitle)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if isCurrent && soundService.isPlaying {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(FocusSpaceTheme.emeraldSuccess)
                                .font(.caption)
                        }
                    }
                    .padding(10)
                    .background(isCurrent ? FocusSpaceTheme.charcoal700 : FocusSpaceTheme.charcoal850)
                    .cornerRadius(FocusSpaceTheme.buttonRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: FocusSpaceTheme.buttonRadius)
                            .stroke(isCurrent ? FocusSpaceTheme.goldPrimary.opacity(0.5) : Color.clear, lineWidth: 1)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        soundService.selectTrack(track)
                    }
                }
            }
            
            // Volume slider
            HStack(spacing: 12) {
                Image(systemName: "speaker.fill")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Slider(value: Binding(
                    get: { soundService.volume },
                    set: { soundService.setVolume($0) }
                ), in: 0...1)
                .accentColor(FocusSpaceTheme.goldPrimary)
                
                Image(systemName: "speaker.wave.3.fill")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(FocusSpaceTheme.charcoal800.opacity(0.85))
        .cornerRadius(FocusSpaceTheme.cardRadius)
        .overlay(
            RoundedRectangle(cornerRadius: FocusSpaceTheme.cardRadius)
                .stroke(FocusSpaceTheme.glassBorder, lineWidth: 1)
        )
    }
}
