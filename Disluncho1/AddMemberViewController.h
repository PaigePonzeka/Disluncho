//
//  AddMemberViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/28/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"
#import "PhotoViewController.h"
@interface AddMemberViewController : UIViewController {
    IBOutlet UITextField *member_email;
	Disluncho1AppDelegate *root;
}
- (void) sendEmailTo:(NSString *)to;
-(IBAction) setPhoto:(id) sender;
@end
