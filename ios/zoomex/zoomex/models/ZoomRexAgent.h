//
//  ZoomRexAgent.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomRexTransaction.h"

@interface ZoomRexAgent : NSObject {
    NSString* objectId;
    NSString* firstName;
    NSString* lastName;
    
    NSString* nickName;
    ZoomRexTransaction* listingTransactions;
    ZoomRexTransaction* sellingTransactions;


}

@property (strong, nonatomic) NSString* objectId;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* nickName;
@property (strong, nonatomic) ZoomRexTransaction* listingTransactions;
@property (strong, nonatomic) ZoomRexTransaction* sellingTransactions;


@end
