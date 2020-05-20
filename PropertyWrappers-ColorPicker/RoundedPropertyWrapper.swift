//
//  RoundedPropertyWrapper.swift
//  Demo
//
//  Created by Joshua Homann on 5/17/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

@propertyWrapper
struct Rounded<Number: BinaryFloatingPoint> {

  private var value: Number = .zero
  private var roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero

  init(wrappedValue: Number) {
    value = wrappedValue
  }

  var wrappedValue: Number {
    get {
      var copy = value
      copy.round(roundingRule)
      return copy
    }
    set { value = newValue }
  }

  var projectedValue: Number {
    get { value }
    set { value = newValue }
  }

}
