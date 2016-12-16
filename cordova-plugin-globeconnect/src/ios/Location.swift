//
//  Location.swift
//
//  Created by Rico Maglayon on 08/12/2016.
//

import Foundation

@objc(Location) class Location : CDVPlugin {
    var locationAccessToken: String?
    var locationAddress: String?
    var locationAccuracy: Int?

    @objc(setAccessToken:) func setAccessToken(command: CDVInvokedUrlCommand) -> Location {
        let argument = command.arguments[0] as? String ?? ""
        self.locationAccessToken = argument

        return self
    }

    @objc(setAddress:) func setAddress(command: CDVInvokedUrlCommand) -> Location {
        let argument = command.arguments[0] as? String ?? ""
        self.locationAddress = argument

        return self
    }

    @objc(setRequestedAccuracy:) func setRequestedAccuracy(command: CDVInvokedUrlCommand) -> Location {
        let argument = command.arguments[0] as? Int ?? 0
        self.locationAccuracy = argument

        return self
    }
    
    @objc(getLocation:) func getLocation(command: CDVInvokedUrlCommand) -> Void {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )

        // set the url
        var locationUrl = "https://devapi.globelabs.com.ph/location/v1/queries/location?"
        locationUrl += "access_token="+self.locationAccessToken!
        locationUrl += "&address="+self.locationAddress!
        locationUrl += "&requestedAccuracy="+String(self.locationAccuracy!)

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // perform request
        HTTPRequest(url: locationUrl, headers: headers).get(
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
    }
}
