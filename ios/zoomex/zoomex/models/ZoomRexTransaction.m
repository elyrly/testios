//
//  ZoomRexTransaction.m
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import "ZoomRexTransaction.h"

@implementation ZoomRexTransaction
@synthesize objectId;
@synthesize address1;
@synthesize address2;
@synthesize city;
@synthesize state;
@synthesize zip;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
@end
