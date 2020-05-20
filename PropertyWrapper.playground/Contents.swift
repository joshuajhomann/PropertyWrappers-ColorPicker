import Foundation

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

struct ThingWithAPropertyWrapper {
  @Rounded var roundNumber: Double = 3.2
  var other: Rounded<Double>
  init() {
    other = _roundNumber
  }

  mutating func doStuff() {
    print(roundNumber)
    print($roundNumber)
    other.wrappedValue += 0.5
    print(other.wrappedValue)
    other.projectedValue += 3.2
    print(other.projectedValue)
  }
}

var thingWithAPropertyWrapper = ThingWithAPropertyWrapper()
thingWithAPropertyWrapper.doStuff()
