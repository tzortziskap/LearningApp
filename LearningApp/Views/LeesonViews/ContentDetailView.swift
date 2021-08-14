//
//  LessonDetailView.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var modal : ContentModal
    
    var body: some View {
        
        let lesson = modal.currentLesson
        let url = URL(string: Constants.VIDEOHOSTURL + (lesson?.video ?? ""))
        
        VStack{
            if url != nil {
                VideoPlayer(player:AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            CodeTextView()
            
            if modal.hasNextLesson(){
                Button(action: {
                    modal.nextLesson()
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.green)
                            .aspectRatio(CGSize(width: 335, height: 48), contentMode: .fit)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Next Lesson: \(modal.currentModule!.content.lessons[modal.currentLessonIndex + 1].title)")
                            .font(.headline)
                            .bold()
                    }
                    .accentColor(.white)
                })
            }
        }
        .padding()
        .navigationTitle(modal.currentLesson?.title ?? "")
    }
}

