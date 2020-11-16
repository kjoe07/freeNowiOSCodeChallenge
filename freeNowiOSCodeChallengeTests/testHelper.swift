//
//  testHelper.swift
//  freeNowiOSCodeChallengeTests
//
//  Created by kjoe on 11/14/20.
//

import UIKit

func tap(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}
