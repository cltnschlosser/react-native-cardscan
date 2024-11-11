//
//  StripeCardScanBundleLocator.swift
//  StripeCardScan
//
//  Created by Sam King on 11/10/21.
//  Copyright © 2021 Stripe, Inc. All rights reserved.
//

import Foundation

final class StripeCardScanBundleLocator {
    static let internalClass: AnyClass = StripeCardScanBundleLocator.self
    static let bundleName = "StripeCardScanBundle"
    static let resourcesBundle = StripeCardScanBundleLocator.computeResourcesBundle()

    static func computeResourcesBundle() -> Bundle {
        var ourBundle: Bundle?

        #if SWIFT_PACKAGE
            ourBundle = spmResourcesBundle
        #endif

        if ourBundle == nil {
            ourBundle = Bundle(path: "\(bundleName).bundle")
        }

        if ourBundle == nil {
            // This might be the same as the previous check if not using a dynamic framework
            if let path = Bundle(for: internalClass).path(
                forResource: bundleName,
                ofType: "bundle"
            ) {
                ourBundle = Bundle(path: path)
            }
        }

        if ourBundle == nil {
            // This will be the same as mainBundle if not using a dynamic framework
            ourBundle = Bundle(for: internalClass)
        }

        if let ourBundle = ourBundle {
            return ourBundle
        } else {
            return Bundle.main
        }
    }
}
