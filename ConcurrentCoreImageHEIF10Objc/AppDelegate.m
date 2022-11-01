#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSURL* testImageUrl = [[NSBundle mainBundle] URLForResource:@"test_image" withExtension:@"jpeg"];
  CIImage* testImage = [CIImage imageWithContentsOfURL:testImageUrl];
  CIContext* ciContext = [CIContext contextWithMTLDevice:MTLCreateSystemDefaultDevice()];

  NSError *error;
  [ciContext HEIF10RepresentationOfImage:testImage
                              colorSpace:CGColorSpaceCreateWithName(kCGColorSpaceDisplayP3_PQ)
                                 options:[NSDictionary new]
                                   error:&error];
  if (error) {
    NSLog(@"%@", error);
  }

  dispatch_queue_global_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
  dispatch_apply(8, queue, ^ (size_t iteration) {
    NSError *error;
    [ciContext HEIF10RepresentationOfImage:testImage
                                colorSpace:CGColorSpaceCreateWithName(kCGColorSpaceDisplayP3_PQ)
                                   options:[NSDictionary new]
                                     error:&error];
    if (error) {
      NSLog(@"%@", error);
    }
  });
}

@end
