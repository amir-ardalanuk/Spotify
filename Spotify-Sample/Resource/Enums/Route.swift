//
//  Route.swift
//  ICRM-Customer
//
//  Created by Amir ARdalam
//  Copyright © 2017 Amir Ardi. All rights reserved.
//

import Foundation

let baseUrl = "https://api-crmretail.gig.services" // Main
//let baseUrl = "https://crmretail-api.gig.services" //Develope
//gtarabar-api.gig.services

enum Route: String {
    
    //MARK:Customer
    case getInviteeCode                     = "/C/Customer/GetInviteeCode"
    case saveInviteeCode                    = "/C/Customer/SaveInviteeCode"
    case validationMobilePhone              = "/C/Customer/ValidationMobilePhone"
    case loginCustomerStep1                 = "/C/Customer/LoginCustomerStep1"
    case loginCustomerStep2                 = "/C/Customer/LoginCustomerStep2"
    case resendValidationCode               = "/C/Customer/ResendValidationCode"
    case getCustomerInCompany               = "/C/Customer/GetCustomerInCompany"
    case getCompanyOfCustomer               = "/C/Customer/GetCompanyOfCustomer"
    case validateTagNumber                  = "/C/Customer/ValidateTagNumber"
    case loginCustomerWithOnlyQrFactor      = "/C/Customer/LoginCustomerWithOnlyQrFactor"
    case logout                             = "/C/Customer/Logout"
    case saveCustomerCompleteInfo           = "/C/Customer/SaveCustomerCompleteInfo"
    case saveRequestEditInfo                = "/C/Customer/SaveRequestEditInfo"
    case getRequestEditHistory              = "/C/Customer/GetRequestEditHistory"
    case saveRequestDeActiveCustomer        = "/C/Customer/SaveRequestDeActiveCustomer"
    case getRequestDeActiveCustomerHistory  = "/C/Customer/GetRequestDeActiveCustomerHistory"
    case saveDocumentImage                  = "/C/Customer/SaveDocumentImage"
    case getDocumentImages                  = "/C/Customer/GetDocumentImages"
    case getAllInterested                   = "/C/Customer/GetAllInterested"
    case saveInterested                     = "/C/Customer/SaveInterested"
    case saveRequestVisit                   = "/C/Customer/SaveRequestVisit"
    case getRequestVisitHistory             = "/C/Customer/GetRequestVisitHistory"
    case removeDocumentImage                = "/C/Customer/RemoveDocumentImage"
    case getCustomerInfo                    = "/C/Customer/GetCustomerInfo"
    case saveCustomerInfo                   = "/C/Customer/SaveCustomerInfo"
    case loginCustomerStep1WithQrFactor     = "/C/Customer/LoginCustomerStep1WithQrFactor"
    case LoginCustomerWithQrFactorAndTag    = "/C/Customer/LoginCustomerWithQrFactorAndTag"
    case saveNotificationToken              = "/C/Customer/SaveNotificationToken"
    case deleteNotificationToken            = "/C/Customer/DeleteNotificationToken/" // {Token}
    case saveErrorLogin                     = "/C/Customer/SaveErrorLogin"
    case getCustomerAllCompany              = "/C/Customer/GetAllCompany"
    case getCustomerVisitor                 = "/C/Customer/GetCustomerVisitor"
    case saveCustomerVisitor                = "/C/Customer/SaveCustomerVisitor"
    case saveRequestJoinClub                = "/C/Customer/SaveRequestJoinClub"
    case loginGuest                         = "/C/Customer/LoginGuest"
    case getInvitedList                     = "/C/Customer/GetInvitedList"
    case getValidationCodeForLogin          = "/C/Customer/GetValidationCodeForLogin"
    //MARK: Token
    case getClientToken = "/Token/GetClientToken"
    //MARK:News
    case getAllNews = "/C/News/GetAllNews"
    case getNewsById = "/C/News/GetNewsById/"
    case saveNews = "/C/News/SaveNews"
    case removeNews = "/C/News/RemoveNews"
    case getAllNewsComment = "/C/News/GetAllNewsComment"
    case saveNewsComment = "/C/News/SaveNewsComment"
    case removeNewsCommentById = "/C/News/RemoveNewsCommentById"
    case removeInterestedById = "/C/News/RemoveInterestedById"
    case getAllTag = "/C/News/GetAllTag"
    case getTagById = "/C/News/GetTagById/"
    case removeTagById = "/C/News/RemoveTagById"
    case saveNewsLike = "/C/News/SaveNewsLike"
    //MARK:Survey
    case getSurveyList = "/C/Survey/GetSurveyList"
    case getSurvey = "/C/Survey/GetSurvey"
    case saveSurvey = "/C/Survey/SaveSurvey"
    //MARK:TransactionPoint
    case getBonuses = "/C/TransactionPoint/GetBonuses"
    case getCustomerScore = "/C/TransactionPoint/GetCustomerScore"
    case getStoreScore = "/C/TransactionPoint/GetStoreScore"
    case getHistoryLottery = "/C/TransactionPoint/GetHistoryLottery"
    case getHistoryDiscountCard = "/C/TransactionPoint/GetHistoryDiscountCard"
    case saveBonusPointTransaction = "/C/TransactionPoint/SaveBonusPointTransaction"
    case getBonusInfo = "/C/TransactionPoint/GetBonusInfo"
    case getPointTransactionHistory = "/C/TransactionPoint/GetPointTransactionHistory"
    case getBonusCard = "/C/TransactionPoint/GetBonusCard"
    case getWinLottery = "/C/TransactionPoint/GetWinLottery"
    case savePointForAction = "/C/TransactionPoint/SavePointForAction"
    //MARK: Master Data
    case getCompanyList = "/C/MasterData/GetCompanyList"
    case getCompanyInfo = "/C/MasterData/GetCompanyInfo/"
    case getContent = "/C/MasterData/GetContent" 
    case saveCompanyComment = "/C/MasterData/SaveCompanyComment"
    case getRateIndex = "/C/MasterData/GetRateIndex"
    case saveRateIndex = "/C/MasterData/SaveRateIndex"
    case getAllStaticTex = "/A/MasterDataAdmin/GetAllStaticTex"
    case getCustomerRate = "/C/MasterData/GetCustomerRate/" //{MasterCustomerId}/{CompanyId}
    case getAllBranch = "/C/MasterData/GetAllBranch"
    case getAllBrand = "/C/MasterData/GetAllBrand"
    case getAllCompany = "/C/MasterData/GetAllCompany/" //{CompanyId}
    case getAllProductGroup = "/C/MasterData/GetAllProductGroup"
    case getAllProduct = "/C/MasterData/GetAllProduct"
    //MARK: Case
    case getCaseCompany = "/C/CRM/GetCaseCompany/"
    case createCase = "/C/CRM/CreateCase"
    case caseSubTypes = "/C/CRM/CaseSubTypes/" //{caseType}
    case caseTypes = "/C/CRM/CaseTypes"
    case getCases = "/C/CRM/GetCases"
    case GetCaseStatus = "/C/CRM/GetCaseStatus/" //{trackingCode}/{mobilePhone}
    //MARK: Order
    case totalOrderInfo = "/C/Order/TotalOrderInfo"
    case totalReturnedInfo = "/C/Order/TotalReturnedInfo"
    case totalChequeInfo = "/C/Order/TotalChequeInfo"
    case getOrderHeaders = "/C/Order/GetOrderHeaders"
    case getOrderDetails = "/C/Order/GetOrderDetails"
    case getReturnHeaders = "/C/Order/GetReturnHeaders"
    case getReturnDetails = "/C/Order/GetReturnDetails"
    case getChequeHeadersCollect = "/C/Order/GetChequeHeadersCollect"
    case getChequeHeadersNotCollect = "/C/Order/GetChequeHeadersNotCollect"
    case getChequeHeaders = "/C/Order/GetChequeHeaders"
    //MARK: General
    case checkValidationCode = "/General/CheckValidationCode"
    case getAppVersionControl = "/General/GetAppVersionControl"
    case getAppDefaultSetting = "/General/GetAppDefaultSetting"
    case getEnumNames = "/General/GetEnumNames"
    case requestChangeMobilePhone = "/General/RequestChangeMobilePhone"
    case resendVerificationCode = "/General/ResendVerificationCode"
    case approveChangeMobilePhone = "/General/ApproveChangeMobilePhone"
    case getNotificationSetting = "/General/GetNotificationSetting"
    case setNotificationSetting = "/General/SetNotificationSetting"
    case checkMaximumAcceptableDistance = "/General/CheckMaximumAcceptableDistance"
    case getTerminalDetails = "/General/GetTerminalDetails/"
    
    case getShowCase = "/General/GetShowCase"
    case getCompanyDefaultSetting = "/General/GetCompanyDefaultSetting"
   
    //MARK: Notification
    case getAllNotification = "/C/Notification/GetAllNotification"
    
    // MARK: - Payment
    case savePayment = "/C/Payment/SavePayment"
    case paymentReport = "/C/Payment/PaymentReport"
    case sepQRVerify = "/SepQRVerify"
    case minPaymentValue = "/C/Payment/GetMinPaymentValue"
    case getSucceededPayment = "/C/Payment/GetSucceededPayment"
    // MARK: - Shaparak
    case verifyShaparak = "/VPG/api/v0/Advice/Verify"
    
    
}

extension Route {
    
    var url : String {
        return baseUrl + "\(self.rawValue)"
    }
}






