//
//  AddRestaurantViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"
#import "PhotoViewController.h"


@interface AddRestaurantViewController : UIViewController <UITextFieldDelegate>{
	Disluncho1AppDelegate *root;
    IBOutlet UITextField *eatery_name;
	NSString *photo_path;
	int place;

}
@property (nonatomic, retain) Disluncho1AppDelegate *root;
@property (nonatomic, retain) NSString *photo_path;
@property int place;
-(IBAction) setPhoto:(id) sender;

@end
