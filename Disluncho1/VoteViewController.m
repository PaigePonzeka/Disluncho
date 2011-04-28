//
//  VoteViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "VoteViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation VoteViewController
@synthesize nomineesArray;
//@synthesize votes;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    maxTotalVotes = 5;
    userTotalVotes = maxTotalVotes; //intialze the players spending points
    votes=0;
    wait_for_nominations = YES;
    if(!wait_for_nominations) //if everyone is done nominating
    {
        
        //show the regular vote screen (set based on total number of votes available to the user)
        //NSString *title =[NSString stringWithFormat:@"Award %i Points",userTotalVotes];
        //self.title =title;
        self.setNavTitle;
        
        //intialize the nominees list
        //intialize the nomineesArray (the array of resturants nominated in the current vote)
        nomineesArray = [[NSMutableArray alloc] init];
        [nomineesArray addObject:@"Chipotle"];
        [nomineesArray addObject:@"Qdoba"];
        [nomineesArray retain];

        //remove the back button
        self.navigationItem.hidesBackButton = YES;
        
        //add the done button
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishVoteGroup:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        [doneButton release];
        
    }
    else //someone still hasnt nominated (or skipped) 
    {
        NSLog(@"Waiting for Nominations");
        //show the "waiting" screen
        self.title = @"Waiting on ..."; 
        delayedUsersArray = [[NSMutableArray alloc] init];
        [delayedUsersArray addObject:@"Jack Cheng"];
        [delayedUsersArray addObject:@"Mike Potter"];
        [delayedUsersArray addObject:@"Jason Roos"];
        [delayedUsersArray retain];
        
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
-(void) finishVoteGroup:(UIBarButtonItem*)button {
    NSLog(@"Vote Finished");
    
    //save the results of the current table
    
    //navigate to the winnerViewController to see the results
    WinnerViewController *winnerview = [[WinnerViewController alloc] initWithNibName:@"WinnerViewController" bundle:nil];
    [self.navigationController pushViewController:winnerview animated:YES];

    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if(!wait_for_nominations) //everyone has nominated a location
    {
        return [nomineesArray count];
    }
    else //we are still waiting for some nominees
    {   
        return [delayedUsersArray count];
    }
}
/* set the height of the rows */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    //disable selection view for this cell
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(!wait_for_nominations) //everyone has nominated a location
    {
        // Configure the cell...
        [cell.textLabel setText:[nomineesArray objectAtIndex:indexPath.row]];
        
        
       
        // add Subtitle (Last visit to the resturant)
        cell.detailTextLabel.text=@"Last visit 2 days ago";
        cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
        
        // Add Destination Image Icon
        UIImage* theImage = [UIImage imageNamed:@"default_restuarant.png"];
        cell.imageView.image = theImage;
        
        //create custom Accessory View
        UIView *voteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 55)];
        
        if(votes!=0) //Only show the label if the eatery has any votes
        {
            //create num of votes label
            UILabel *voteCount;
            voteCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
            NSString *vote = [NSString stringWithFormat:@"%i",votes];
            voteCount.text = vote;
            voteCount.textAlignment =UITextAlignmentCenter;
            voteCount.backgroundColor = [UIColor grayColor];
            voteCount.textColor =[UIColor whiteColor];
            voteCount.font=[UIFont fontWithName:@"Helvetica Bold" size:12];
            voteCount.layer.cornerRadius= 4;
            [voteView addSubview:voteCount];
        }

        
        //create custom upVote button
        UIButton *upVote = [UIButton buttonWithType:UIButtonTypeCustom];
        [upVote addTarget:self action:@selector(votedUp:) forControlEvents:UIControlEventTouchUpInside];
        upVote.frame = CGRectMake(35, 10, 30, 30);
        UIImage *addImage = [UIImage imageNamed:@"default_add.png"]; 
        [upVote setImage:addImage forState:UIControlStateNormal];
        //if the user has not votes left - disable the add buttom
        if(userTotalVotes <= 0)
        {
            upVote.enabled = NO;
            
        }
        else
        {
            upVote.enabled = YES;
        }
        
        //create custom downVote button
        UIButton *downVote = [UIButton buttonWithType:UIButtonTypeCustom];
        [downVote addTarget:self action:@selector(votedDown:) forControlEvents:UIControlEventTouchUpInside];
        downVote.frame = CGRectMake(65, 10, 30, 30);
        UIImage *downImage = [UIImage imageNamed:@"default_remove.png"]; 
        [downVote setImage:downImage forState:UIControlStateNormal];
        if(userTotalVotes == maxTotalVotes)
        {
            downVote.enabled = NO;
        }
        else
        {
            downVote.enabled = YES;
        }

        
        // add all to a view
        
        [voteView addSubview:upVote];
        [voteView addSubview:downVote];
        
        //add the voteView to the cell
            cell.accessoryView = voteView;
        [voteView release];
    }
    else //still waiting for some nominations set the user's we're waiting for
    {
        // Configure the cell...
        [cell.textLabel setText:[delayedUsersArray objectAtIndex:indexPath.row]];
        
        //get the users icon and set that to the image view
        // Add Destination Image Icon
        UIImage* userIcon = [UIImage imageNamed:@"default_restuarant.png"];
        cell.imageView.image = userIcon;

        //add the loading image to the accessory view
        UIActivityIndicatorView *waitingIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        waitingIndicator.frame = CGRectMake(0.0, 0.0, 20, 20);
        waitingIndicator.center = self.view.center;
        [waitingIndicator startAnimating];
        cell.accessoryView= waitingIndicator;
   
    }
    return cell;
}
-(NSString *) VoteChanged
{
    votes+=1;
    int voted=(votes);
    NSString *string = [NSString stringWithFormat:@"%i",voted];
    return string;
}
/*event called for the add vote button*/
-(void) votedUp: (id)sender
{
       //get the indexPath of the currently selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
   // UITableViewCell *selectedCell = [self tableView:tableview cellForRowAtIndexPath:indexPath];
  //  UITableViewCell *cell = (UITableViewCell *)[(UITableView *)self.view cellForRowAtIndexPath:indexPath];

    //its index will be  indexPath.row
    NSLog(@"You Added a Vote to Row: %d", indexPath.row);
    /*
     Put in the code to increase the votes for the eatery
     */
    votes++;
    userTotalVotes --; //remove the users vote
    self.setNavTitle;
    
    //reload the table data
    [self.tableView reloadData];
    
}
/*event called for the remove Vote button*/
-(void) votedDown: (id)sender
{
    //get the indexPath of the currently selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    
    //its index will be indexPath.row
    NSLog(@"You Removed a Vote from Row: %d", indexPath.row);
    
    /*
     put in the code to reduce the votes for the eatery
     */
    votes --;
    userTotalVotes ++; //increase the users vote

    self.setNavTitle;
    //reload the table data
    [self.tableView reloadData];
}
/*sets the string for the navigationbar title based on the current users points */
-(void) setNavTitle
{
    NSString *title;
    if(userTotalVotes==1) //if 1 vote left used point
    {
        title =[NSString stringWithFormat:@"Award %i Point",userTotalVotes];
    }
    else if(userTotalVotes<=0)
    {
        title =@"No Votes Left :-(";
    }
    else
    {
        title =[NSString stringWithFormat:@"Award %i Points",userTotalVotes];
    }
   
    //set the title
    self.title=title;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Just Selected %d", indexPath.row);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
