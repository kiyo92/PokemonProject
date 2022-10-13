//
//  UIColor+Extension.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 10/10/22.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(hex: String) {

        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            .replacingOccurrences(of: "#", with: "")

        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64

        switch hexString.count {

        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    func getColorBytype(pokemonType: String) -> UIColor {

        switch pokemonType {

        case "normal":
            return UIColor(hex: "#A8A877")
        case "fire":
            return UIColor(hex: "#EF8030")
        case "fighting":
            return UIColor(hex: "#C03028")
        case "water":
            return UIColor(hex: "#6790F0")
        case "flying":
            return UIColor(hex: "#A890F0")
        case "grass":
            return UIColor(hex: "#78C84F")
        case "poison":
            return UIColor(hex: "#9F409F")
        case "electric":
            return UIColor(hex: "#F8CF30")
        case "ground":
            return UIColor(hex: "#E0C068")
        case "psychic":
            return UIColor(hex: "#F85787")
        case "rock":
            return UIColor(hex: "#B8A038")
        case "ice":
            return UIColor(hex: "#98D8D8")
        case "bug":
            return UIColor(hex: "#A8B720")
        case "dragon":
            return UIColor(hex: "#7038F8")
        case "ghost":
            return UIColor(hex: "#68A090")
        case "dark":
            return UIColor(hex: "#705848")
        case "steel":
            return UIColor(hex: "#B8B8D0")
        case "fairy":
            return UIColor(hex: "#EE99AC")
        default:
            return UIColor(hex: "#68A090")
        }
    }

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
            return self.adjust(by: abs(percentage) )
        }

        func darker(by percentage: CGFloat = 30.0) -> UIColor? {
            return self.adjust(by: -1 * abs(percentage) )
        }

        func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return UIColor(red: min(red + percentage/100, 1.0),
                               green: min(green + percentage/100, 1.0),
                               blue: min(blue + percentage/100, 1.0),
                               alpha: alpha)
            } else {
                return nil
            }
        }
}
