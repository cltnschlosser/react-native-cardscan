//
//  Created by Sam King on 3/20/20.
//  Copyright © 2020 Sam King. All rights reserved.
//

extension UxModelOutput {
    func argMax() -> Int {
        return self.argAndValueMax().0
    }

    func argAndValueMax() -> (Int, Double) {
        var maxIdx = -1
        var maxValue = NSNumber(value: -1.0)
        for idx in 0..<3 {
            let index: [NSNumber] = [NSNumber(value: idx)]
            let value = self.output1[index]
            if value.doubleValue > maxValue.doubleValue {
                maxIdx = idx
                maxValue = value
            }
        }

        return (maxIdx, maxValue.doubleValue)
    }

    func cardCenteredState() -> CenteredCardState {
        switch self.argMax() {
        case 0:
            return .nonNumberSide
        case 2:
            return .numberSide
        default:
            return .noCard
        }
    }

    func confidenceValues() -> (Double, Double, Double)? {
        let idxRange = 0..<3
        let indexValues = idxRange.map { [NSNumber(value: $0)] }
        var confidenceValues = indexValues.map { self.output1[$0].doubleValue }

        guard let pan = confidenceValues.popLast(), let noCard = confidenceValues.popLast(),
            let noPan = confidenceValues.popLast()
        else {
            return nil
        }

        return (pan, noPan, noCard)
    }
}
