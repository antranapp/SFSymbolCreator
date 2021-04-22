//
//  main.swift
//  SFSymbolCreator
//
//  Created by Richard Witherspoon on 4/21/21.
//

import Foundation


func convertToCamelCased(string: String)->String{
    var camelCased = string
        .split(separator: ".")  // split to components
        .map { String($0) }   // convert subsequences to String
        .enumerated()  // get indices
        .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() } // added lowercasing
        .joined() // join to one string
    
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    if numbers.contains(String(camelCased.first!)){
        camelCased = "number\(camelCased)"
    } else if camelCased == "return"{
        camelCased = "returnSymbol"
    } else if camelCased == "repeat"{
        camelCased = "repeatSymbol"
    } else if camelCased == "case"{
        camelCased = "caseSymbol"
    }
    
    return camelCased
}

func convertToStaticVar(string: String, iOSAvailability: Double?, macOSAvailability: Double?, tvOSAvailability: Double?, watchOSAvailability: Double?)->String{
    
    
    var categories = "[.all"
    
    for category in Category.allCases.filter({$0 != .all}){
        if category.symbols.contains(string){
            categories.append(", .\(category.rawValue)")
        }
    }
    
    let camelCased = convertToCamelCased(string: string)
    let staticVar = """
        static let \(camelCased) = SFSymbol(title: "\(string)",
                                        categories: \(categories)],
                                        iOSAvailability: \(iOSAvailability?.description ?? "nil"),
                                        macOSAvailability: \(macOSAvailability?.description ?? "nil"),
                                        tvOSAvailability: \(tvOSAvailability?.description ?? "nil"),
                                        watchOSAvailability: \(watchOSAvailability?.description ?? "nil"))
        """
    
    return staticVar
}

func createAllArray(input: [String])->String{
    let allCamelCased = (input).map{
        convertToCamelCased(string: $0)
    }
    
    var arrayString = """
    @available(iOS 14, macOS 14.0, tvOS 14.0, watchOS 7.0,  *)
    public extension SFSymbol{
        static var allSymbols: [SFSymbol]{
            [
               
    """
    
    
    for title in allCamelCased{
        let spacing = "            "
        arrayString.append("\(spacing)SFSymbol.\(title),\n")
    }
        
    arrayString.append("""
                    ]
                }
            }
        """)
    
    return arrayString
}

let paths = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)
let path = paths.first!
let filenameThirteen = path.appendingPathComponent("SFSymbol+iOS13.swift")
let filenameFourteen = path.appendingPathComponent("SFSymbol+iOS14.swift")
let filenameAll = path.appendingPathComponent("SFSymbol+All.swift")
let filenameAll13 = path.appendingPathComponent("SFSymbol+All13.swift")
let filenameAll14 = path.appendingPathComponent("SFSymbol+All14.swift")

let thirteen = availability13Plus.map{
    convertToStaticVar(string: $0, iOSAvailability: 13, macOSAvailability: 13, tvOSAvailability: 13, watchOSAvailability: 6)
}.joined(separator: "\n\n")

let fourteen = availability14Plus.map{
    convertToStaticVar(string: $0, iOSAvailability: 14, macOSAvailability: 14, tvOSAvailability: 14, watchOSAvailability: 7)
}.joined(separator: "\n\n")

try thirteen.write(to: filenameThirteen, atomically: true, encoding: String.Encoding.utf8)
try fourteen.write(to: filenameFourteen, atomically: true, encoding: String.Encoding.utf8)
try createAllArray(input: availability13Plus + availability14Plus).write(to: filenameAll, atomically: true, encoding: String.Encoding.utf8)
try createAllArray(input: availability13Plus).write(to: filenameAll13, atomically: true, encoding: String.Encoding.utf8)
try createAllArray(input: availability14Plus).write(to: filenameAll14, atomically: true, encoding: String.Encoding.utf8)
print("DONE!")
