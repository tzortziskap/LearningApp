//
//  ContentModel.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

class ContentModel: ObservableObject{
    
    @Published var modules = [Module]()
    
    @Published var currentModule : Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson : Lesson?
    var currentLessonIndex = 0
    
    @Published var currentQuestion : Question?
    var currentQuestionIndex = 0
    
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    @Published var currentContentSelected : Int?
    
    @Published var currentTestSelected : Int?
    
    init() {
        self.modules = getLocalData()
        self.styleData = getStyleData()
        getRemoteData()
    }
    
    func getLocalData() -> [Module]{
        
        var modules = [Module]()
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do{
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            do{
                modules = try jsonDecoder.decode([Module].self, from:jsonData)
            }catch{
                print("Could not decode data")
                print(error)
            }
        }catch{
            print("Could not find data")
            print(error)
        }
        return modules
    }
    
    func getRemoteData(){
        
        let urlString = "https://tzortziskap.github.io/LearningApp-Data/data2.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print (error!)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do{
                let modules = try jsonDecoder.decode([Module].self, from: data!)
                DispatchQueue.main.async {
                    self.modules += modules
                }
            }
            catch{
                print("Could not find data")
                print(error)
            }
            
        }
        dataTask.resume()
    }
    
    func getStyleData() -> Data{
        
        var styleData = Data()
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            styleData = try Data(contentsOf: styleUrl!)
        }catch{
            print("Could not find data")
            print(error)
        }
        return styleData
    }
    
    func beginModule(_ moduleId : Int){
        
        for index in 0..<modules.count{
            
            if modules[index].id == moduleId{
                
                currentModuleIndex = index
                break
            }
        }
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonId : Int){
        
        if lessonId < currentModule!.content.lessons.count {
            currentLessonIndex = lessonId
        }else{
            currentLessonIndex = 0
        }
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson(){
        
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            DispatchQueue.main.async {
                self.currentLesson = self.currentModule!.content.lessons[self.currentLessonIndex]
                self.codeText = self.addStyling(self.currentLesson!.explanation)
            }
        }else{
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId : Int){
        
        beginModule(moduleId)
        
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion(){
        
        currentQuestionIndex += 1
        if currentQuestionIndex < currentModule!.test.questions.count {
            DispatchQueue.main.async {
                self.currentQuestion = self.currentModule!.test.questions[self.currentQuestionIndex]
                self.codeText = self.addStyling(self.currentQuestion!.content)
            }
        }else{
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    func hasNextQuestion() -> Bool {
        guard currentModule != nil else{
            return false
        }
        return (currentQuestionIndex + 1 < currentModule!.test.questions.count)
    }
    
    private func addStyling(_ htmlString: String) -> NSAttributedString{
        
        var resultString = NSAttributedString()
        var data = Data()
        
        if styleData != nil {
            data.append(styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
}
