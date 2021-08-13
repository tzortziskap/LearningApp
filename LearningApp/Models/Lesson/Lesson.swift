//
//  Lesson.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

struct Lesson : Decodable, Identifiable {
    
    var id : Int
    var title : String
    var video : String
    var duration : String
    var explanation : String
}
