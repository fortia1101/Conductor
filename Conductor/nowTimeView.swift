//
//  nowTimeView.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/15.
//

import SwiftUI

struct nowTimeView: View {
    @State var dateText = ""
    @State var nowDate = Date()
    let whiteMode: Bool
    
    private let dateFormatter = DateFormatter()
    
    init(whiteMode: Bool) {
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ja_jp")
        self.whiteMode = whiteMode
    }
    
    var body: some View {
        Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText)
            .font(.system(size: 16))
            .fontWeight(.semibold)
            .foregroundColor(whiteMode ? .black : .white)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    nowDate = Date()
                    dateText = "\(dateFormatter.string(from: nowDate))"
                }
            }
    }
}

struct nowTimeView_Previews: PreviewProvider {
    static var previews: some View {
        nowTimeView(whiteMode: true)
    }
}
