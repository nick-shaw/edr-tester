/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Implementation of the cross-platform view controller.
*/

#import "AAPLViewController.h"
#import "AAPLRenderer.h"

@implementation AAPLViewController
{
    MTKView *_view;

    AAPLRenderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView *)self.view;

// This need to be disabled so the window updates continuously
// Otherwise it doesn't update unless you resize it, and I don't know how to force an update
//    _view.enableSetNeedsDisplay = YES;
    
    _view.device = MTLCreateSystemDefaultDevice();
    
    _view.clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0);
    
    // Additional attributes of the view to support EDR
    CAMetalLayer * metalLayer = (CAMetalLayer *)_view.layer;
    metalLayer.wantsExtendedDynamicRangeContent = YES;
    metalLayer.pixelFormat = MTLPixelFormatRGBA16Float;
    const CFStringRef name = kCGColorSpaceExtendedLinearDisplayP3;
    CGColorSpaceRef colorspace = CGColorSpaceCreateWithName(name);
    metalLayer.colorspace = colorspace;
    CGColorSpaceRelease(colorspace);

    _renderer = [[AAPLRenderer alloc] initWithMetalKitView:_view];

    if(!_renderer)
    {
        NSLog(@"Renderer initialization failed");
        return;
    }

    // Initialize the renderer with the view size.
    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];
    
    _view.delegate = _renderer;
    
    // This was supposed to set the focus to the Controls window, but doesn't work!
    [self.Controls makeKeyAndOrderFront:nil];
    
// On first launch the maxEDR value is read as zero, so not run until Update is clicked
//    [self setEDRvalue];
}

- (void)setEDRvalue
{
    float maxEDR = _view.window.screen.maximumExtendedDynamicRangeColorComponentValue;
    [_maxEDRvalue setFloatValue:maxEDR];
}

- (IBAction)nudgeDown:(id)sender {
    float red = _redValue.floatValue;
    float green = _greenValue.floatValue;
    float blue = _blueValue.floatValue;
    float step = _nudgeStep.floatValue;
    red = fmaxf(0, red-step);
    green = fmaxf(0, green-step);
    blue = fmaxf(0, blue-step);
    [_redValue setFloatValue:red];
    [_greenValue setFloatValue:green];
    [_blueValue setFloatValue:blue];
    _view.clearColor = MTLClearColorMake(red, green, blue, 1.0);
    [self setEDRvalue];
}

- (IBAction)nudgeUp:(id)sender {
    float red = _redValue.floatValue;
    float green = _greenValue.floatValue;
    float blue = _blueValue.floatValue;
    float step = _nudgeStep.floatValue;
    red += step;
    green += step;
    blue += step;
    [_redValue setFloatValue:red];
    [_greenValue setFloatValue:green];
    [_blueValue setFloatValue:blue];
    _view.clearColor = MTLClearColorMake(red, green, blue, 1.0);
    [self setEDRvalue];
}

- (IBAction)updatePressed:(id)sender {
    float red = _redValue.floatValue;
    float green = _greenValue.floatValue;
    float blue = _blueValue.floatValue;
    _view.clearColor = MTLClearColorMake(red, green, blue, 1.0);
    [self setEDRvalue];
}

- (IBAction)eotfChanged:(id)sender {
    int eotf = (int)_eotfDropdown.indexOfSelectedItem;
//    NSLog(@"%d", eotf);
    CAMetalLayer * metalLayer = (CAMetalLayer *)_view.layer;
    CFStringRef name;
    if (eotf == 0)
    {
        name = kCGColorSpaceExtendedLinearDisplayP3;
    }
    else if (eotf == 1)
    {
        name = kCGColorSpaceExtendedDisplayP3;
    }
    else if (eotf == 2)
    {
        name = kCGColorSpaceExtendedSRGB;
    }
    else if (eotf == 3)
    {
        name = kCGColorSpaceITUR_2100_HLG;
    }
    else if (eotf == 4)
    {
        name = kCGColorSpaceITUR_2100_PQ;
    }
    else if (eotf == 5)
    {
        name = kCGColorSpaceExtendedLinearITUR_2020;
    }
    else // if (eotf == 6)
    {
        name = nil;
    }
    
    if (eotf < 6)
    {
        CGColorSpaceRef colorspace = CGColorSpaceCreateWithName(name);
        metalLayer.colorspace = colorspace;
        CGColorSpaceRelease(colorspace);
    }
    else
    {
        metalLayer.colorspace = nil;
    }
    [self setEDRvalue];
}
@end
