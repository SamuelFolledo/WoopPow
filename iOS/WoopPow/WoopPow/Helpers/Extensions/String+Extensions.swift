//
//  String+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

extension String {
    
    enum ValidityType {
        case email
        case password
//        case phone
    }
    
    enum Regex: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,25}"
//        case phone = "^[0-9+]{0,1}+[0-9]{5,16}$"
    }
    
    public var validPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
//        if let match = detector.matchesInString(self, options: [], range: NSMakeRange(0, characters.count)).first?.phoneNumber {
            return match == self
        }else{
            return false
        }
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
//        case .phone:
//            regex = Regex.phone.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}

extension String {
    ///update phone to a prettier format
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

extension String {
    ///used for UITextFields to add format to phoneNumbers
    public var addPhoneNumberFormatOnField: String { //from +19097773333 to (909) 777-3333
        if self.count >= 12 {
            let phoneNumber = String(self.suffix(10)) //get the last 10 characters
            return phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacmentCharacter: "#")
        } else { //if phoneNumber is not enough
            let phoneNumber = self.filter("0123456789".contains)
            return phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacmentCharacter: "#")
        }
    }
    ///used for UILabels to add format to phoneNumber
    public var addPhoneNumberFormatOnLabel: String { //from +19097773333 to +1 (909) 777-3333
        if self.count >= 12 && self.first == "+" {
            let countryCode = self.prefix(self.count - 10)
            let phoneNumber = String(self.suffix(10)).applyPatternOnNumbers(pattern: "(###) ###-####", replacmentCharacter: "#") //get the last 10 characters and format
            return "\(countryCode) \(phoneNumber)"
        } else { //if phoneNumber is not enough
            let phoneNumber = self.filter("0123456789".contains)
            return phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacmentCharacter: "#")
        }
    }
    
    public var removePhoneNumberFormat: String { //from +1 (444) 222-3333 to +14442223333
        let unformattedPhoneNumber = self.filter("+0123456789".contains) //allow numbers and + only
        return unformattedPhoneNumber
    }
}

extension String {
    var trimWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    ///removes string's left and right white spaces and new lines
    var trimWhiteSpacesAndLines: String {
       return self.trimmingCharacters(in: .whitespacesAndNewlines)
       
    }
}

extension String {
    
    var currency: String {
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")
        print("no symbol: \(stringWithoutSymbol), no comma: \(stringWithoutComma)")
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 2
        styler.decimalSeparator = "."
        styler.currencySymbol = "$"
        styler.numberStyle = .decimal
        
        if let result = NumberFormatter().number(from: stringWithoutComma) {
            print("Result: \(result)")
            return styler.string(from: result)!
        }

        return self
    }
    
    func chunkFormatted(withChunkSize chunkSize: Int = 4,
        withSeparator separator: Character = "-") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
}


extension Array where Element == String {
    
    var numberedList: String {
        guard type(of: self) == [String].self else {
            fatalError("The array's element must be a String type '[String]()'")
        }
        
        var output = ""
        
        for (index, element) in self.enumerated() {
            output.append("\(index + 1). \(element)  ")
        }

        return output
    }
}

extension Collection {
    
    public func chunk(n: Int) -> [SubSequence] {
        // Credit: https://stackoverflow.com/questions/40946134/adding-space-between-textfield-character-when-typing-in-text-filed
        
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

func customStringFormatting(of str: String) -> String {
    // Credit: https://stackoverflow.com/questions/40946134/adding-space-between-textfield-character-when-typing-in-text-filed
    return str.chunk(n: 4)
        .map{ String($0) }.joined(separator: "-")
}

extension String {
    
    func quarterOfTheYearToInteger() -> Int? {
        let components = self.components(separatedBy: " ")
        guard let year = components.last,
              let integer = Int(year) else {
            return 0
        }
        
        return integer
    }
}

//MARK: Character extension For Emoji

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

//MARK: String extension For Emoji
extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    var emojis: [Character] { filter { $0.isEmoji } }
    
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
