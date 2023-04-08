//
//  ContentView.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/13.
//

import SwiftUI

struct ContentView: View {
    let pitchLabel: [String] = ["水4", "水3", "水2", "水1", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    let singleKeyLabelFirst: [String] = ["ファ", "ソ", "ファ#", "ソ", "シ♭", "ド#", "レ"]
    let doubleKeyLabelFirst: [String] = ["ド＃", "レ", "ミ", "ラ", "シ", "ド", "ミ", "ファ", "ラ", "シ", "ド", "ミ"]
    let doubleKeyLabelSecond: [String] = ["二’", "四", "水", "乙", "一", "二", "三", "三’", "五", "六", "七", "八"]
    let baseSingleLabelSound: [UInt8] = [54, 56, 67, 68, 71, 74, 75]
    let baseDoubleLabelSound: [UInt8] = [62, 63, 53, 58, 60, 61, 65, 66, 70, 72, 73, 77]
    let frameWidth: CGFloat = 650
    let frameHeight: CGFloat = 350
    @State var location: CGPoint = .zero
    @State private var soundKey: UInt8 = 9
    @AppStorage("whiteMode") private var whiteMode: Bool = true
    
    var body: some View {
        let singleLabelNotes = baseSingleLabelSound.map{ $0 + soundKey }
        let doubleLabelNotes = baseDoubleLabelSound.map{ $0 + soundKey }
        let drag = DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onChanged({ drag in
                location = drag.location
            })
            .onEnded({ _ in
                location = .zero
            })
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center) {
                NowTimeView(whiteMode: whiteMode)
                
                HStack {
                    Button(action: {
                        if (soundKey > 0) {
                            soundKey -= 1
                        }
                    }) {
                        Text("🔽")
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .frame(width: 40, height: 40)
                            .foregroundColor(whiteMode ? .black : .white)
                            .background(whiteMode ? Color.white : Color.black)
                            .cornerRadius(5)
                    }
                    
                    Text("\(pitchLabel[Int(soundKey)])本")
                        .font(.system(size: 24))
                        .foregroundColor(whiteMode ? .black : .white)
                        .frame(width: 100, height: 40)
                    
                    Button(action: {
                        if (soundKey < 17) {
                            soundKey += 1
                        }
                    }) {
                        Text("🔼")
                            .font(.system(size: 40))
                            .frame(width: 40, height: 40)
                            .foregroundColor(whiteMode ? .black : .white)
                            .background(whiteMode ? Color.white : Color.black)
                            .cornerRadius(5)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                HStack(spacing: 3) {
                    ForEach(0..<3) { index in
                        singleLabelKeys(keyNum: index, singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
                    }
                    ForEach(0..<2) { index in
                        doubleLabelKeys(keyNum: index, singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
                    }
                    ForEach(3..<7) { index in
                        singleLabelKeys(keyNum: index, singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
                    }
                }
                
                HStack(alignment: .top, spacing: 3) {
                    ForEach(2..<12) { index in
                        doubleLabelKeys(keyNum: index, singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
                    }
                }
            }
            .gesture(drag)
            .frame(maxWidth: frameWidth, maxHeight: frameHeight)
            .background(whiteMode ? Color.white : Color.black)
                
            Toggle("", isOn: $whiteMode)
                .padding(.top, 10)
                .padding(.trailing, 10)
                .frame(width: frameWidth)
        }
        .frame(maxWidth: frameWidth)
    }
    
    private func singleLabelKeys(keyNum: Int, singleLabelNotes: [UInt8], doubleLabelNotes: [UInt8]) -> some View {
        let view: KeyView
        let model = KeyModel(color: .orange, keyNum: keyNum)
        let soundModel = RingSound(singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
        view = KeyView(model: model, location: self.$location, upperLabel: singleKeyLabelFirst[keyNum], lowerLabel: " ")
        
        return view.onEvent(handler: { (keyInfo) in
            soundModel.called(keyInfo: keyInfo)
        })
    }
    
    private func doubleLabelKeys(keyNum: Int, singleLabelNotes: [UInt8], doubleLabelNotes: [UInt8]) -> some View {
        let view: KeyView
        let model = KeyModel(color: .yellow, keyNum: keyNum)
        let soundModel = RingSound(singleLabelNotes: singleLabelNotes, doubleLabelNotes: doubleLabelNotes)
        view = KeyView(model: model, location: self.$location, upperLabel: doubleKeyLabelFirst[keyNum], lowerLabel: doubleKeyLabelSecond[keyNum])
        
        return view.onEvent(handler: { (keyInfo) in
            soundModel.called(keyInfo: keyInfo)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
