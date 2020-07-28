//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()

    private var player: AVAudioPlayer?

    override init() {
        guard let themeSongUrl = Bundle.main.url(forResource: "Jeopardy-theme-song", withExtension: "mp3") else {
            print("Can't find the song")
            return
        }
        
        player = try? AVAudioPlayer(contentsOf: themeSongUrl)
        player?.numberOfLoops = -1
    }
    
    var isSoundEnabled: Bool {
        get {
            // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
            // You might want to use `object`, because if an object has not been set yet it will be nil
            // Then if it's nil you know it's the user's first time launching the app
            UserDefaults.standard.bool(forKey: "sound")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "sound")
        }
    }

    func toggleSound() {
        if let player = player {
            if isSoundEnabled {
                player.play()
            } else {
                player.pause()
            }
        }
    }

    func toggleSoundPreference() {
        isSoundEnabled.toggle()
        toggleSound()
    }

}
