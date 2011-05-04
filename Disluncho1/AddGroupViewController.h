//
//  AddGroupViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"
#import "AddMemberViewController.h"

@interface AddGroupViewController : UITableViewController <UITextFieldDelegate>{
    IBOutlet UITextField *add_group_name;
    
    NSMutableArray *groupMembersArray;

	Disluncho1AppDelegate *root;

}
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
