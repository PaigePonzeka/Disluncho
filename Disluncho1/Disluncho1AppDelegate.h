//
//  Disluncho1AppDelegate.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Disluncho1AppDelegate : NSObject <UIApplicationDelegate> {

	//local storage of signin information
	int UserUNID;
	int GroupUNID;
	int RoundUNID;
	bool DATABASE_VERBOSE;
    
    int image_type; //used to determine if images are for users, groups or places
    //1 - groups
    //2 - places
    //3 - users
    
    NSString *imageFileString;
    NSMutableData *receivedData;
    NSURLConnection *connection;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,assign) bool DATABASE_VERBOSE;
@property (nonatomic,assign) int UserUNID;
@property (nonatomic,assign) int GroupUNID;
@property (nonatomic,assign) int RoundUNID;
@property (nonatomic,assign) int image_type;

@property (nonatomic,retain) NSString *imageFileString; 
@property (nonatomic,retain) NSMutableData *receivedData; 
@property (nonatomic,retain) NSURLConnection *connection;


-(NSMutableArray *) sendAndRetrieve:(NSString *)parameters;
-(void) send:(NSString *)parameters;
-(void) printResults:(NSMutableArray *)results;
- (UIImage*)loadImage:(NSString*)imgName; 
-(void) downloadFile: (NSString*) filename : (NSString*) folder;

@end
