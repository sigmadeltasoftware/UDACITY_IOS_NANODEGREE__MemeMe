//
//  TextOverlay.swift
//  MemeMe
//
//  Created by Bojan Belic on 24/11/2020.
//

import SwiftUI

struct TextOverlay: View {
    
    var text: Binding<String>
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField("", text: text)
                .font(.custom("HelveticaNeue-CondensedBlack", size: 30.0))
                .autocapitalization(.allCharacters)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10)
                .multilineTextAlignment(.center)
        }.padding(.all, 8)
    }
}

// SwiftUI doesn't support text strokes by default, therefor this class could help approximate effect
// In testing though, it was revealed that the effect looked bad when resizing for landscape, so I opted
// for a shadow as an easy solution. In a production app, I would look into implementing a third-party library that
// offers these functionalities such as SwiftFX
struct StrokeText: View {
    
    let text: Binding<String>
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text.wrappedValue).offset(x:  width, y:  width)
                Text(text.wrappedValue).offset(x: -width, y: -width)
                Text(text.wrappedValue).offset(x: -width, y:  width)
                Text(text.wrappedValue).offset(x:  width, y: -width)
            }.foregroundColor(color)
            
            TextField("", text: text)
                
        }
    }
}
