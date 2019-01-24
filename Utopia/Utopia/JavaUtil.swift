
import Foundation

open class JavaUtil {

    open static func toJavaInteger(_ int: Int) -> JavaLangInteger {
        return JavaLangInteger(value: Int32(int))
    }

    open static func toJavaIntegerPrimitive(_ int: Int) -> jint {
        return Int32(int)
    }

    open static func toSwiftBool(_ bool: JavaLangBoolean) -> Bool {
        return bool.booleanValue()
    }

    open static func toJavaBoolean(_ bool: Bool) -> JavaLangBoolean {
        return JavaLangBoolean(boolean: bool)
    }

    open static func toSwiftInt(_ integer: JavaLangInteger) -> Int {
        return Int(integer.intValue())
    }
}
