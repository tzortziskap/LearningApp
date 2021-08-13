//
//  ContentModel.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

class ContentModel: ObservableObject{
    
    @Published var modules = [Module]()
    
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
}
