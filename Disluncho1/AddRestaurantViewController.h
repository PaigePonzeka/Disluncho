//
//  AddRestaurantViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"


@interface AddRestaurantViewController : UIViewController <UITextFieldDelegate>{
	Disluncho1AppDelegate *root;
    IBOutlet UITextField *eatery_name;

}
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
