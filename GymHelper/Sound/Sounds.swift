//
//  Sounds.swift
//  GymHelper
//
//  Created by yook on 2023/03/17.
//


import AVKit

let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    init(player: AVAudioPlayer? = nil) {
        self.player = player
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        } catch {
            print("Failed to set audio session category.")
        }
    }
    
    func playSoundComplete() {
        guard let url = Bundle.main.url(forResource: "CompleteDiriding", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    
    func playSoundCountup() {
        guard let url = Bundle.main.url(forResource: "countupBlip", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    func playSoundMicrowaveDing() {
        guard let url = Bundle.main.url(forResource: "microwaveDing", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    func playSoundReady() {
        guard let url = Bundle.main.url(forResource: "ready", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    func playSoundStart() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    func playSoundThreeTwoOne() {
        guard let url = Bundle.main.url(forResource: "ready", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
    func playSoundForCountdown() {
        guard let url = Bundle.main.url(forResource: "Countdownding", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error about sound.\(error.localizedDescription)")
        }
    }
}


