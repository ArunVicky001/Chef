//
//  AuthUseCaseProvider.swift
//  TeachOS
//
//  Created by Bhagyashree Myanamwar on 9/22/21.
//

import Foundation

protocol AuthUseCaseProvider {
    func countryListUseCase() -> CountryListUseCase
    func checkPhoneUseCase() -> CheckPhoneUseCase
    func signupUseCase() -> SignupUseCase
    func sendOtpUseCase() -> SendOTPUseCase
    func verifyOtpUseCase() -> VerifyOTPUseCase
    func getJwtTokenUseCase() -> GetJWTTokenUseCase
    func logoutUseCase() -> LogoutUseCase
    func batchDetailUseCase() -> BatchDetailUseCase
    func joinBatchUseCase() -> JoinBatchUseCase
    func studentInfoUseCase() -> StudentDetailUseCase
}

