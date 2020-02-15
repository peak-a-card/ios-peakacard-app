import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController<CardGrid> {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
