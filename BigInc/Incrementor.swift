import Foundation

/**
 * Инктементатор для одного Int числа.
 *
 * Увеличивает число на единицу в интервале от 0 до устанавливаемого максимума.
 * Максимум по умолчанию равен Int.max
 */
struct Incrementor {
    enum Error: Swift.Error {
        case maxIsOutOfAllowedRange
    }
    
    /// Текущее число. В самом начале это ноль.
    private(set) var number: Int = 0
    private var max: Int = .max
    
    /**
     * Увеличивает текущее число на один.
     *
     * После каждого вызова этого метода getNumber() будет возвращать число
     * на один больше.
     */
    mutating func incrementNumber() {
        number += 1
        if number >= max {
            number = 0
        }
    }
    
    /**
     * Устанавливает максимальное значение текущего числа.
     *
     * Когда при вызове incrementNumber() текущее число достигает
     * этого значения, оно обнуляется, т.е. getNumber() начинает
     * снова возвращать ноль, и снова один после следующего
     * вызова incrementNumber() и так далее.
     * По умолчанию максимум -- максимальное значение int.
     * Если при смене максимального значения число резко начинает
     * превышать максимальное значение, то число надо обнулить.
     * Максимум не может быть меньше нуля.
     */
    mutating func set(maximum: Int) throws {
        guard maximum >= 0 else {
            throw Error.maxIsOutOfAllowedRange
        }
        max = maximum
        if max <= number {
            number = 0
        }
    }
}

