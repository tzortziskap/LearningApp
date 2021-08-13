//
//  Module.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

struct Module : Decodable,Identifiable {
    
    var id : Int
    var category : String
    var content : Content
    var test : Test
}
