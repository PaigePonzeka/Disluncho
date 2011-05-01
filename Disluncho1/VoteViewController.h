//
//  VoteViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinnerViewController.h"
#import "Disluncho1AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface VoteViewController : UITableViewController {
	Disluncho1AppDelegate *root;

    NSMutableArray *nomineesArray;
    NSMutableArray *delayedUsersArray;

    int votes; //temporary value for votes 
    int userTotalVotes; //total votes user has left to spend
    int maxTotalVotes; //total votes user can spend
    BOOL wait_for_nominations; //if the vote is still waiting on users
}
@property (nonatomic, retain) NSMutableArray *nomineesArray;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

//@property (nonatomic, retain) int votes;
-(NSString *) VoteChanged;
-(void) setNavTitle;
@end
