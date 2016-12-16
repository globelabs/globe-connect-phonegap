//
//  Payment.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Payment) class Payment : CDVPlugin {
    var paymentAccessToken: String?
    var paymentAppId: String?
    var paymentAppSecret: String?
    var paymentAmount: Float?
    var paymentDescription: String?
    var paymentEndUserId: String?
    var paymentReferenceCode: String?
    var paymentTransactionOperationStatus: String?

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentAccessToken = argument

        return self
    }

    @objc(setAppId:) func setAppId(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentAppId = argument

        return self
    }

    @objc(setAppSecret:) func setAppSecret(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentAppSecret = argument

        return self
    }

    @objc(setAmount:) func setAmount(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? Float ?? 0.00
        self.paymentAmount = argument

        return self
    }

    @objc(setDescription:) func setDescription(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentDescription = argument

        return self
    }

    @objc(setEndUserId:) func setEndUserId(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentEndUserId = argument

        return self
    }

    @objc(setReferenceCode:) func setReferenceCode(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentReferenceCode = argument

        return self
    }

    @objc(setTransactionOperationStatus:) func setTransactionOperationStatus(command: CDVInvokedUrlCommand) -> Payment {
        let argument = command.arguments[0] as? String ?? ""
        self.paymentTransactionOperationStatus = argument

        return self
    }

    @objc(sendPaymentRequest:) func sendPaymentRequest(command: CDVInvokedUrlCommand) -> Payment {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let sendPaymentURL = "https://devapi.globelabs.com.ph/payment/v1/transactions/amount?access_token="+self.paymentAccessToken!

        // set the payload
        let data: [String: Any] = [
            "amount"                      : String(format: "%.2f", self.paymentAmount!),
            "description"                 : self.paymentDescription!,
            "endUserId"                   : self.paymentEndUserId!,
            "referenceCode"               : self.paymentReferenceCode!,
            "transactionOperationStatus"  : self.paymentTransactionOperationStatus!
        ]

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // we need to convert first the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                HTTPRequest(url: sendPaymentURL, headers: headers)
                    .post(
                        parameters: jsonPayload,
                        success: { data, _ in
                            DispatchQueue.global(qos: .utility).async {
                                DispatchQueue.main.async {
                                    pluginResult = CDVPluginResult(
                                        status: CDVCommandStatus_OK,
                                        messageAs: String(data: data, encoding: .utf8)
                                    )

                                    self.commandDelegate!.send(
                                        pluginResult,
                                        callbackId: command.callbackId
                                    )
                                }
                            }
                    }, failure: { error, data in
                        pluginResult = CDVPluginResult(
                            status: CDVCommandStatus_ERROR,
                            messageAs: String(data: data, encoding: .utf8)
                        )

                        self.commandDelegate!.send(
                            pluginResult,
                            callbackId: command.callbackId
                        )
                    })
            }
        } catch let error as NSError {
            // oops, error in converting it to JSON
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs: error.localizedDescription
            )

            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            )
        }

        return self
    }

    @objc(getLastReferenceCode:) func getLastReferenceCode(command: CDVInvokedUrlCommand) -> Payment {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        let getLastReferenceCodeURL = "https://devapi.globelabs.com.ph/payment/v1/transactions/getLastRefCode?app_id="+self.paymentAppId!+"&app_secret="+self.paymentAppSecret!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // perform request
        HTTPRequest(url: getLastReferenceCodeURL, headers: headers).get(
            success: { data, _ in
                DispatchQueue.global(qos: .utility).async {
                    DispatchQueue.main.async {
                        pluginResult = CDVPluginResult(
                            status: CDVCommandStatus_OK,
                            messageAs: String(data: data, encoding: .utf8)
                        )

                        self.commandDelegate!.send(
                            pluginResult,
                            callbackId: command.callbackId
                        )
                    }
                }
            },
            failure: { error, data in
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: String(data: data, encoding: .utf8)
                )

                self.commandDelegate!.send(
                    pluginResult,
                    callbackId: command.callbackId
                )
            })

        return self
    }
}
