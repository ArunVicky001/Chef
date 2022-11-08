//
//  DataResponse.swift
//
//  Created by Vignesh Arunagiri on 27/05/22
//  Copyright (c) . All rights reserved.
//

import SwiftyJSON

struct DataResponse: StructuredParser {

	let mobileNumber: String
	let otp: String
	let deviceId: String

    init(from json: JSON) {
		mobileNumber = json["mobileNumber"].stringValue
		otp = json["otp"].stringValue
		deviceId = json["deviceId"].stringValue
    }
}

extension DataResponse: DomainConvertibleType {
    func asDomain() -> DataEntity {
        return DataEntity(
            mobileNumber: mobileNumber,
			otp: otp,
			deviceId: deviceId)
    }
}
