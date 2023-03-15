//
//  KeyView.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/15.
//

import SwiftUI

struct KeyView: View {
    let width: CGFloat  // CGFloat: 座標やサイズを表す専用の実数型
    let height: CGFloat
    let firstLabel: String
    let secondLabel: String
    let backgroundColor: Color

    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [.white, self.backgroundColor]), startPoint: .top, endPoint: .bottom)
        
        Rectangle()
            .fill(gradient)
            .frame(width: width, height: height)
            .border(backgroundColor, width: 2)
            .cornerRadius(5)
            .overlay(VStack {
                Text("\(firstLabel)")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                Text("\(secondLabel)")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            })
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView(width: 63, height: 110, firstLabel: "ミ", secondLabel: "水", backgroundColor: Color.yellow)
    }
}
