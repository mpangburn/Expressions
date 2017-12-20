import UIKit
import PlaygroundSupport


extension UIImage {
    public func saveToDocumentsDirectory(as name: String) {
        guard let data = UIImagePNGRepresentation(self) else { print("Could not retrieve image data."); return }
        let filename = playgroundSharedDataDirectory.appendingPathComponent(name)
        try! data.write(to: filename) // will spit out the appropriate error in the Playground console if it occurs
    }
}
