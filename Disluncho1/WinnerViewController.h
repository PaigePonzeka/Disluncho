//
//  WinnerViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupsViewController.h"
#import "Disluncho1AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface WinnerViewController : UITableViewController {
    NSMutableArray *nominees;
    NSMutableArray *waitingForVotes;
	Disluncho1AppDelegate *root;
	
	int PLACEUNID;
	int PLACENAME;
	int PLACEVOTES;

    BOOL waiting_for_votes;
}
@property (nonatomic, retain) NSMutableArray *nominees;
@property (nonatomic, retain) NSMutableArray *waitingForVotes;

@property (nonatomic, retain) Disluncho1AppDelegate *root;
-(void)checkForVotingDone;

@end
