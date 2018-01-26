import Foundation

/**
 * Инктементатор для одного Int числа.
 *
 * Увеличивает число на единицу в интервале от 0 до устанавливаемого максимума.
 * Максимум по умолчанию равен `Int.max`
 */
public struct Incrementor {
    /**
     * Enum исключений, которые модет выбросить `Incrementor`
     */
    public enum Error: Swift.Error {
        /// Максимальное значение не может быть меньше 0
        case maxIsOutOfAllowedRange
    }
    
    /// Текущее число. В самом начале это ноль.
    public private(set) var value: Int = 0
    private var max: Int = .max
    
    public init() {}
    
    /**
     * Увеличивает текущее число на один.
     *
     * После каждого вызова этого метода getNumber() будет возвращать число
     * на один больше.
     */
    public mutating func increment() {
        value += 1
        if value >= max {
            value = 0
        }
    }
    
    /**
     * Устанавливает максимальное значение текущего числа.
     *
     * Когда при вызове incrementNumber() текущее число достигает
     * этого значения, оно обнуляется
     * По умолчанию максимум -- максимальное значение int.
     * Если при смене максимального значения число резко начинает
     * превышать максимальное значение, то число обнулится.
     * Максимум не может быть меньше нуля.
     */
    public mutating func set(maximum: Int) throws {
        guard maximum >= 0 else {
            throw Error.maxIsOutOfAllowedRange
        }
        max = maximum
        if max <= value {
            value = 0
        }
    }
}

