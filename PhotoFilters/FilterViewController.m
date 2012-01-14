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
@synthesize amount;
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

    
     
    CIFilter* filter = [CIFilter filterWithName:@"CIColorControls"];
    //CIFilter* satFilter = [CIFilter filterWithName:@""];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"imagen.png"]];
    
//    self.view.layer.filters = [NSArray arrayWithObject:filter];
    
    
    [filter setValue:inputImage forKey:@"inputImage"];
    
    [filter setValue:[NSNumber numberWithFloat:1.5] forKey:@"inputContrast"];
    [filter setValue:[NSNumber numberWithFloat:0.3] forKey:@"inputSaturation"];
    
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
    [self setAmount:nil];
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

- (IBAction)applyFilter:(UIButton *)sender {
    CIContext *context = [CIContext contextWithOptions:nil];

    CIFilter* filter;
    
    if([sender.titleLabel.text isEqualToString:@"Contrast"]){
        
       filter = [CIFilter filterWithName:@"CIColorControls"];
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"imagen.png"]];

        [filter setValue:inputImage forKey:@"inputImage"];
        
        [filter setValue:[NSNumber numberWithFloat:amount.value] forKey:@"inputContrast"];
        
        [amount setMaximumValue:4.0];
      

    }else if([sender.titleLabel.text isEqualToString:@"Saturation"]){
        
        filter = [CIFilter filterWithName:@"CIColorControls"];
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"imagen.png"]];
        
        [filter setValue:inputImage forKey:@"inputImage"];
        
        [filter setValue:[NSNumber numberWithFloat:amount.value] forKey:@"inputSaturation"];
        
        [amount setMaximumValue:1.0];

    }
    
    
      self.photoView.image = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    
}
- (IBAction)sliderChanged:(id)sender {
}
@end
