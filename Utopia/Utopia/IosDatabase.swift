
import Foundation

open class IosDatabase : NSObject, ComSoftwareverdeUtopiaDatabaseDatabase {
    fileprivate static let _SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    fileprivate static let _SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    fileprivate typealias SqliteDatabase = OpaquePointer
    fileprivate typealias SqlQuery = OpaquePointer

    fileprivate var _database : SqliteDatabase!
    fileprivate var _databaseExisted : Bool!
    fileprivate var _databaseName : String!
    fileprivate var _requiredVersion : Int!
    fileprivate var _currentVersion : Int?

    fileprivate func _toStringArray(_ iosObjectArray : IOSObjectArray?) -> Array<String?> {
        if (iosObjectArray == nil) { return Array<String?>() }

        var array : Array<String?> = Array<String?>()

        let length : Int = Int(iosObjectArray!.length())
        for i : UInt in 0 ..< UInt(length) {
            let stringValue = iosObjectArray!.object(at: i) as? String
            array.append(stringValue)
        }

        return array
    }

    fileprivate func _bindQuery(query : String, parameters : Array<String?>) -> SqlQuery {
        var statement : SqlQuery? = nil

        sqlite3_prepare_v2(_database, query, -1, &statement, nil)
        for i : Int in 0 ..< parameters.count {
            let queryParameter : String? = parameters[i]

            if (queryParameter != nil) {
                sqlite3_bind_text(statement, i+1, queryParameter!, -1, IosDatabase._SQLITE_TRANSIENT)
            }
            else {
                sqlite3_bind_null(statement, i+1)
            }
        }

        return statement!
    }

    fileprivate func _execDdl(_ query : String) {
        sqlite3_exec(_database, query, nil, nil, nil)
    }

    fileprivate func _execSql(query : String, parameters : Array<String?>) {
        let statement : SqlQuery = _bindQuery(query: query, parameters: parameters)

        sqlite3_step(statement)

        sqlite3_finalize(statement)
    }

    fileprivate func _query(query : String, parameters : Array<String?>) -> Array<Dictionary<String, String?>> {
        let statement : SqlQuery = _bindQuery(query: query, parameters: parameters)

        var results : Array<Dictionary<String, String?>> = Array<Dictionary<String, String?>>()

        while (sqlite3_step(statement) == SQLITE_ROW) {
            // let id : sqlite3_int64 = sqlite3_column_int64(statement, 0)

            var row : Dictionary<String, String?> = Dictionary<String, String?>()

            let columnCount : Int = NSInteger(sqlite3_data_count(statement)) as Int
            for i : Int in 0 ..< columnCount {
                var columnName : String! = String(cString: sqlite3_column_name(statement, Int32(i)))
                if (columnName == nil) {
                    columnName = "column_\(i)"
                }

                let columnValue : String?
                let rawColumnValue : UnsafePointer<UInt8>? = sqlite3_column_text(statement, Int32(i))
                if (rawColumnValue != nil) {
                    columnValue = String(cString: rawColumnValue!)
                }
                else {
                    columnValue = nil
                }

                row[columnName] = columnValue
            }

            results.append(row)
        }

        sqlite3_finalize(statement)

        return results
    }

    fileprivate func _getVersion() -> Int? {
        return UserDefaults.standard.integer(forKey: "DB_VERSION")

        /*
            let rows : Array<Dictionary<String, String?>> = _query(query: "PRAGMA user_version", parameters: Array<String?>())
            for row : Dictionary<String, String?> in rows {
                for columnName : String in row.keys {
                    let columnValue : String? = row[columnName]!
                    if (columnValue == nil) { return nil }
                    return Int(columnValue!)
                }
            }
            return nil
         */
    }

    fileprivate func _setVersion(_ version : Int) {
        UserDefaults.standard.set(version, forKey: "DB_VERSION")

        // _execSql(query: "PRAGMA user_version = ?", parameters: [String(version)])
    }

    fileprivate override init() { }

    public init(databaseName : String, requiredVersion : Int) {
        super.init()

        _databaseName = databaseName
        _requiredVersion = requiredVersion

        let documents : URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL : URL = documents.appendingPathComponent(_databaseName)

        _databaseExisted = (fileURL as NSURL).checkResourceIsReachableAndReturnError(nil)

        var databasePointer : SqliteDatabase? = nil
        if (sqlite3_open(fileURL.path, &databasePointer) != SQLITE_OK) {
            print("ERROR: Could not open database.")
        }

        _database = databasePointer

        _currentVersion = _getVersion()
    }


    open func executeDdl(with query: String!) {
        _execDdl(query)
    }

    open func executeSql(with query: String!, withNSStringArray parameters: IOSObjectArray!) {
        _execSql(query: query, parameters: _toStringArray(parameters))
    }

    open func query(with query: String!, withNSStringArray parameters: IOSObjectArray!) -> JavaUtilList! {
        let rows : Array<Dictionary<String, String?>> = _query(query: query, parameters: _toStringArray(parameters))

        let javaList : JavaUtilList = JavaUtilArrayList(int: Int32(rows.count))

        for row : Dictionary<String, String?> in rows {
            javaList.add(withId: IosDatabaseRow.fromDictionary(row))
        }

        return javaList
    }

    open func getInsertId() -> JavaLangLong! {
        return JavaLangLong(value: sqlite3_last_insert_rowid(_database));
    }

    open func getVersion() -> JavaLangInteger! {
        if (_currentVersion == nil) { return nil; }

        return JavaLangInteger(value: Int32(_currentVersion!))
    }

    open func setVersionWith(_ newVersion: JavaLangInteger!) {
        _setVersion(newVersion as Int)
    }

    open func shouldBeCreated() -> JavaLangBoolean! {
        return JavaLangBoolean(boolean: !_databaseExisted)
    }

    open func shouldBeUpgraded() -> JavaLangBoolean! {
        if (_currentVersion == nil) { return JavaLangBoolean(boolean: false) }

        return JavaLangBoolean(boolean: (_currentVersion! < _requiredVersion))
    }

    open func shouldBeDowngraded() -> JavaLangBoolean! {
        if (_currentVersion == nil) { return JavaLangBoolean(boolean: false) }

        return JavaLangBoolean(boolean: (_currentVersion! > _requiredVersion))
    }
}

open class IosDatabaseRow : NSObject, ComSoftwareverdeUtopiaDatabaseDatabase_Row {
    open static func fromDictionary(_ dictionary : Dictionary<String, String?>) -> IosDatabaseRow {

        let iosDatabaseRow : IosDatabaseRow = IosDatabaseRow()
        for columnName in dictionary.keys {
            let columnValue : String? = dictionary[columnName]!

            iosDatabaseRow._columnNames.append(columnName)

            iosDatabaseRow._columnValues.updateValue(columnValue, forKey: columnName)
        }

        return iosDatabaseRow
    }

    fileprivate var _columnNames : Array<String> = Array<String>()
    fileprivate var _columnValues : Dictionary<String, String?> = Dictionary<String, String?>()

    fileprivate override init() { }

    open func getColumnNames() -> JavaUtilList! {
        let javaList : JavaUtilList = JavaUtilArrayList(int: Int32(_columnNames.count))

        for columnName : String in _columnNames {
            javaList.add(withId: columnName)
        }

        return javaList
    }

    open func getValueWith(_ columnName: String!) -> String! {
        return _columnValues[columnName!]!
    }
}
