//
//  PhotoViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 5/3/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoViewController :  UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>  {
    UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
}
@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;

-(IBAction) getPhoto:(id) sender;

@end
