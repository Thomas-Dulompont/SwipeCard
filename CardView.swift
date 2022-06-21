//
//  CardView.swift
//
// I created a Swipe for my IOS WeHobby application, the code is commented to better modify it.
//
//  Created by ThomasDLMP on 20/06/2022.
//

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    @State var toggleShadowColor: Bool = true
    
    var title: String = "Exemple"
    var tags: [String] = ["EXEMPLE","TAGS"]
    var description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget efficitur dolor, in sodales neque. Integer sit amet consequat turpis. Nunc id nunc at velit."
    
    var body: some View {
        ZStack {
            
            //BackgroundIMG
            Image("Exemple")
                .resizable()
                .clipped()
                .frame(width: 400, height: 700)
            
            //LinearShadow
                .overlay(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.2), color]), startPoint: .top, endPoint: .bottom))
                    .opacity(0.7)
                )
            
            //Title
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                //Tags
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.all, 8.0)
                            .background(Color(.blue))
                            .cornerRadius(8)
                            .opacity(0.80)
                    }
                }
                
                //Description
                Text(description)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                
                //Buttons
                HStack {
                    
                    //Button for next card
                    Button("NEXT CARD") {
                        swipeCard(width: -130)
                    }
                    .font(.title3.bold())
                    .frame(width: 145, height: 50)
                    .background(Color(.red))
                    .cornerRadius(30)
                    .foregroundColor(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 5)
                    
                    Spacer()
                    //Button for LinkView
                    Button("SHOW BUTTON") {
                        // Action on press
                        print("test")
                    }
                    .font(.title3.bold())
                    .frame(width: 145, height: 50)
                    .background(Color(.green))
                    .cornerRadius(30)
                    .foregroundColor(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 5)
                }
            }.padding()
        }
    .offset(x: offset.width * 1)
        .rotationEffect(.degrees(Double(0.0)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        if toggleShadowColor == true {
                            changeColor(width: offset.width)
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        if toggleShadowColor == true {
                            changeColor(width: offset.width)
                        }
                    }
                }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-130):
            print("Next")
            offset = CGSize(width: -500, height: 0)
        case 130...500:
            print("I Liked")
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = Color(.red).opacity(1)
        case 130...500:
            color = Color(.green).opacity(1)
        default:
            color = .black
        }
    }
    
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
