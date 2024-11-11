//
//  RNCardScan.swift
//  RNCardScan
//
//  Created by Jaime Park on 9/22/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

import StripeCardScan
import Foundation
import UIKit

@available(iOS 11.2, *)
@objc(RNCardscan)
class RNCardScan: NSObject {
    override init() {
        super.init()
    }

    @objc class func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc func isSupportedAsync(
        _ resolve: RCTPromiseResolveBlock,
        _ reject: RCTPromiseRejectBlock
    ) -> Void {
      resolve(true)
    }

    @objc func setiOSScanViewStyle(_ styleDictionary: NSDictionary) {
    }

    @objc func scan(
        _ resolve: @escaping RCTPromiseResolveBlock,
        _ reject: @escaping RCTPromiseRejectBlock
    ) -> Void {
      DispatchQueue.main.async {
        let cardScanSheet = CardScanSheet()
        guard let topViewController = self.getTopViewController() else {
          reject(nil, nil, nil)
          return
        }
        cardScanSheet.present(from: topViewController) { result in
          switch result {
          case .completed(let card):
            var resolvePayload: [String: Any] = [:]
            resolvePayload["action"] = "scanned"
            var payload: [String: Any] = [:]
            payload["number"] = card.pan
            payload["cardholderName"] = card.name
            payload["expiryMonth"] = card.expiryMonth
            payload["expiryYear"] = card.expiryYear
            resolvePayload["payload"] = payload
            resolve(resolvePayload)
          case .canceled:
            resolve([
                "action": "canceled",
                "canceledReason": "user_canceled"
            ])
          case .failed(let error):
            reject(nil, error.localizedDescription, error)
          }
        }
      }
    }

    func getTopViewController() -> UIViewController? {
      guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else {
        return nil
      }

      while let nextViewController = topViewController.presentedViewController {
        topViewController = nextViewController
      }

      return topViewController
    }
}
