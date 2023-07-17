//
//  Home.swift
//  AnimatedCustomTabBar
//
//  Created by Yaroslav Sokolov on 06/07/2023.
//

import SwiftUI

struct Home: View {
    
    @State var circleSize: CGSize = .zero
    @State var isUserWantToDraw : Bool = false
    @State var size: CGSize = .zero
    @State var sizeColor: CGSize = .zero
    @State var lineWidth: Int = 1
    @State var chossedColor: Color = Color("PastelBlue")
    @State var wantChangColor: Bool = false
    @State var wantChangeLineWidth = false
    @State var colors: [PencilColors] = [PencilColors(color: Color("PastelGreen"), id: .init()),
                                         PencilColors(color: Color("PastelGreen2"), id: .init()),
                                         PencilColors(color: Color("PastelBlue"), id: .init()),
                                         PencilColors(color: Color("PastelOrange"), id: .init()),
                                         PencilColors(color: Color("PastelYellow"), id: .init()),
                                         PencilColors(color: Color("GrayLight") , id: .init()),
                                         PencilColors(color: Color("LightGray"), id: .init())
    ]
    
    var body: some View {
        
        tabBarItems()
        
    }
    
    
    
    @ViewBuilder
    func tabBarItems() -> some View {
        

            ZStack {
                
                /// Scroll View for changing Color
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        ForEach(colors, id: \.id) { color in
                            Button {
                                withAnimation {
                                    chossedColor = color.color
                                    wantChangColor.toggle()
                                }
                                
                            } label: {
                                Capsule()
                                    .fill(color.color)
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                    .zIndex(0)
                    
                }
                .zIndex(0)
                .padding(.bottom, 30)
                .offset(y: wantChangColor ? -size.height : -30)
                .opacity(wantChangColor ? 1.0 : 0)
                
                /// Scroll View for changing LineWidth
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1...99, id: \.self) { num in
                            
                                
                                
                                
                                Button {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                        lineWidth = num
                                        wantChangeLineWidth.toggle()
                                    }
                                    
                                } label: {
                                    Text(String(num))
                                        .foregroundColor(.white)
                                }
                                
                                
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 35)
                                        .fill(.black)
                                )
                        }
                    }
                }
                .zIndex(0)
                .padding(.bottom, 30)
                .offset(y: wantChangeLineWidth ? -size.height : -30)
                .opacity(wantChangeLineWidth ? 1.0 : 0)
                
                /// Buttons for changing parameters for drawing
                HStack {
                    Button {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            wantChangeLineWidth.toggle()
                            
                            if wantChangColor == true {
                                wantChangColor.toggle()
                            }
                        }
                    } label: {
                        Text(String(lineWidth))
                        
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(.black)
                            }
                    }
                    
                    Button {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            wantChangColor.toggle()
                            
                            if wantChangeLineWidth == true {
                                wantChangeLineWidth.toggle()
                            }
                        }
                    } label: {
                        Capsule()
                            .fill(chossedColor)
                            .frame(width: 60, height: 60)
                    }
                }
                .zIndex(2)
                .padding(.leading, 5)
                .opacity(isUserWantToDraw == true ? 1.0 : 0)
                .offset(x: isUserWantToDraw == true ? size.width / 4 : 0)
                .saveSize($size)
//                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                
                
                /// Pencil button to get access to parametrs of pencil
                HStack {
                    
                    
//                    Button {
//                        withAnimation(.default.speed(2)) {
//                            if isImageActiaveTool != .camera {
//                                isImageActiaveTool = .camera
//                                wantChangColor = false
//                                wantChangeLineWidth = false
//                            } else {
//                                isImageActiaveTool = .nothing
//                                wantChangColor = false
//                                wantChangeLineWidth = false
//                            }
//                        }
//
//
//
//                    } label: {
//                        Image(isImageActiaveTool == .camera ? "NewCameraWhite" : "NewCamera" )
//                            .resizable()
//                            .foregroundColor(isImageActiaveTool == .camera ? .black : .white)
//                            .frame(width: 35, height: 35)
//                            .padding(13)
//                            .background {
//                                RoundedRectangle(cornerRadius: 35)
//                                    .fill(isImageActiaveTool == .camera ? .black : .black.opacity(0.2))
//                            }
//                    }
                    
                    Button {
                        withAnimation(.default.speed(2)){
                            if isUserWantToDraw != true {
                                isUserWantToDraw = true
                            } else {
                                isUserWantToDraw = false
                                wantChangColor = false
                                wantChangeLineWidth = false
                            }
                        }
                    } label: {
                        Image(isUserWantToDraw == true ? "PencilWhite" : "Pencil")
                            .resizable()
                            .foregroundColor(isUserWantToDraw == true ? .white : .black)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(isUserWantToDraw == true ? .black : .black.opacity(0.2))
                            }
                    }
                }
                .zIndex(1)
                .coordinateSpace(name: "ToolBarItems")
                .offset(x: isUserWantToDraw == true ? -(size.width / 2) : 0)
                .padding(3)
                .background {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.black.opacity(0.2))
                        .frame(width: isUserWantToDraw == true ? size.width * 1.5 + 5 : nil)
                        .offset(x: isUserWantToDraw == true ? 1 : 0)
                }
                
                /// Helpers to get size of button
                .overlay {
                    
                    Text(String(describing: sizeColor))
                        .offset(y: 120)
                }
                .saveSize($sizeColor)
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

