//
//  ZoomRexTransaction.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ZoomRexAgent.h"

@interface ZoomRexTransaction : NSObject {
    NSString* objectId;
    NSString* address1;
    NSString* address2;
    NSString* city;
    NSString* state;
    NSString* zip;
    NSString* mlsId;
    //ZoomRexAgent* listingAgent;
    //ZoomRexAgent* sellingAgent;
    
}

@property (strong, nonatomic) NSString* objectId;
@property (strong, nonatomic) NSString* address1;
@property (strong, nonatomic) NSString* address2;
@property (strong, nonatomic) NSString* city;

@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* zip;
@property (strong, nonatomic) NSString* mlsId;
//@property (strong, nonatomic) ZoomRexAgent* listingAgent;
//@property (strong, nonatomic) ZoomRexAgent* sellingAgent;

@end
