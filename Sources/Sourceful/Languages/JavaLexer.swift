//
//  JavaLexer.swift
//
//  Based on SwiftLexer.swift by Louis D'hauwe.
//  Created by Skrypchenko Nikita on 26.07.2020.
//

import Foundation

public class JavaLexer: SourceCodeRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "abstract assert boolean break byte case catch char class const continue do double else enum extends final finally float for goto if int interface long native new package private protected public return short static strictfp super switch synchronized this throw throws transient try void volatile while true false null implements import instanceof".components(separatedBy: " ")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        // Line comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Multi-line string literal
        generators.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
}
