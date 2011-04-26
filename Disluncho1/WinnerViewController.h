//
//  WinnerViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupsViewController.h"

@interface WinnerViewController : UITableViewController {
    NSMutableArray *nomineesArray;
}
@property (nonatomic, retain) NSMutableArray *nomineesArray;

@end
