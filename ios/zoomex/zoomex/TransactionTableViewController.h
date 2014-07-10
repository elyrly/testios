//
//  TransactionTableViewController.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>
#import "ZoomRexAgent.h"
#import "ZoomRexTransaction.h"

@interface TransactionTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *listingTransactions;
    NSMutableArray *sellingTransactions;
}

@property (strong, nonatomic) ZoomRexAgent* detailItem;
@property (strong, nonatomic) NSMutableArray* listingTransactions;
@property (strong, nonatomic) NSMutableArray* sellingTransactions;
@end
