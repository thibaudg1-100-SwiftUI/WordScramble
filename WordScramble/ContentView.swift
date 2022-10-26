//
//  ContentView.swift
//  WordScramble
//
//  Created by Apprenant 86 on 25/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your text", text: $newWord)
                        .disableAutocorrection(true)
                        // .autocapitalization(.none) // soon deprecated
                        .textInputAutocapitalization(.never)
                }
                
                Section("your score: \(userScore)"){
                    ForEach(usedWords, id: \.self){ word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        // for project 15 : accessibility
                        .accessibilityElement(children: .ignore)
                        //.accessibilityLabel("\(word), \(word.count) letters")
                        // alternatively:
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord) // when TextField content is submitted
            .onAppear(perform: startGame)
            .toolbar{
                Button(action: startGame){
                   Image(systemName: "arrow.triangle.2.circlepath")
                }
            }
            .alert(errorTitle, isPresented: $showingError){
                Button("OK", role: .cancel){}
            } message: {
                Text(errorMessage)
            }
            
        }
    }
    
    func addWord() {
        // lowercase and trim the word out of white spaces and newlines
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // reinitialize the textfield
        newWord = ""
        
        // make sure the answer is not the 'rootWord' itself
        guard answer != rootWord else {
            wordError(title: "Same word", message: "You cannot use the root word itself")
            return
        }
        
        // make sure that the word is at least 3 characters long (better to use isEmpty if just checking for non-empty words)
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "Find a word of 3 or more letters")
            return
        }
        
        // check conditions on 'answer':
        guard isOriginal(word: answer) else {
            wordError(title: "Duplicate", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from'\(rootWord)'")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Does not exist!", message: "You can't make up words, sorry!")
            return
        }
        
        // insert the answer at position 0 so that it's displayed at the top of the stack
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        userScore += answer.count
        
        
    }
    
    func startGame() {
        // reinitialize 'usedWords' for when restarting the game:
        usedWords = [String]()
        userScore = 0
        
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        // check if 'usedWords' already contains 'word'
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        // check if you can form 'word' from letters in 'rootWord'
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else { return false}
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        // check if 'word' actually belongs to the specified language
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
