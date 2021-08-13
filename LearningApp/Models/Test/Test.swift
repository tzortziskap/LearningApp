//
//  Test.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

struct Test : Decodable, Identifiable {
    
    var id : Int
    var image : String
    var time : String
    var description : String
    var questions : [Question]
    
}
