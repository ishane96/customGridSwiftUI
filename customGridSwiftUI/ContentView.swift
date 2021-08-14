//
//  ContentView.swift
//  customGridSwiftUI
//
//  Created by Achintha Kahawalage on 2021-06-16.
//

import SwiftUI

struct ContentView: View{
    
    let cards: [CardDetails] = [
        .init(title: "Test"),
        .init(title: "jsfo"),
        .init(title: "aefk"),
        .init(title: "jsfo"),
        .init(title: "aefk"),
    ]
    
    var card:CardDetails!

    var leftCards: [CardDetails] {
        cards.enumerated()
            .filter{ $0.offset % 2 == 0 }
            .map{ $0.element }
    }
    
    var rightCards: [CardDetails] {
        cards.enumerated()
            .filter{ $0.offset % 2 != 0 }
            .map{ $0.element }
    }
    
    var visibleLeftCards: [CardDetails] {
        if cards.count % 2 != 0 {
            let slice = ArraySlice(leftCards[0..<leftCards.count - 0])
            return Array(slice)
        } else {
            return leftCards
        }
    }
    
    var visibleRightCards: [CardDetails] {
        if cards.count % 2 == 0, let lastLeftCard = leftCards.last{
            return rightCards + [lastLeftCard]
        } else {
            return rightCards
        }
    }
    
    var body: some View{
        ScrollView{
            HStack(spacing:20){
                VStack{
                    ForEach(Array(visibleLeftCards.enumerated()), id: \.element){ index, card in
                        TestCard(card: card)
                            .frame(height: index % 2 == 0 ? 150: 200)
                    }
                    Spacer()
                }
                
                VStack{
                    ForEach(Array(visibleRightCards.enumerated()), id: \.element){ index, card in
                        TestCard(card: card)
                            .frame(height: index % 2 != 0 ? 150: 200)
                    }
                    Spacer()
                }
            }.padding()
        }
    }
}

struct CardDetails: Hashable{
    let title:String
}

struct TestCard: View {
    
    let card: CardDetails
    var body: some View{
        GeometryReader { proxy in
            Text(card.title)
                .foregroundColor(Color.white)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
