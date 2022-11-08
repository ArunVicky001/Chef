//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 12/01/22
//  Copyright (c) . All rights reserved.
//

import TopprUtilitiesiOS
import SwiftyJSON

struct VerifyOTPNewNumberDataResponse: StructuredParser {

	let isSuccesss: Bool

    init(from json: JSON) {
		isSuccesss = json["is_successs"].boolValue
    }
}

extension VerifyOTPNewNumberDataResponse: DomainConvertibleType {
    func asDomain() -> VerifyOTPNewNumberDataEntity {
        return VerifyOTPNewNumberDataEntity(
            isSuccesss: isSuccesss)
    }
}
