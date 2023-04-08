//
//  KeyModel.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/04/02.
//

import SwiftUI
import Combine

enum KeyColor {
    case orange
    case yellow
    
    func value(isHit: Bool) -> Color {
        switch self {
        case .orange: return isHit ? Color(red: 1.0, green: 0.58, blue: 0.0, opacity: 0.5)
            : Color(red: 1.0, green: 0.58, blue: 0.0, opacity: 1.0)
        case .yellow: return isHit ? Color(red: 1.0, green: 0.8, blue: 0.0, opacity: 0.5)
            : Color(red: 1.0, green: 0.8, blue: 0.0, opacity: 1.0)
        }
    }
}

struct KeyInfo {
    let color: KeyColor
    let keyNum: Int
    let isPressed: Bool
}

class KeyModel: ObservableObject {
    let subject = PassthroughSubject<KeyInfo, Never>()
    let color: KeyColor
    let keyNum: Int
    var isHit: Bool = false {
        didSet {
            if (oldValue != isHit) {
                if (isHit == true) {
                    play()
                } else {
                    stop()
                }
            }
        }
    }
    
    init(color: KeyColor, keyNum: Int) {
        self.color = color
        self.keyNum = keyNum
    }

    private func play() {
        subject.send(KeyInfo(color: color, keyNum: keyNum, isPressed: true))
    }

    private func stop() {
        subject.send(KeyInfo(color: color, keyNum: keyNum, isPressed: false))
    }
    
    func getColor() -> Color {
        return color.value(isHit: isHit)
    }
}

