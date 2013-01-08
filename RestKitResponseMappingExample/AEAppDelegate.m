//
//  AEAppDelegate.m
//  RestKitResponseMappingExample
//
//  Created by Alexander G Edge on 08/01/2013.
//  Copyright (c) 2013 Alexander G Edge. All rights reserved.
//

#import "AEAppDelegate.h"
#import "AEUser.h"

@implementation AEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    [self setUpObjectMapping];
    
    return YES;
}

- (void)setUpObjectMapping{
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://127.0.0.1:4567"]];
    
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"errorMessage"]];
    
    // Check what status code is returned for an error - some use 200 with a code in the body, in which case you will need to change this
    
    RKResponseDescriptor *errorDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                    pathPattern:nil
                                                                                        keyPath:@"data.message"
                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    
    [manager addResponseDescriptorsFromArray:@[errorDescriptor]];
    
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[AEUser class]];
    
    [userMapping addAttributeMappingsFromDictionary:@{
     @"cu_id" : @"userId",
     @"cu_first_name":@"firstName",
     @"cu_last_name":@"lastName",
     }];
    
    
    // Register our mappings with the provider
    
    [manager addResponseDescriptorsFromArray:@[
     
     [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                             pathPattern:nil
                                                 keyPath:@"data.user"
                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]
     ]];
    
    
    [RKObjectManager sharedManager].requestSerializationMIMEType = RKMIMETypeJSON;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
