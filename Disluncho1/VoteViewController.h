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
    int votes; //temporary value for votes 
    int userTotalVotes; //total votes user has left to spend
    int maxTotalVotes; //total votes user can spend
}
@property (nonatomic, retain) NSMutableArray *nomineesArray;
//@property (nonatomic, retain) int votes;
-(NSString *) VoteChanged;
-(void) setNavTitle;
@end
