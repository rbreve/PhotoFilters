//
//  FilterViewController.m
//  PhotoFilters
//
//  Created by Roberto Breve on 12/28/11.
//  Copyright (c) 2011 Icoms. All rights reserved.
//

#import "FilterViewController.h"
#import "UIImage+Crop.h"
#import <QuartzCore/QuartzCore.h>

@interface FilterViewController()
@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) UIImage *originalImage;
@end

@implementation FilterViewController
@synthesize pickPhoto;
@synthesize amount;
@synthesize photoView;
@synthesize popController = _popController;
@synthesize originalImage = _originalImage;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _originalImage = [self.photoView.image copy];
    
 }

- (void)viewDidUnload
{
    [self setPhotoView:nil];
    [self setAmount:nil];
    [self setPickPhoto:nil];
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
    
    photoView.image = [_originalImage copy];
    
    CIFilter* filter;
    
    if([sender.titleLabel.text isEqualToString:@"Contrast"]){
        
        filter = [CIFilter filterWithName:@"CIColorControls"];
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"imagen.png"]];

        [filter setValue:inputImage forKey:@"inputImage"];
        
        [filter setValue:[NSNumber numberWithFloat:amount.value] forKey:@"inputContrast"];
        
        [amount setMaximumValue:4.0];
      

    }else if([sender.titleLabel.text isEqualToString:@"Saturation"]){
        
        filter = [CIFilter filterWithName:@"CIColorControls"];
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:self.photoView.image];
        
        [filter setValue:inputImage forKey:@"inputImage"];
        
        [filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputSaturation"];
        

    }
    
    
      [self.photoView setImage:[UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]]];
    
}
- (IBAction)sliderChanged:(id)sender {
}

- (void) doFilter:(NSString *) filterName{
    
    UIGraphicsBeginImageContext(self.photoView.image.size);  

    UIImage *layerImage;
    UIImage *photo = self.photoView.image;
    CGBlendMode blendMode;
    CGFloat alpha; 
    
    CGRect rect = CGRectMake(0, 0, 600, 600);

    if([filterName isEqualToString:@"blue"]){
        alpha = 0.7;
        blendMode = kCGBlendModeOverlay;
        layerImage = [UIImage imageNamed:@"blue.png"];
    }
    
    if ([filterName isEqualToString:@"vignette"]){
        alpha = 0.7;
        blendMode = kCGBlendModeHardLight;
        layerImage = [UIImage imageNamed:@"vignette.png"];
    }
    
    if ([filterName isEqualToString:@"vignettewhite"]){
        alpha = 0.7;
        blendMode = kCGBlendModeSoftLight;
        layerImage = [UIImage imageNamed:@"vignette3.png"];
    }
    
    if([filterName isEqualToString:@"vintage60"]){
        alpha = 0.7;
        blendMode =kCGBlendModeLighten;
        layerImage = [UIImage imageNamed:@"yellowbrown.png"];
    }
    
    if([filterName isEqualToString:@"oldpaper"]){
        alpha = 0.7;
        blendMode = kCGBlendModeMultiply;
        layerImage = [UIImage imageNamed:@"old-paper.jpg"];
    }
    
    if([filterName isEqualToString:@"stars"]){
        alpha = 0.8;
        blendMode =kCGBlendModeOverlay;
        layerImage = [UIImage imageNamed:@"stars.png"];
    }
    
    if([filterName isEqualToString:@"vivid"]){
        alpha = 0.7;
        blendMode =kCGBlendModeOverlay;
        layerImage = [UIImage imageNamed:@"black.png"];
    }
    
    if([filterName isEqualToString:@"saturation"]){
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIFilter* filter;

        filter = [CIFilter filterWithName:@"CIColorControls"];
        
        CIImage *inputImage = [[CIImage alloc] initWithImage:self.photoView.image];
        
        [filter setValue:inputImage forKey:@"inputImage"];
        
        [filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputSaturation"];
        
        [self.photoView setImage:[UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]]];
        return;
    }
    
    [photo drawInRect:rect];
    [layerImage drawInRect:rect blendMode:blendMode alpha:alpha];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();  
    
    UIGraphicsEndImageContext();  
    
    [self.photoView setImage:resultingImage];
}

- (IBAction)applyVignette:(UIButton *)sender {
      
    [self.photoView setImage:_originalImage];
    
   
    if([sender.titleLabel.text isEqualToString:@"Vintage"]){
        [self doFilter:@"oldpaper"];
    }
    
    if([sender.titleLabel.text isEqualToString:@"Lomo1"]){
        [self doFilter:@"vintage60"];
        [self doFilter:@"vignette"];
        
    }
    
    if([sender.titleLabel.text isEqualToString:@"Lomo2"]){
        
        [self doFilter:@"stars"];
        [self doFilter:@"vignette"];

    }
    
    
    if([sender.titleLabel.text isEqualToString:@"Vignette"]){
        [self doFilter:@"saturation"];
        [self doFilter:@"vignette"];


    }
    
 }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagePhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.photoView setImage:imagePhoto];
    self.photoView.frame = CGRectMake(84, 45, 600, 600);
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    
    imagePhoto = [imagePhoto imageByScalingAndCroppingForSize:CGSizeMake(600, 600)];
    _originalImage = imagePhoto;
}
- (IBAction)loadPhoto:(id)sender {
    
    if (![_popController isPopoverVisible]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        if (_popController == nil) {
            _popController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        }
    }   
    
    [_popController presentPopoverFromBarButtonItem:pickPhoto permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];


}
@end
