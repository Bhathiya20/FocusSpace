//
//  SoundscapeAudioService.swift
//  FocusSpace
//
//  Created by Rusheni Botheju on 2026-10-16.
//

import Foundation
import Combine
import AVFoundation

@MainActor
final class SoundscapeAudioService: ObservableObject {
    static let shared = SoundscapeAudioService()
    
    @Published var availableTracks: [SoundscapeTrack] = SoundscapeTrack.presets
    @Published var activeTrack: SoundscapeTrack? = nil
    @Published var isPlaying: Bool = false
    @Published var volume: Double = 0.6
    @Published var isMuted: Bool = false
    
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        self.activeTrack = availableTracks.first
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        #if os(iOS) || os(visionOS)
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
        } catch {
            print("[SoundscapeAudioService] Audio session error: \(error.localizedDescription)")
        }
        #endif
    }
    
    func selectTrack(_ track: SoundscapeTrack) {
        let wasPlaying = isPlaying
        activeTrack = track
        volume = track.defaultVolume
        
        if wasPlaying {
            playTrack(track)
        }
    }
    
    func playTrack(_ track: SoundscapeTrack) {
        activeTrack = track
        isPlaying = true
        // Simulated playback or AVPlayer loading when asset is available
        print("[SoundscapeAudioService] Playing soundscape: \(track.name)")
    }
    
    func pause() {
        isPlaying = false
        audioPlayer?.pause()
    }
    
    func togglePlayback() {
        if isPlaying {
            pause()
        } else if let track = activeTrack {
            playTrack(track)
        }
    }
    
    func setVolume(_ newVolume: Double) {
        volume = max(0.0, min(1.0, newVolume))
        audioPlayer?.volume = Float(volume)
    }
    
    func toggleMute() {
        isMuted.toggle()
        if isMuted {
            audioPlayer?.volume = 0
        } else {
            audioPlayer?.volume = Float(volume)
        }
    }
}
