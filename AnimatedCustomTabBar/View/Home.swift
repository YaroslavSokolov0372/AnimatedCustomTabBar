//
//  Home.swift
//  AnimatedCustomTabBar
//
//  Created by Yaroslav Sokolov on 06/07/2023.
//

import SwiftUI

struct Home: View {
    
    @State var isImageActiaveTool : Bool = false
    @State var size: CGSize = .zero
    
    var body: some View {
        
        tabBarItems()
        
    }
    
    @ViewBuilder
    func tabBarItems() -> some View {
        
        ZStack {
//            Color.clear
            GeometryReader { geo in
                HStack {
                    Button {
                        
                    } label: {
                        Text("1")
                        
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(.black)
                            }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("1")
                        
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(.black)
                            }
                    }
                }
                .padding(.leading, 5)
                .opacity(isImageActiaveTool ? 1.0 : 0)
                .offset(x: isImageActiaveTool ? size.width / 2 : 0)
                .saveSize($size)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                HStack {
                    
                    
                    Button {
                        withAnimation(.default.speed(2)) {
                            isImageActiaveTool.toggle()
                        }
                        
                    } label: {
                        Image(isImageActiaveTool ? "Camera" : "CameraWhite")
                            .resizable()
                            .foregroundColor(isImageActiaveTool ? .black : .white)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(!isImageActiaveTool ? .black : .black.opacity(0.2))
                            }
                    }
                    Button {
                        withAnimation(.default.speed(2)){
                            if isImageActiaveTool {
                                isImageActiaveTool = true
                            } else {
                                isImageActiaveTool.toggle()
                            }   
                        }
                    } label: {
                        Image(isImageActiaveTool ? "PencilWhite" : "Pencil")
                            .resizable()
                            .foregroundColor(isImageActiaveTool ? .white : .black)
                            .frame(width: 30, height: 30)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(isImageActiaveTool ? .black : .black.opacity(0.2))
                            }
                    }
                }
                .offset(x: isImageActiaveTool ? -(size.width / 2) : 0)
                .padding(3)
                .background {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.black.opacity(0.2))
                        .frame(width: isImageActiaveTool ? size.width * 2 + 5 : nil)
                        .offset(x: isImageActiaveTool ? 1 : 0)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)

            }
            Text(String(describing: size))
                .offset(y: 100)
        }
    }
    
    

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func saveSize(_ size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}




struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}
