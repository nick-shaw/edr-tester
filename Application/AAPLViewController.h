/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Header for the cross-platform view controller.
*/

#if defined(TARGET_IOS) || defined(TARGET_TVOS)
@import UIKit;
#define PlatformViewController UIViewController
#else
@import AppKit;
#define PlatformViewController NSViewController
#endif

@import MetalKit;

#import "AAPLRenderer.h"

@interface AAPLViewController : PlatformViewController
@property (strong) IBOutlet NSWindow *Controls;
@property (weak) IBOutlet NSView *ControlsWindow;
@property (weak) IBOutlet NSTextField *redValue;
@property (weak) IBOutlet NSTextField *greenValue;
@property (weak) IBOutlet NSTextField *blueValue;
@property (weak) IBOutlet NSTextField *maxEDRvalue;
@property (weak) IBOutlet NSTextField *maxPotEDRvalue;

@property (weak) IBOutlet NSPopUpButton *eotfDropdown;
@property (weak) IBOutlet NSTextFieldCell *nudgeStep;
@property (weak) IBOutlet NSTextField *maxRefEDRvalue;

- (IBAction)eotfChanged:(id)sender;
- (IBAction)updatePressed:(id)sender;
- (IBAction)nudgeUp:(id)sender;
- (IBAction)nudgeDown:(id)sender;

@end
