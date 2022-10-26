//
//  Lists.swift
//  WordScramble
//
//  Created by Apprenant 86 on 25/11/2021.
//

import SwiftUI

struct Lists: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        // if you need both static and dynamic rows:
        List {
            Section("Static section"){
                Text("Static Row 1")
                Text("Static Row 2")
            }
            
            Section("Dynamic section") {
                ForEach(0..<3){
                    Text("Dynamic Row \($0)")
                }
            }
            
            Section("Section 3"){
                Text("Static Row 3")
                Text("Static Row 4")
            }
        }.listStyle(.grouped) //change the style of the list
        
        // check second preview screen
        
        // if only dynamic rows:
        // unlike Form, List doesn't need to use ForEach, it manages that natively:
        List(people, id: \.self ) {
            Text($0)
        }
        
        
        
    }
}
    
    struct Lists_Previews: PreviewProvider {
        static var previews: some View {
            Lists()
        }
    }
