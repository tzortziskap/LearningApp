//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var modal: ContentModel
    var index: Int
    
    var body: some View {
        let lesson = modal.currentModule!.content.lessons[index]
        ZStack(alignment: .leading){
            
            RectAngleCard(color: Color.white, shadowRadious: 5, width: 335, height: 66)
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width:335,height: 66),
                             contentMode: .fit)
            HStack(spacing:30){
                Text("\(index + 1)")
                    .bold()
                VStack(alignment:.leading,spacing: 10){
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding()
        }
        .padding(.bottom,5)
    }
}
