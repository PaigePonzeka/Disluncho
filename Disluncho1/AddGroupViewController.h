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
#import "PhotoViewController.h"

@interface AddGroupViewController : UITableViewController <UITextFieldDelegate>{
    IBOutlet UITextField *add_group_name;
    NSMutableArray *groupMembersArray;
    UIButton *add_photo;
	NSString *photo_path;
	Disluncho1AppDelegate *root;
	int MEMBERUNID;
	int MEMBERNAME;
	int GROUPUNID;
	int GROUPNAME;
    bool hasSetPicture;
    

}
@property (nonatomic, retain) Disluncho1AppDelegate *root;
@property (nonatomic, retain) UIButton *add_photo;
@property (nonatomic, retain) NSMutableArray *groupMembersArray;
@property (nonatomic, retain) NSString *photo_path;
@property (nonatomic, assign) bool hasSetPicture;
@end
