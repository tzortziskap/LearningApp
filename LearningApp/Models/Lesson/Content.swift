//
//  Content.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import Foundation

struct Content : Decodable, Identifiable{
    
    var id : Int
    var image : String
    var time : String
    var description : String
    var lessons : [Lesson]
}
