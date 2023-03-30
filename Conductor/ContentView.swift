//
//  ContentView.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/13.
//

import SwiftUI
import AVFoundation

struct ConductorView: View {
    let pitchLabel: [String] = ["水4", "水3", "水2", "水1", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    let upperKeyLabelFirst: [String] = ["ファ", "ソ", "ド＃", "レ", "ファ#", "ソ", "シ♭", "ド#", "レ"]
    let upperKeyLabelSecond: [String] = [" ", " ", " ", "二’", "四", " ", " ", " ", " "]
    let lowerKeyLabelFirst: [String] = ["ミ", "ラ", "シ", "ド", "ミ", "ファ", "ラ", "シ", "ド", "ミ"]
    let lowerKeyLabelSecond: [String] = ["水", "乙", "一", "二", "三", "三’", "五", "六", "七", "八"]
    var upperKeySound: [UInt8] = [54, 56, 62, 63, 67, 68, 71, 74, 75]
    var lowerKeySound: [UInt8] = [53, 58, 60, 61, 65, 66, 70, 72, 73, 77]
    let upperKeyWidth: CGFloat = 63
    let lowerKeyWidth: CGFloat = 63
    let upperKeyHeight: CGFloat = 110
    let lowerKeyHeight: CGFloat = 110
    let upperMinX: CGFloat = 33.5
    let lowerMinX: CGFloat = 0
    let upperMinY: CGFloat = 108
    let lowerMinY: CGFloat = 227
    let keyGap: CGFloat = 3
    
    @State private var noteNum: UInt8 = 0
    @State private var soundKey: UInt8 = 9
    @State private var location: CGPoint = .zero
    @State private var startLocation: CGPoint = .zero
    @State private var nowPlaying: String = ""
    @State private var oldPlaying: String = ""
    @AppStorage("whiteMode") private var whiteMode: Bool = true
    
    var body: some View {
        let sampler = Sampler(noteNum: noteNum)
        
        let drag = DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
            .onChanged({ drag in
                location = drag.location
                startLocation = drag.startLocation
                
                if (startLocation.y >= upperMinY && startLocation.y <= (lowerMinY + lowerKeyHeight)) {
                    if (location.y >= upperMinY && location.y <= (upperMinY + upperKeyHeight)) {
                        switch (location.x) {
                        case (upperMinX ... (upperMinX + upperKeyWidth)):
                            noteNum = upperKeySound[0] + soundKey
                            nowPlaying = upperKeyLabelFirst[0]
                        case ((upperMinX + upperKeyWidth + keyGap) ... (upperMinX + 2 * upperKeyWidth + keyGap)):
                            noteNum = upperKeySound[1] + soundKey
                            nowPlaying = upperKeyLabelFirst[1]
                        case ((upperMinX + 2 * upperKeyWidth + 2 * keyGap) ... (upperMinX + 3 * upperKeyWidth + 2 * keyGap)):
                            noteNum = upperKeySound[2] + soundKey
                            nowPlaying = upperKeyLabelFirst[2]
                        case((upperMinX + 3 * upperKeyWidth + 3 * keyGap) ... (upperMinX + 4 * upperKeyWidth + 3 * keyGap)):
                            noteNum = upperKeySound[3] + soundKey
                            nowPlaying = upperKeyLabelSecond[3]
                        case((upperMinX + 4 * upperKeyWidth + 4 * keyGap) ... (upperMinX + 5 * upperKeyWidth + 4 * keyGap)):
                            noteNum = upperKeySound[4] + soundKey
                            nowPlaying = upperKeyLabelSecond[4]
                        case((upperMinX + 5 * upperKeyWidth + 5 * keyGap) ... (upperMinX + 6 * upperKeyWidth + 5 * keyGap)):
                            noteNum = upperKeySound[5] + soundKey
                            nowPlaying = upperKeyLabelFirst[5]
                        case((upperMinX + 6 * upperKeyWidth + 6 * keyGap) ... (upperMinX + 7 * upperKeyWidth + 6 * keyGap)):
                            noteNum = upperKeySound[6] + soundKey
                            nowPlaying = upperKeyLabelFirst[6]
                        case((upperMinX + 7 * upperKeyWidth + 7 * keyGap) ... (upperMinX + 8 * upperKeyWidth + 7 * keyGap)):
                            noteNum = upperKeySound[7] + soundKey
                            nowPlaying = upperKeyLabelFirst[7]
                        case((upperMinX + 8 * upperKeyWidth + 8 * keyGap) ... (upperMinX + 9 * upperKeyWidth + 8 * keyGap)):
                            noteNum = upperKeySound[8] + soundKey
                            nowPlaying = upperKeyLabelFirst[8]
                        default:
                            noteNum = 0
                        }
                    } else if (location.y >= lowerMinY && location.y <= (lowerMinY + lowerKeyHeight)) {
                        switch (location.x) {
                        case (lowerMinX ... (lowerMinX + lowerKeyWidth)):
                            noteNum = lowerKeySound[0] + soundKey
                            nowPlaying = lowerKeyLabelSecond[0]
                        case ((lowerMinX + lowerKeyWidth + keyGap) ... (lowerMinX + 2 * lowerKeyWidth + keyGap)):
                            noteNum = lowerKeySound[1] + soundKey
                            nowPlaying = lowerKeyLabelSecond[1]
                        case ((lowerMinX + 2 * lowerKeyWidth + 2 * keyGap) ... (lowerMinX + 3 * lowerKeyWidth + 2 * keyGap)):
                            noteNum = lowerKeySound[2] + soundKey
                            nowPlaying = lowerKeyLabelSecond[2]
                        case((lowerMinX + 3 * lowerKeyWidth + 3 * keyGap) ... (lowerMinX + 4 * lowerKeyWidth + 3 * keyGap)):
                            noteNum = lowerKeySound[3] + soundKey
                            nowPlaying = lowerKeyLabelSecond[3]
                        case((lowerMinX + 4 * lowerKeyWidth + 4 * keyGap) ... (lowerMinX + 5 * lowerKeyWidth + 4 * keyGap)):
                            noteNum = lowerKeySound[4] + soundKey
                            nowPlaying = lowerKeyLabelSecond[4]
                        case((lowerMinX + 5 * lowerKeyWidth + 5 * keyGap) ... (lowerMinX + 6 * lowerKeyWidth + 5 * keyGap)):
                            noteNum = lowerKeySound[5] + soundKey
                            nowPlaying = lowerKeyLabelSecond[5]
                        case((lowerMinX + 6 * lowerKeyWidth + 6 * keyGap) ... (lowerMinX + 7 * lowerKeyWidth + 6 * keyGap)):
                            noteNum = lowerKeySound[6] + soundKey
                            nowPlaying = lowerKeyLabelSecond[6]
                        case((lowerMinX + 7 * lowerKeyWidth + 7 * keyGap) ... (lowerMinX + 8 * lowerKeyWidth + 7 * keyGap)):
                            noteNum = lowerKeySound[7] + soundKey
                            nowPlaying = lowerKeyLabelSecond[7]
                        case((lowerMinX + 8 * lowerKeyWidth + 8 * keyGap) ... (lowerMinX + 9 * lowerKeyWidth + 8 * keyGap)):
                            noteNum = lowerKeySound[8] + soundKey
                            nowPlaying = lowerKeyLabelSecond[8]
                        case((lowerMinX + 9 * lowerKeyWidth + 9 * keyGap) ... (lowerMinX + 10 * lowerKeyWidth + 9 * keyGap)):
                            noteNum = lowerKeySound[9] + soundKey
                            nowPlaying = lowerKeyLabelSecond[9]
                        default:
                            noteNum = 0
                        }
                    }
                }
                sampler.play()
            })
            .onEnded({ _ in
                sampler.stop()
                noteNum = 0
                location = .zero
                nowPlaying = ""
            })
        
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center) {
                nowTimeView(whiteMode: whiteMode)
                
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
                    ForEach(0 ..< 3, id: \.self) { index in
                        KeyView(width: upperKeyWidth, height: upperKeyHeight, firstLabel: upperKeyLabelFirst[index], secondLabel: upperKeyLabelSecond[index], backgroundColor: Color.orange)
                    }
                    
                    ForEach(3 ..< 5, id: \.self) { index in
                        KeyView(width: upperKeyWidth, height: upperKeyHeight, firstLabel: upperKeyLabelFirst[index], secondLabel: upperKeyLabelSecond[index], backgroundColor: Color.yellow)
                    }
                    
                    ForEach(5 ..< upperKeyLabelFirst.count, id: \.self) { index in
                        KeyView(width: upperKeyWidth, height: upperKeyHeight, firstLabel: upperKeyLabelFirst[index], secondLabel: upperKeyLabelSecond[index], backgroundColor: Color.orange)
                    }
                }
                
                HStack(alignment: .top, spacing: 3) {
                    ForEach(0 ..< lowerKeyLabelFirst.count, id: \.self) { index in
                        KeyView(width: lowerKeyWidth, height: lowerKeyHeight, firstLabel: lowerKeyLabelFirst[index], secondLabel: lowerKeyLabelSecond[index], backgroundColor: Color.yellow)
                    }
                }
            }
            .gesture(drag)
            .frame(maxWidth: (lowerMinX + 10 * lowerKeyWidth + 9 * keyGap), maxHeight: (lowerMinY + lowerKeyHeight))
            .background(whiteMode ? Color.white : Color.black)
            
            HStack {
                if (nowPlaying != "") {
                    Text("\(nowPlaying)")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(whiteMode ? .black : .white)
                        .padding(.leading, 10)
                }
                
                Toggle("", isOn: $whiteMode)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: (lowerMinX + 10 * lowerKeyWidth + 9 * keyGap))
        }
    }
}


struct ContentView: View {
    var body: some View {
        ConductorView()
    }
}


// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
