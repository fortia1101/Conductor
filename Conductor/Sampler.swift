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
    let singleLabelNotes: [UInt8]
    let doubleLabelNotes: [UInt8]
    
    init(singleLabelNotes: [UInt8], doubleLabelNotes: [UInt8]) {
        self.singleLabelNotes = singleLabelNotes
        self.doubleLabelNotes = doubleLabelNotes
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
        guard let url = Bundle.main.url(forResource: "emuaps_8mb.sf2", withExtension: "sf2") else { return }
        try? unitSampler.loadSoundBankInstrument(
            at: url, program: 0,
            bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
            bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
    }
    
    private func convert(keyInfo: KeyInfo) -> UInt8 {
        if (keyInfo.color == .orange) {
            return singleLabelNotes[keyInfo.keyNum]
        } else if (keyInfo.color == .yellow) {
            return doubleLabelNotes[keyInfo.keyNum]
        } else {
            fatalError("Unset color")
        }
    }

    func play(keyInfo: KeyInfo) {
        // 一つ目の引数はMIDIのNote番号60は基本のド
        // withVelocityは音量に関係する値 0 ~ 127
        // onChannelはチャンネルを構成しないなら基本0
        let noteNum = convert(keyInfo: keyInfo)
        unitSampler.startNote(noteNum, withVelocity: 120, onChannel: 0)
    }

    func stop(keyInfo: KeyInfo) {
        let noteNum = convert(keyInfo: keyInfo)
        unitSampler.stopNote(noteNum, onChannel: 0)
    }
}
