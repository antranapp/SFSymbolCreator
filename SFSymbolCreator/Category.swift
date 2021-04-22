//
//  Category.swift
//  SFSymbolCreator
//
//  Created by Richard Witherspoon on 4/21/21.
//

import Foundation

enum Category: String, CaseIterable {
    case all
    case whatsNew
    case multiColor
    case communication
    case weather
    case objectsAndTools
    case devices
    case gaming
    case connectivity
    case transportation
    case human
    case nature
    case editing
    case textFormatting
    case media
    case keyboard
    case commerce
    case time
    case health
    case shapes
    case arrows
    case indices
    case math
    
    var symbols: [String]{
        switch self {
        case .all:
            return availability13Plus + availability14Plus
        case .whatsNew:
            return whatsNewArray
        case .multiColor:
            return multicolorArray
        case .communication:
            return communicationArray
        case .weather:
            return weatherArray
        case .objectsAndTools:
            return objectsAndToolsArray
        case .devices:
            return devicesArray
        case .gaming:
            return gamingArray
        case .connectivity:
            return connectivityArray
        case .transportation:
            return transportationArray
        case .human:
            return humanArray
        case .nature:
            return natureArray
        case .editing:
            return editingArray
        case .textFormatting:
            return textFormattingArray
        case .media:
            return mediaArray
        case .keyboard:
            return keyboardArray
        case .commerce:
            return commerceArray
        case .time:
            return timeArray
        case .health:
            return healthArray
        case .shapes:
            return shapesArray
        case .arrows:
            return arrowsArray
        case .indices:
            return indicesArray
        case .math:
            return mathArray
        }
    }
}
