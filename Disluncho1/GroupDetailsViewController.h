//
//  GroupDetailsViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupDetailsViewController : UITableViewController {
     NSMutableArray *groupMembersArray;
}
@property (nonatomic, retain) NSMutableArray *groupMembersArray;
@end
