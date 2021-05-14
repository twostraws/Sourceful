//
//  OCamlLexer.swift
//  Sourceful
//
//  Created by Nathan Fallet on 05/01/2021.
//

import Foundation

public class OCamlLexer: SourceCodeRegexLexer {
    
    public init() {}
    
    lazy var generators: [TokenGenerator] = {
        var generators = [TokenGenerator?]()
        
        let keywords = "and as assert asr begin class constraint do done downto else end exception external for fun function functor if in include inherit! inherit initializer land lazy let lor lsl lsr lxor match method! method mod module mutable new object of open! open or private rec sig struct then to try type val! val virtual when while with parser value".components(separatedBy: " ")
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        // Modules and variants
        generators.append(regexGenerator("\\b[A-Z$_][0-9a-zA-Z$_]*\\b", tokenType: .identifier))
        
        // Numbers
        // https://github.com/highlightjs/highlight.js/blob/master/src/languages/reasonml.js#L43
        generators.append(regexGenerator("\\b(0[xX][a-fA-F0-9_]+[Lln]?|0[oO][0-7_]+[Lln]?|0[bB][01_]+[Lln]?|[0-9][0-9_]*([Lln]|(\\.[0-9_]*)?([eE][-+]?[0-9_]+)?)?)", tokenType: .number))
        
        // Booleans
        let booleans = "true false".components(separatedBy: " ")
        generators.append(keywordGenerator(booleans, tokenType: .keyword))
        
        // Block comment
        generators.append(regexGenerator("(\\(\\*)(.*?)(\\*\\))", options: [.dotMatchesLineSeparators], tokenType: .comment))
        
        // Single-line string literal
        generators.append(regexGenerator("\"(\\\\\"|[^\"\\n])*\"", tokenType: .string))
        
        return generators.compactMap { $0 }
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
