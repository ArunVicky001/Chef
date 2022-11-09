//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 27/05/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct ValidateOTPDataResponse: StructuredParser {

	let mobileNumber: String
	let otp: String
	let deviceId: String

    init(from json: JSON) {
		mobileNumber = json["mobileNumber"].stringValue
		otp = json["otp"].stringValue
		deviceId = json["deviceId"].stringValue
    }
}

extension ValidateOTPDataResponse: DomainConvertibleType {
    func asDomain() -> ValidateOTPDataEntity {
        return ValidateOTPDataEntity(
            mobileNumber: mobileNumber,
			otp: otp,
			deviceId: deviceId)
    }
}
