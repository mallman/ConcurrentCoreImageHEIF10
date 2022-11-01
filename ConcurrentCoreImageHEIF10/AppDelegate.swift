import AppKit
import Metal

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  @IBOutlet var window: NSWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let testImageUrl = Bundle.main.url(forResource: "test_image", withExtension: "jpeg")!
    let testImage = CIImage(contentsOf: testImageUrl)!
    let ciContext = CIContext(mtlDevice: MTLCreateSystemDefaultDevice()!)

    let colorSpace = CGColorSpace(name: CGColorSpace.displayP3_PQ)!
    // This works
    try! ciContext.heif10Representation(of: testImage, colorSpace: colorSpace)

    // This crashes with EXC_BAD_ACCESS
    DispatchQueue.concurrentPerform(iterations: 8) { _ in
      try! ciContext.heif10Representation(of: testImage, colorSpace: colorSpace)
    }
  }
}
