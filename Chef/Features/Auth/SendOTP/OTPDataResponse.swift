//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 21/05/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct OTPDataResponse: StructuredParser {

	let deviceId: String
	let mobileNumber: String
	let otp: String
	let text: String
    let status: String?

    init(from json: JSON) {
		deviceId = json["deviceId"].stringValue
		mobileNumber = json["mobileNumber"].stringValue
		otp = json["otp"].stringValue
		text = json["text"].stringValue
        status = json["status"].stringValue
    }
}

extension OTPDataResponse: DomainConvertibleType {
    func asDomain() -> OTPDataEntity {
        return OTPDataEntity(
            deviceId: deviceId,
			mobileNumber: mobileNumber,
			otp: otp,
			text: text,
            status: status)
    }
}
