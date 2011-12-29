//
//  FilterViewController.m
//  PhotoFilters
//
//  Created by Roberto Breve on 12/28/11.
//  Copyright (c) 2011 Icoms. All rights reserved.
//

#import "FilterViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FilterViewController
@synthesize photoView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //CIColorInvert just works
    
    CIFilter* filter = [CIFilter filterWithName:@"CIColorControls"];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"imagen.png"]];
    
//    self.view.layer.filters = [NSArray arrayWithObject:filter];
    
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:1.5] forKey:@"inputContrast"];
   // [filter setValue:[NSNumber numberWithFloat:5] forKey:@"inputRadius"];

    
    
    CIContext *context = [CIContext contextWithOptions:nil];

    if(filter.outputImage){
        NSLog(@"si");
    }
    
    self.photoView.image = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    
 }

- (void)viewDidUnload
{
    [self setPhotoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
