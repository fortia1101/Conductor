//
//  RingSound.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/04/03.
//

import Foundation

class RingSound {
    let singleLabelNotes: [UInt8]
    let doubleLabelNotes: [UInt8]
    let sampler: Sampler
    
    init(singleLabelNotes: [UInt8], doubleLabelNotes: [UInt8]) {
        self.singleLabelNotes = singleLabelNotes
        self.doubleLabelNotes = doubleLabelNotes
        self.sampler = Sampler(singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
    }
    
    func called(keyInfo: KeyInfo) {
        if (keyInfo.isPressed == true) {
            sampler.play(keyInfo: keyInfo)
        } else {
            sampler.stop(keyInfo: keyInfo)
        }
    }
}
