//
//  Colors.swift
//  AnimatedCustomTabBar
//
//  Created by Yaroslav Sokolov on 09/07/2023.
//

import Foundation
import SwiftUI


struct PencilColors {
    
    var color: Color
    var id: UUID
}
//
//let colors: [Color] = [Color("PastelGreen"),
//                       Color("PastelGreen2"),
//                       Color("PastelBlue"),
//                       Color("PastelOrange"),
//                       Color("PastelYellow"),
//                       Color("GrayLight")]

let colors: [PencilColors] = [PencilColors(color: Color("PastelGreen"), id: .init()),
                              PencilColors(color: Color("PastelGreen2"), id: .init()),
                              PencilColors(color: Color("PastelBlue"), id: .init()),
                              PencilColors(color: Color("PastelOrange"), id: .init()),
                              PencilColors(color: Color("PastelYellow"), id: .init()),
                              ]
