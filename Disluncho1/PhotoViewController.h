//
//  PhotoViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 5/3/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"

@interface PhotoViewController :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>  {
    UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
    Disluncho1AppDelegate *root;
    bool isImageSelected;
    UIImage *selectedImage;

}
@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;
@property (nonatomic, retain) Disluncho1AppDelegate *root;
@property (nonatomic, retain)  UIImage *selectedImage;

-(IBAction) getPhoto:(id) sender;
-(void) saveImageToFile;

@end
