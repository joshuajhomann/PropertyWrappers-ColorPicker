//
//  ContentView.swift
//  Demo
//
//  Created by Joshua Homann on 4/3/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import SwiftUI
import Combine

final class ColorViewModel: ObservableObject {
  @Published private (set) var color: UIColor = .black
  @Published private (set) var colorName: String = ""
  @Published var continuousIndex: Double = 0
  @Rounded private var roundedIndex = 0
  var subscriptions = Set<AnyCancellable>()
  init() {
    $continuousIndex
      .map(ContinuousColors.color(for:))
      .assign(to: \.color, on: self)
      .store(in: &subscriptions)

    $continuousIndex
      .map(ContinuousColors.colorName(for:))
      .assign(to: \.colorName, on: self)
      .store(in: &subscriptions)
  }

  func nextColor() {
    roundedIndex = continuousIndex
    continuousIndex = roundedIndex + 1 > Double(ContinuousColors.colorNames.count - 2)
      ? 0
      : roundedIndex + 1
  }
}

struct GradientSliderView: View {
  @Binding private var index: Double
  init(index: Binding<Double>) {
    _index = index
  }
  var body: some View {
    Slider(value: $index, in: 0...Double(ContinuousColors.colorNames.count - 1))
      .background(LinearGradient(
        gradient: Gradient(colors: ContinuousColors.colors.map(Color.init(_:))),
        startPoint: .leading, endPoint: .trailing
      ))
      .accentColor(Color.white)
      .padding()
  }
}

struct ColorView: View {
  @ObservedObject var model = ColorViewModel()
  var body: some View {
    ZStack {
      Color(model.color).animation(.linear)
      VStack {
        Text(model.colorName).shadow(color: Color.gray, radius: 4)
        GradientSliderView(index: $model.continuousIndex)
        Button("Next") {
          self.model.nextColor()
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
        .shadow(color: Color.gray, radius: 4)
      }
      .font(.largeTitle)
      .foregroundColor(.white)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ColorView()
  }
}
