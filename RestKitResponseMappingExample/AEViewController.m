//
//  AEViewController.m
//  RestKitResponseMappingExample
//
//  Created by Alexander G Edge on 08/01/2013.
//  Copyright (c) 2013 Alexander G Edge. All rights reserved.
//

#import "AEViewController.h"
#import "AEUser.h"

@interface AEViewController ()

@end

@implementation AEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   [[RKObjectManager sharedManager] postObject:nil path:@"/login" parameters:@{@"user" : @"username", @"pass" : @"pass"} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        AEUser *user = [mappingResult firstObject];
        
        NSLog(@"User: %@", user);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    [[RKObjectManager sharedManager] postObject:nil path:@"/error" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"%@",mappingResult);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
