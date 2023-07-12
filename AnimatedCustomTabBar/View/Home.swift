//
//  Home.swift
//  AnimatedCustomTabBar
//
//  Created by Yaroslav Sokolov on 06/07/2023.
//

import SwiftUI

struct Home: View {
    
    @State var circleSize: CGSize = .zero

    @State var isImageActiaveTool : Bool = false
    @State var size: CGSize = .zero
    @State var sizeColor: CGSize = .zero
    @State var lineWidth: Int = 1
    @State var chossedColor: Color = Color("PastelBlue")
    @State var wantChangColor: Bool = false
    @State var fakedColors: [PencilColors] = []
    @State var currentColor = " "
    @State var offsetOfCircle: CGFloat = 61.0
    @State var colorsPassed: Int = 1
    @State var nextValue = 1
    @State var deleteValue = 1

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
        
        GeometryReader { geo in
            ZStack {
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
                            .saveSize($circleSize)

                            ///Calculating Entire colors offset
                            
                        }

                    }

                    .offsetX() { rect in
                        let minX = rect.minX
                        let colorSize = circleSize.width
                        let FourHalfColorSize = colorSize / 4
                        let ThreeHalfeColorSize = FourHalfColorSize - 4.2
                        let sizeToDelete = ThreeHalfeColorSize * CGFloat(deleteValue)

                        
                        print("minX - \(minX)")
                        let sizeToPass = FourHalfColorSize * CGFloat(nextValue)
                        print(" size to pass \(sizeToPass)")
                        
                        if -minX > sizeToPass {
                            if sizeToPass == -0.0 || colorsPassed == 7 {
                                colorsPassed = 1
                            } else {
                                colorsPassed += 1
                            }
                            nextValue += 1
                            deleteValue += 1
                            DispatchQueue.main.async {
                                colors.append(colors[colorsPassed - 1])
                            }
                            
                        }
                        
                        
                        else if -minX < sizeToDelete && sizeToDelete != -0.0 && sizeToDelete != -0.0 && minX != 0.0 && deleteValue != 1 {
                            nextValue -= 1
                            deleteValue -= 1
                            DispatchQueue.main.async {
                                colors.removeLast()
                            }
                            
                            print("need to delete last item from array")


                        }
                        print("now in scroll view \(colors.count) colors")
                        print("size to delete \(sizeToDelete)")
                        print("color passed - \(colorsPassed)")

//                        print(colorsPassed)
                    }
                    .offset(x: geo.size.width / 14)
                    .zIndex(0)
                    
                }
                .zIndex(0)
                .padding(.bottom, 30)
                .offset(y: wantChangColor ? -size.height : -30)
                .opacity(wantChangColor ? 1.0 : 0)
                HStack {
                    Button {
                        
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
                        }
                    } label: {
                        Capsule()
                            .fill(chossedColor)
                            .frame(width: 60, height: 60)
                    }
                }
                .zIndex(2)
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
                .zIndex(1)
                .coordinateSpace(name: "ToolBarItems")
                .offset(x: isImageActiaveTool ? -(size.width / 2) : 0)
                .padding(3)
                .background {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.black.opacity(0.2))
                        .frame(width: isImageActiaveTool ? size.width * 2 + 5 : nil)
                        .offset(x: isImageActiaveTool ? 1 : 0)
                }
                .overlay {
                    
                    Text(String(describing: sizeColor))
                        .offset(y: 120)
                }
                .saveSize($sizeColor)
            }
            .onAppear {
                fakedColors.append(contentsOf: colors)
                
                if var firstColor = colors.first, var lastColor = colors.last {
                    
                    currentColor = firstColor.id.uuidString
                    
                    firstColor.id = .init()
                    lastColor.id = .init()
                    
                    
                    fakedColors.append(firstColor)
                    fakedColors.insert(lastColor, at: 0)
                }
            }
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




//struct SizeCalculator: ViewModifier {
//    @Binding var size: CGSize
//    func body(content: Content) -> some View {
//        content
//            .background(
//                GeometryReader { proxy in
//                    Color.clear
//                        .onAppear {
//                            size = proxy.size
//                        }
//                }
//            )
//    }
//}
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
