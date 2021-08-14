//
//  RectAngleCard.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI



struct RectAngleCard: View {
    
    var color = Color.white
    var shadowRadious : CGFloat = 0
    var width = 1
    var height = 1
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: shadowRadious)
            .aspectRatio(CGSize(width:width,height: height),
                         contentMode: .fit)
    }
}
