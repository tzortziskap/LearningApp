//
//  TestView.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI


struct TestView: View {
    
    @EnvironmentObject var model : ContentModel
    @State var selectedAnswerIndex = -1
    @State var numCorrect = 0
    @State var submittedButton = true
    @State var questionButtons = false
    var submitButtonText : String {
        if questionButtons == true {
            if model.hasNextQuestion(){
                return "Next"
            }
            else{
                return "Finish"
            }
        } else {
            return "Submit"
        }
    }
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack{
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                CodeTextView()
                
                ScrollView{
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button{
                                if selectedAnswerIndex == index{
                                    selectedAnswerIndex = -1
                                    submittedButton = true
                                }else {
                                    submittedButton = false
                                    selectedAnswerIndex = index
                                }
                            } label: {
                                ZStack{
                                    if questionButtons == false {
                                        
                                        RectAngleCard(color: index == selectedAnswerIndex ? .gray : .white, shadowRadious: 5, width: 335, height: 48)
                                        
                                    } else {
                                        if (index == selectedAnswerIndex &&
                                                index == model.currentQuestion!.correctIndex) ||
                                            index == model.currentQuestion!.correctIndex{
                                            RectAngleCard(color: .green, shadowRadious: 5, width: 335, height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex{
                                            RectAngleCard(color: .red, shadowRadious: 5, width: 335, height: 48)
                                        }
                                        else {
                                            RectAngleCard(color: .white, shadowRadious: 5, width: 335, height: 48)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(questionButtons)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                Button{
                    if questionButtons == true {
                        
                        model.nextQuestion()
                        
                        questionButtons = false
                        submittedButton = true
                        selectedAnswerIndex = -1
                        
                    } else {
                        questionButtons = true
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    ZStack{
                        RectAngleCard(color: .green, shadowRadious: 5, width: 335, height: 48)
                        Text(submitButtonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .disabled(submittedButton)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else{
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(ContentModel())
    }
}
