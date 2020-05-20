//
//  ContinuousColors.swift
//  Demo
//
//  Created by Joshua Homann on 5/17/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import UIKit

enum ContinuousColors {
  static let colors: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.0950520933, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.4840795483, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9865043188, green: 0.9325711164, blue: 0.1214137983, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.575290636, green: 0, blue: 1, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.0950520933, alpha: 1)]
  static let colorNames = ["Red","Orange","Yellow","Green","Blue","Purple", "Red"]

  static func colorName(for index: Double) -> String {
    let firstIndex = Int(index) % (colorNames.count - 1)
    let lastIndex = (firstIndex + 1) % (colorNames.count - 1)
    switch index.truncatingRemainder(dividingBy: 1) {
    case 0: return colorNames[firstIndex]
    case 0..<0.5: return colorNames[firstIndex] + "-" + colorNames[lastIndex]
    default: return colorNames[lastIndex] + "-" + colorNames[firstIndex]
    }
  }

  static func color(for index: Double) -> UIColor {
    let firstIndex = Int(index) % (colors.count - 1)
    let lastIndex = (firstIndex + 1) % (colors.count - 1)
    return index.truncatingRemainder(dividingBy: 1) == 0
      ? colors[firstIndex]
      : colors[firstIndex]
        .mix(
          with: colors[lastIndex],
          proportion: CGFloat(index.truncatingRemainder(dividingBy: 1))
        )
  }
}

private extension UIColor {
  func rgba() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var r = CGFloat(0)
    var g = CGFloat(0)
    var b = CGFloat(0)
    var a = CGFloat(0)
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
  func mix(with color: UIColor, proportion: CGFloat) -> UIColor {
    let lhs = rgba()
    let rhs = color.rgba()
    let color = UIColor(
      red: lhs.r.lerp(to: rhs.r, alpha: proportion),
      green: lhs.g.lerp(to: rhs.g, alpha: proportion),
      blue: lhs.b.lerp(to: rhs.b, alpha: proportion),
      alpha: 1)
    return color
  }
}

private extension CGFloat {
  func lerp(to: CGFloat, alpha: CGFloat) -> CGFloat {
    return (1 - alpha) * self + alpha * to
  }
}


