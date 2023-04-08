//
//  KeyView.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/03/15.
//

import SwiftUI

struct KeyView: View {
    let width: CGFloat = 63
    let height: CGFloat = 110
    let model: KeyModel
    let upperLabel: String
    let lowerLabel: String
    @Binding var location: CGPoint

    init(model: KeyModel, location: Binding<CGPoint>, upperLabel: String, lowerLabel: String) {
        self.model = model
        _location = location
        self.upperLabel = upperLabel
        self.lowerLabel = lowerLabel
    }

    var body: some View {
        return GeometryReader { geometry in
            self.makeShape(geometry: geometry)
        }
        .frame(width: width, height: height)
        .overlay(VStack {
            Text("\(upperLabel)")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.bottom, 30)
            Text("\(lowerLabel)")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.black)
        })
    }
    
    private func hit(geometry: GeometryProxy) -> Bool {
        let frame = geometry.frame(in: .global)
        let path = KeyShape()
            .invertPath(in: CGRect(origin: .zero, size: frame.size))
        
        return path.contains(CGPoint(x: location.x - frame.origin.x,
                                     y: location.y - frame.origin.y))
    }

    private func makeShape(geometry: GeometryProxy) -> some View {
        self.model.isHit = hit(geometry: geometry)
        
        return KeyShape()
            .fill(LinearGradient(gradient: Gradient(colors: [.white, model.getColor()]), startPoint: .top, endPoint: .bottom))
    }

    func onEvent(handler: @escaping ((KeyInfo) -> Void)) -> some View {
        return self.onReceive(model.subject, perform: { (keyInfo) in
            handler(keyInfo)
        })
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        let model = KeyModel(color: .yellow, keyNum: 0)
        
        KeyView(model: model, location: .constant(.zero), upperLabel: "ミ", lowerLabel: "水")
    }
}
