//
//  GroupDetailsViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Disluncho1AppDelegate.h"
#import "AddMemberViewController.h"


@interface GroupDetailsViewController : UITableViewController {
	NSMutableArray *groupMembers;
	NSMutableArray *group;
	int MEMBERUNID;
	int MEMBERNAME;
	int GROUPNAME;
	int GROUPPHOTO;
	Disluncho1AppDelegate *root;
	IBOutlet UITextField *group_name;

}
@property (nonatomic, retain) NSMutableArray *groupMembers;
@property (nonatomic, retain) NSMutableArray *group;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
