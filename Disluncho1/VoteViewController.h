//
//  VoteViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinnerViewController.h"

@interface VoteViewController : UITableViewController {
     NSMutableArray *nomineesArray;
}
@property (nonatomic, retain) NSMutableArray *nomineesArray;

@end
