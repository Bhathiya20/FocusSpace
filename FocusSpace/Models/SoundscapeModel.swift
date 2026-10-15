//
//  SoundscapeModel.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation
import SwiftUI

// MARK: - Soundscape Category
enum SoundscapeCategory: String, CaseIterable, Codable, Identifiable {
    case nature = "Nature"
    case ambient = "Ambient"
    case binaural = "Binaural Beats"
    case noise = "Colored Noise"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .nature:
            return "leaf.fill"
        case .ambient:
            return "waveform"
        case .binaural:
            return "headphones"
        case .noise:
            return "wind"
        }
    }
}

// MARK: - Soundscape Track Model
struct SoundscapeTrack: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var subtitle: String
    var category: SoundscapeCategory
    var audioFileName: String
    var iconSystemName: String
    var defaultVolume: Double = 0.6
    var isFavorite: Bool = false
    
    static let presets: [SoundscapeTrack] = [
        SoundscapeTrack(
            name: "Deep Forest Rain",
            subtitle: "Gentle raindrops on pine foliage",
            category: .nature,
            audioFileName: "forest_rain.mp3",
            iconSystemName: "cloud.rain.fill",
            defaultVolume: 0.65
        ),
        SoundscapeTrack(
            name: "Midnight Coffeehouse",
            subtitle: "Subtle murmur and warm acoustic ambiance",
            category: .ambient,
            audioFileName: "coffeehouse.mp3",
            iconSystemName: "cup.and.saucer.fill",
            defaultVolume: 0.5
        ),
        SoundscapeTrack(
            name: "Alpha Wave Theta 14Hz",
            subtitle: "Deep focus and cognitive immersion",
            category: .binaural,
            audioFileName: "alpha_binaural_14hz.mp3",
            iconSystemName: "brain.head.profile",
            defaultVolume: 0.7
        ),
        SoundscapeTrack(
            name: "Cosmic Pink Noise",
            subtitle: "Balanced frequency spectrum for distraction blocking",
            category: .noise,
            audioFileName: "pink_noise.mp3",
            iconSystemName: "sparkles",
            defaultVolume: 0.45
        ),
        SoundscapeTrack(
            name: "Oceanic Solitude",
            subtitle: "Rhythmic waves rolling onto pebbles",
            category: .nature,
            audioFileName: "ocean_solitude.mp3",
            iconSystemName: "water.waves",
            defaultVolume: 0.6
        )
    ]
}
