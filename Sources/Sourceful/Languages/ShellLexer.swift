//
//  ShellLexer.swift
//
//
//  Created by Alessio Nossa on 09/05/2020.
//

import Foundation

public class ShellLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        generators.append(regexGenerator("#[\\s\\S]*?$", tokenType: .comment))
        
        let keywords = "break|case|continue|do|done|elif|else|esac|eval|export|fi|for|function|if|in|local|return|set|then|unset|until|while".components(separatedBy: "|")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))
        
        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
