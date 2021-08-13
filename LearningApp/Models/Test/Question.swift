//
//  Question.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

struct Question : Decodable, Identifiable {
    
    var id : Int
    var content : String
    var correctIndex : Int
    var answers : [String]
}
