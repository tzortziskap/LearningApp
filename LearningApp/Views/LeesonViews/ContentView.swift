//
//  ContentView.swift
//  LearningApp
//
//  Created by Tzortzis Kapellas on 14/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modal : ContentModal
    
    var body: some View {
        ScrollView{
            LazyVStack{
                if modal.currentModule != nil {
                    ForEach(0..<modal.currentModule!.content.lessons.count){ index in
                        
                        ContentViewRow(index: index)
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(modal.currentModule?.category ?? "")")
        }
    }
}
