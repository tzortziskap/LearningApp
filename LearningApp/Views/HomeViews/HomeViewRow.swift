//
//  LeesonCard.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image : String
    var title : String
    var description : String
    var count : String
    var time : String
    
    var body: some View {
        ZStack{
            
            RectAngleCard(color: Color.white, shadowRadious: 5, width: 335, height: 175)
            HStack{
                
                Image(image)
                    .resizable()
                    .frame(width:116, height:116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(title)
                    
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    HStack(spacing:10){
                        HStack{
                            Image(systemName: "text.book.closed")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text(count)
                                .font(Font.system(size: 10))
                        }
                        HStack{
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text(time)
                                .font(Font.system(size: 10))
                        }
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct LeesonCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "Some Description", count: "10 Lessons", time: "2 Hours")
    }
}
