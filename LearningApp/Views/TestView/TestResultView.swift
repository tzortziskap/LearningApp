//
//  TestResultView.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 16/8/21.
//

import SwiftUI



struct TestResultView: View {
    
    @EnvironmentObject var model : ContentModel
    var numCorrect: Int
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if pct > 0.5{
            return "Awesome!"
        }
        else if pct > 0.2{
            return "Doing great!"
        }
        else{
            return "Keep learning!"
        }
    }
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            
            Button {
                model.currentTestSelected = nil
            } label : {
                ZStack{
                    RectAngleCard(color: .green, shadowRadious: 5, width: 335, height: 48)
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
            }
            
            Spacer()
        }
    }
}
