//
//  ContentModel.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

class ContentModal: ObservableObject{
    
    @Published var modules = [Module]()
    
    @Published var currentModule : Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson : Lesson?
    var currentLessonIndex = 0
    
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    init() {
        self.modules = getLocalData()
        self.styleData = getStyleData()
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
        currentLesson = currentModule!.content.lessons[currentModuleIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson(){
        
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }else{
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
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
