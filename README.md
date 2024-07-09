# EDR tester

This is a simple modification of the Apple sample code called [`MetalKitAndRenderingSetup`](https://developer.apple.com/documentation/metal/using_metal_to_draw_a_view_s_contents?language=objc)

It adds a few lines to make the buffer half-float and enable EDR, and has a control window to set the RGB values and `CGColorSpace`. After the first update, it also displays the `maximumExtendedDynamicRangeColorComponentValue`.

The purpose of the app was to investigate the behaviour of macOS colour management, by measuring the XYZ values of the patch with a colorimeter to ascertain the EOTF used in various display modes.