//
//  Strings.swift
//  WordScramble
//
//  Created by Apprenant 86 on 26/11/2021.
//

import SwiftUI

struct Strings: View {
    var body: some View {
        Button("stringTools func"){
            stringTools()
        }
        .buttonStyle(.borderedProminent)
    }
    
    func stringTools() {
        let input = "a b c"
        print(input
        )
        let components = input.components(separatedBy: " ")
        // will create an array of strings: ["a", "b", "c"]
        print(components)
        
        let input2 = """
                    a
                    b
                    c
                    """
        let components2 = input2.components(separatedBy: "\n")
        // will create an array of strings: ["a", "b", "c"]
        print(components2)
        
        let letter = components.randomElement()
        // returns a random element of a Collection, optional
        print(letter ?? "nil")
        
        let letters = input.trimmingCharacters(in: .whitespacesAndNewlines)
        // trim both ends of a String from the specified CharacterSet
        // in this case, input is returned
        print(letters)
        
        let letters2 = letter?.trimmingCharacters(in: .decimalDigits)
        print(letters2 ?? "nil")
        
        
        // TextChecker for misspelled word in text processing using UIKit bridge:
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
        print(allGood)
        
    }
}

struct Strings_Previews: PreviewProvider {
    static var previews: some View {
        Strings()
    }
}
