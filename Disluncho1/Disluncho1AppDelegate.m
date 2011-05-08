//
//  Disluncho1AppDelegate.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "Disluncho1AppDelegate.h"

@implementation Disluncho1AppDelegate


@synthesize window=_window;

@synthesize navigationController=_navigationController;

@synthesize UserUNID;
@synthesize GroupUNID;
@synthesize RoundUNID;
@synthesize UserPhoto;
@synthesize DATABASE_VERBOSE;
@synthesize image_type, imageFileString;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//testing purposes ONLY
	UserUNID = 3;
	
	//will print out each database call and results
	DATABASE_VERBOSE = TRUE;
	
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

/*
 *will return 2D array of results[row,field] 
 *must send parameters as (@"action=____&otherParamName=___& ...")
 *all queries are therefore created and stored in the php file and called by their action= parameter
 *
 */
-(NSMutableArray *) sendAndRetrieve:(NSString *)parameters
{
	//set up urlRequest
	NSData *parametersData = [parameters dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] 
										initWithURL:[NSURL URLWithString:@"http://ponzeka.com/iphone_disluncho/disluncho_test.php"]]
									   autorelease];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:parametersData];
	
	//variables to store retrieved data
	NSData *urlData; 
	NSURLResponse *response; 
	NSError *error;
	
	//connect to url and get response
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; 
	
	//check for errors
	if(!urlData) {
		NSLog(@"Connection Failed!");
		NSMutableArray *returnValues = [NSMutableArray arrayWithCapacity:0];
		return returnValues;
	}
	//turn response into String stripped of \n characters
	NSString *urlString = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] 
						   stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]; 
	
	//make string into 2D array [rows, fields]
    NSMutableArray *returnValues = [[[NSMutableArray alloc] initWithCapacity:100]autorelease];
	
	
	[returnValues setArray:[urlString componentsSeparatedByString:@"|"]];
	for(int row=0; row< [returnValues count]; row++){
		[returnValues replaceObjectAtIndex:row withObject:
		 [[returnValues objectAtIndex:row] componentsSeparatedByString:@","]];
	}
	
	//Array of size [1,1] will be "" if there was no results, remove blank object for logic
	NSString* string = [NSString stringWithString:[[returnValues objectAtIndex:0]objectAtIndex:0]];
	if (NSOrderedSame == [string compare:@""]){
		[returnValues removeLastObject];
		if(DATABASE_VERBOSE)NSLog(@"return arry of size [0,0] - NO RESULTS");
	}
	else{
		//print out return string size, row and fields
		if(DATABASE_VERBOSE)[self printResults:returnValues];
	}
	
	return returnValues;

}
/*
 *
 *
 */
-(void) send:(NSString *)parameters
{
	//set up urlRequest
	NSData *parametersData = [parameters dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] 
										initWithURL:[NSURL URLWithString:@"http://ponzeka.com/iphone_disluncho/disluncho_test.php"]]
									   autorelease];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:parametersData];
	
	//variables to store retrieved data
	NSData *urlData; 
	NSURLResponse *response; 
	NSError *error;
	
	//connect to url and get response
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; 
	
	//check for errors
	if(!urlData) {
		NSLog(@"Connection Failed!");

	}
	//turn response into String stripped of \n characters
	NSString *urlString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]; 
	if(DATABASE_VERBOSE)NSLog(@"\n\t%@",urlString);
    [urlString release];

}

/*
 *	prints out the result array to Log 
 */
-(void)printResults:(NSMutableArray*)results{
	NSLog(@"returned array of size = [ %i , %i ]\n",[results count], [[results objectAtIndex:0]count]);
	for(int j = 0; j<[results count]; j++){
		NSString* fields = [NSString  stringWithString:@""];
		for(int k = 0; k<[[results objectAtIndex:0]count]; k++){
			fields = [fields stringByAppendingString:[@"[" stringByAppendingString:
													  [[[results objectAtIndex:j]objectAtIndex:k] 
													   stringByAppendingString:@"]"]]];
		}
		NSLog(@"[row #%i]- %@ ",j,fields);
	}
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
