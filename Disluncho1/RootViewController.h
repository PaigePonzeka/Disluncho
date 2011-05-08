//
//  RootViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupsViewController.h"
#import "Disluncho1AppDelegate.h"
#import "PhotoViewController.h"

@interface RootViewController : UIViewController {
	Disluncho1AppDelegate *root;
	int USERUNID;
    IBOutlet UITextField *login_name;
}
@property (nonatomic, retain) Disluncho1AppDelegate *root;
-(IBAction) setPhoto:(id) sender;

//@property (nonatomic, retain) IBOutlet UITextField *login_name;
@end
