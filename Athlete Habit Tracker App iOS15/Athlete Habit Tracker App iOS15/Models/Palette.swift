//
//  Palette.swift
//  Athlete Habit Tracker App iOS15
//
//  Created by Zhang, Xiaodong on 6/13/22.
//

import SwiftUI

enum Palette: String, CaseIterable, Identifiable, ShapeStyle {
    case royalblue
    case bluegrey
    case bluehorizon
    case flirtacious
    case fusionred
    case gloomypurple
    case highblue
    case lighterpurple
    case maximumbluegreen
    case orangehibiscus
    case reptilegreen
    case twinkleblue
    
    var accentColor: Color {
        switch self {
        case .royalblue, .bluegrey, .bluehorizon, .flirtacious, .fusionred, .gloomypurple, .highblue, .lighterpurple, .maximumbluegreen, .orangehibiscus, .reptilegreen, .twinkleblue: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}

extension Color {
    static let royalblue = Color("royalblue")
    static let bluegrey = Color("bluegrey")
    static let bluehorizon = Color("bluehorizon")
    static let flirtacious = Color("flirtacious")
    static let fusionred = Color("fusionred")
    static let gloomypurple = Color("gloomypurple")
    static let highblue = Color("highblue")
    static let lighterpurple = Color("lighterpurple")
    static let maximumbluegreen = Color("maximumbluegreen")
    static let orangehibiscus = Color("orangehibiscus")
    static let reptilegreen = Color("reptilegreen")
    static let twinkleblue = Color("twinkleblue")
}
