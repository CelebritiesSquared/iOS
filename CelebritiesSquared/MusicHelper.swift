//
//  MusicHelper.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 10/9/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    var playing = false;
    
    func playBackgroundMusic() {
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: "eots", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            playing = true
        } catch {
            print("Cannot play the file")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer!.stop()
        playing = false
    }
}
