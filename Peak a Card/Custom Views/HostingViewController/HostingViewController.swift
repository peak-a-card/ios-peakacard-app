import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController<CardGridView> {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
