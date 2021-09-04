//
//  ContentView.swift
//  FlipCard
//
//  Created by Abdullah Alnutayfi on 04/09/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            FlippedCard(side1: Text("الوجه الأول"), side2: Text("الوجه الثاني"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct FlippedCard: View {
    @State var scale : CGFloat = 1
    @State var scale2 : CGFloat = 1.3
    @State var rotationAmount : Double = 0
    var side1 : Text
    var side2 : Text
    @State var isFlipped = false
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 230, height: 330)
                .foregroundColor(isFlipped ? .yellow.opacity(0.80) : .blue)
                .scaleEffect(isFlipped ? scale2: scale)
                .overlay(
                    VStack{
                        if !isFlipped{
                            side1
                                .font(.title)
                                .foregroundColor(.white)
                                .rotation3DEffect(
                                    Angle.degrees(!isFlipped ? -rotationAmount:0),
                                    axis: (x: 0.0, y: 0.1, z: 0.0)
                                )
                        }
                        if isFlipped{
                            side2
                                .font(.title)
                                .foregroundColor(.white)
                                .rotation3DEffect(
                                    Angle.degrees(isFlipped ? -rotationAmount:0),
                                    axis: (x: 0.0, y: 0.1, z: 0.0)
                                )
                        }
                    }
                )
                .onTapGesture {
                    rotationAmount = rotationAmount + 180
                    withAnimation(.linear(duration: 0.5)){
                        isFlipped.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                            withAnimation(){
                                scale2 = scale
                            }
                        }
                    }
                    scale2 = 1.3
                    rotationAmount = 0
                    
                }
                .rotation3DEffect(
                    Angle.degrees(isFlipped ? rotationAmount: 0),
                    axis: (x: 0.0, y: 0.1, z: 0.0)
                )
        }
    }
}
