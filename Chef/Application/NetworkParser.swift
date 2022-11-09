//
//  NetworkParser.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 12/01/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol NetworkParser {
    init(from json: JSON) throws
}

public protocol StructuredParser: NetworkParser {}
public protocol UnstructuredParser: NetworkParser {}

struct StructuredParserData<T: NetworkParser> {
    
    private enum Keys: String {
        case statusCode = "status_code"
        case data = "data"
        case status = "status"
        case message = "message"
    }
    
    let statusCode: Int
    let data: T
    let status: String
    let message: String?
    
    init(from json: JSON) throws {
        self.data = try T(from: json[Keys.data.rawValue])
        statusCode = json[Keys.statusCode.rawValue].intValue
        status = json[Keys.status.rawValue].stringValue
        message = json[Keys.message.rawValue].string
    }
}

extension Array: NetworkParser, StructuredParser where Element: StructuredParser {
    public init(from json: JSON) {
        self = json.arrayValue.compactMap { try? Element(from: $0) }
    }
}
