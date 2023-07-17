//
//  SizeReader.swift
//  AnimatedCustomTabBar
//
//  Created by Yaroslav Sokolov on 16/07/2023.
//

import Foundation
import SwiftUI


extension View {
    func saveSize(_ size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

struct SizeCalculator: ViewModifier {
    
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            }
    }
}
