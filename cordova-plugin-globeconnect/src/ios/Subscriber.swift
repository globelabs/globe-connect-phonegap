//
//  Subscriber.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Subscriber) class Subscriber : CDVPlugin {
    var subscriberAccessToken: String?
    var subscriberAddress: String?

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> Subscriber {
        let argument = command.arguments[0] as? String ?? ""
        self.subscriberAccessToken = argument

        return self
    }

    @objc(setAddress:) func setAddress(command: CDVInvokedUrlCommand) -> Subscriber {
        let argument = command.arguments[0] as? String ?? ""
        self.subscriberAddress = argument

        return self
    }

    @objc(getSubscriberBalance:) func getSubscriberBalance(command: CDVInvokedUrlCommand) -> Subscriber {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        var getSubscriberBalanceURL = "https://devapi.globelabs.com.ph/location/v1/queries/balance"
        getSubscriberBalanceURL += "?access_token="+self.subscriberAccessToken!+"&address="+self.subscriberAddress!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // perform request
        HTTPRequest(url: getSubscriberBalanceURL, headers: headers).get(
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

    @objc(getSubscriberReloadAmount:) func getSubscriberReloadAmount(command: CDVInvokedUrlCommand) -> Subscriber {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        var getSubscriberReloadAmountURL = "https://devapi.globelabs.com.ph/location/v1/queries/reload_amount"
        getSubscriberReloadAmountURL += "?access_token="+self.subscriberAccessToken!+"&address="+self.subscriberAddress!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // perform request
        HTTPRequest(url: getSubscriberReloadAmountURL, headers: headers).get(
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
