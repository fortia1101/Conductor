//
//  Sampler.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/15.
//

import Foundation
import AVFoundation

class Sampler {
    let audioEngine = AVAudioEngine()
    let unitSampler = AVAudioUnitSampler()
    let noteNum: UInt8
    var isPlaying: Bool = false
    
    init(noteNum: UInt8) {
        self.noteNum = noteNum  // self.noteNum == Sampler().noteNum
        audioEngine.attach(unitSampler)
        audioEngine.connect(unitSampler, to: audioEngine.mainMixerNode, format: nil)
        if let _ = try? audioEngine.start() {
            loadSoundFont()
        }  // if let はオプショナルバインディング
    }
    
    deinit {
        if audioEngine.isRunning {
            audioEngine.disconnectNodeOutput(unitSampler)
            audioEngine.detach(unitSampler)
            audioEngine.stop()
        }
    }
    
    func loadSoundFont() {
        guard let url = Bundle.main.url(forResource: "GeneralUser GS v1.471.sf2", withExtension: "sf2") else { return }
        try? unitSampler.loadSoundBankInstrument(
            at: url, program: 0,
            bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
            bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
    }

    func play() {
        // 一つ目の引数はMIDIのNote番号60は基本のド
        // withVelocityは音量に関係する値 0 ~ 127
        // onChannelはチャンネルを構成しないなら基本0
        if (isPlaying == false) {
            isPlaying = true
            unitSampler.startNote(noteNum, withVelocity: 100, onChannel: 0)
        }
    }

    func stop() {
        if (isPlaying == true) {
            isPlaying = false
            unitSampler.stopNote(noteNum, onChannel: 0)
        }
    }
}
