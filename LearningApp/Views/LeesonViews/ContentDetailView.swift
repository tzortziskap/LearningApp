//
//  LessonDetailView.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model : ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.VIDEOHOSTURL + (lesson?.video ?? ""))
        
        VStack{
            if url != nil {
                VideoPlayer(player:AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            CodeTextView()
            
            if model.hasNextLesson(){
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack{
                        
                        RectAngleCard(color: Color.green, shadowRadious: 5, width: 335, height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .font(.headline)
                            .bold()
                    }
                    .accentColor(.white)
                })
            }else{
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack{
                        
                        RectAngleCard(color: Color.green, shadowRadious: 5, width: 335, height: 48)
                        
                        Text("Complete")
                            .font(.headline)
                            .bold()
                    }
                    .accentColor(.white)
                })
                
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

