//
//  AddRestaurantViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "AddRestaurantViewController.h"


@implementation AddRestaurantViewController
@synthesize root;
@synthesize place;
@synthesize photo_path, hasSetPicture, add_photo;


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
/* makes keyboard disappear on enter */
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	[theTextField resignFirstResponder];
	return TRUE;
}

#pragma mark - View lifecycle
/*Called when user selected option to add a Photo to a newly created eatery*/
-(IBAction) setPhoto:(id) sender
{
    NSLog(@"Changing to Add Photo Screen");
    hasSetPicture = true;
    //set the appdelegate global varable to determine if the photo is for users, places or groups
    root.image_type = 2; 
    //switch to the add photo screen
    PhotoViewController *photoAdder = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    [self.navigationController pushViewController:photoAdder animated:YES];
    [photoAdder release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;
	
    self.title = @"Add Restaurant";    //display an add button for this view controller

	//add place
	NSString *addPlaceParams = [NSString stringWithFormat:@"action=ADD_PLACE&name=%@",eatery_name.text];
	NSMutableArray *addPlace;
	addPlace = [root sendAndRetrieve:addPlaceParams];
	
	self.place = [[[addPlace objectAtIndex:0] objectAtIndex:0] intValue];
	
	
	
    eatery_name.borderStyle = UITextBorderStyleRoundedRect;
	eatery_name.placeholder = @"Name";
	[eatery_name setDelegate:self];
	
	//set 
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithRestuarant)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
	
	//hide the backbutton
    self.navigationItem.hidesBackButton = YES;
    
    //add cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddPlace)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)doneWithRestuarant
{
	//search to see if this place exists in the database (possible similar finds screen/options)
	if((eatery_name.text == NULL)||([eatery_name.text isEqualToString:@""])){eatery_name.text = @"Unnamed Restuarant";}
	NSString *similarPlacesParams = [NSString stringWithFormat:@"action=GET_LIKE_PLACE&name=%@",eatery_name.text];
	NSMutableArray *similarPlaces;
	similarPlaces = [root sendAndRetrieve:similarPlacesParams];
	
	if([similarPlaces count]!=0)
	{
		NSLog(@"there is a similar restuarant already in the database: %@ <-- use that",[[similarPlaces objectAtIndex:0] objectAtIndex:1]);
		
		//delete the place
		NSString *deletePlaceParams = [NSString stringWithFormat:@"action=DELETE_PLACE&place=%i",[self place]];
		[root send:deletePlaceParams];
		
		//reset place to the other place
		self.place = [[[similarPlaces objectAtIndex:0] objectAtIndex:0]intValue];
	}
	else{
		//update unique place to the database
		NSString *addPlaceParams = [NSString stringWithFormat:@"action=UPDATE_PLACE&name=%@&place=%i",eatery_name.text,[self place]];
		[root send:addPlaceParams];
	}
	//user who added the place nominates it for this round 
	NSString *nominateParams = [NSString stringWithFormat:@"action=ADD_NOMINATION&user=%i&round=%i&place=%i",
								[root UserUNID],[root RoundUNID],[self place]];
	[root send:nominateParams];
	
	//pop this view off the screen (back to the previous view)
	[self.navigationController popViewControllerAnimated:YES];

}
-(void)cancelAddPlace{
	//delete the place
	NSString *deletePlaceParams = [NSString stringWithFormat:@"action=DELETE_PLACE&place=%i",[self place]];
	[root send:deletePlaceParams];
	
    //pop this view off the screen (back to the previous view)
    [self.navigationController popViewControllerAnimated:YES];

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
	if([root imageFileString]!=NULL){
        add_photo.hidden = YES;
        //add the image view to that position instead
        //remove .png from the file 
        NSString *withoutPNG = [root.imageFileString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame: CGRectMake(15, 15, 75, 75)];
        UIImage *myUIImage = [root loadImage: withoutPNG];
        userImageView.image = myUIImage;
        [self.view addSubview:userImageView];
    
    	/***  self photo_path will be the path of the groups photo  **/
	//if photo updates were done then update the photo
		NSString *photoUpdateParams = [NSString stringWithFormat:@"action=UPDATE_PHOTO&photo=%@&place=%i",[root imageFileString],[self place]];
		[self setPhoto_path:[root imageFileString]];
		[root setImageFileString:NULL];
		[root send:photoUpdateParams];
	}
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
