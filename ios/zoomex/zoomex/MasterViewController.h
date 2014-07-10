//
//  MasterViewController.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TransactionTableViewController.h"
#import "ZoomRexAgent.h"
#import "ZoomRexTransaction.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    // NSMutableArray *agents; // theres already a _objects variable
}

@property (strong, nonatomic) TransactionTableViewController *transactionsViewController;


@end
