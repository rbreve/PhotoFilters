//
//  FilterViewController.h
//  PhotoFilters
//
//  Created by Roberto Breve on 12/28/11.
//  Copyright (c) 2011 Icoms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)applyFilter:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *amount;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)applyVignette:(id)sender;
- (IBAction)loadPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pickPhoto;

@end
