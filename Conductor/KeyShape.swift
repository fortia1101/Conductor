//
//  KeyShape.swift
//  Conductor
//
//  Created by Masahiro Ohara on 2023/04/03.
//

import SwiftUI

struct KeyShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.size.width
        let h = rect.size.height
        let r: CGFloat = 5
        var path = Path()
        
        path.move(to: CGPoint(x: w, y: h - r))
        path.addArc(center: CGPoint(x: w - r, y: h - r),
                    radius: r,
                    startAngle: Angle(radians: 0),
                    endAngle: Angle(radians: .pi / 2),
                    clockwise: false)
        path.addLine(to: CGPoint(x: r, y: h))
        path.addArc(center: CGPoint(x: r, y: h - r),
                    radius: r,
                    startAngle: Angle(radians: .pi / 2),
                    endAngle: Angle(radians: .pi),
                    clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: r))
        path.addArc(center: CGPoint(x: r, y: r),
                    radius: r,
                    startAngle: Angle(radians: .pi),
                    endAngle: Angle(radians: .pi * 3 / 2),
                    clockwise: false)
        path.addLine(to: CGPoint(x: w - r, y: 0))
        path.addArc(center: CGPoint(x: w - r, y: r),
                    radius: r,
                    startAngle: Angle(radians: .pi * 3 / 2),
                    endAngle: Angle(radians: .pi * 2),
                    clockwise: false)
        path.addLine(to: CGPoint(x: w, y: h - r))
        path.closeSubpath()
        
        return path
    }
    
    func invertPath(in rect: CGRect) -> Path {
        return self.path(in: rect)
            .transform(CGAffineTransform(scaleX: 1, y: -1))
            .transform(CGAffineTransform(translationX: 0, y: rect.height))
            .path(in: rect)
    }
}
