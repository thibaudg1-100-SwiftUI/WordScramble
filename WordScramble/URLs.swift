//
//  URLs.swift
//  WordScramble
//
//  Created by Apprenant 86 on 25/11/2021.
//

import SwiftUI

struct URLs: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "fileName", withExtension: "txt"){
            // iOS found the file in the Bundle
            
            // 'try?' keyword allows us to treat a throwing function as a function returning nil instead of throwing an error
            // this is useful when we don't care what precise error was thrown, but only if it did or didn't work
            if let fileContents = try? String(contentsOf: fileURL){
                // iOS did load correctly the fileURL contents
                print(fileContents)
            }
        }
    }
}

struct URLs_Previews: PreviewProvider {
    static var previews: some View {
        URLs()
    }
}
