{
  en: {
    time: {
      formats: {
        default: ->(time, _ = nil) { "%A, %B #{time.day.ordinalize} at %-I:%M%p" }
      }
    }
  }
}
