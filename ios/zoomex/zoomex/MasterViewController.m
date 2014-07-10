//
//  MasterViewController.m
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import "MasterViewController.h"

//#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)insertNewObject:(UIBarButtonItem*)sender
{
   
    
}

- (void)displayNewObject:(ZoomRexAgent*)bean
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSInteger position = _objects.count;
    //[_objects insertObject:bean* atIndex:position]; // or
    [_objects addObject:bean];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:position inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //agents = [[NSMutableArray alloc]init];

    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    //self.transactionsViewController = (TransactionTableViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.navigationItem.title = @"Universal Listings";
    
    //PFQuery *agentsQuery = [PFQuery queryWithClassName:@"Agent"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Broker"];
    [query whereKey:@"name" equalTo:@"Universal Listings"];
    //[query whereKey:@"agents" matchesQuery:agentsQuery];
    [query findObjectsInBackgroundWithBlock:^(NSArray *foundBrokers, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d brokers.", foundBrokers.count);
            // Do something with the found objects
            for (PFObject *broker in foundBrokers) {
                
                NSLog(@"agent id%@", broker.objectId);
                /*
            for (PFObject *agent in broker["@agents"]) {
                NSLog(@"agent id%@", agent.objectId);
                NSLog(@"agent name%@", agent["@firstName"]);

                //[employees addObject:object];
            }
                 */
                
                PFRelation *agentRelations = broker[@"agents"];
                [[agentRelations query] findObjectsInBackgroundWithBlock:^(NSArray *brokerAgents, NSError *error) {
                    if (error) {
                        // There was an error
                    } else {
                        for (PFObject *agent in brokerAgents) {
                        // objects has all the Posts the current user liked.
                            //NSLog(@"agent %@ %@", [agent objectForKey:@"firstName"], [agent objectForKey:@"lastName"]);
                            
                            ZoomRexAgent* currAgent =[[ZoomRexAgent alloc] init];
                            currAgent.objectId = agent.objectId;
                            currAgent.firstName = [agent objectForKey:@"firstName"];
                            currAgent.lastName = [agent objectForKey:@"lastName"];
                            currAgent.nickName = [agent objectForKey:@"nickName"];
                            //[_objects addObject:currAgent];
                            [self displayNewObject:currAgent];

                        }
                    }
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self.tableView reloadData];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return ((section == 0) ? _objects.count : 0);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if(indexPath.section == 0)
    {
    ZoomRexAgent *object = _objects[indexPath.row];
    cell.textLabel.text = [[[object firstName] stringByAppendingString:@" "] stringByAppendingString:[object lastName] ];
    } else if(indexPath.section == 1)
    {
        //ZoomRexAgent *object = _objects[indexPath.row];
        //cell.textLabel.text = [[[object firstName] stringByAppendingString:@" "] stringByAppendingString:[object lastName] ];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ZoomRexAgent *object = _objects[indexPath.row];
        self.transactionsViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:@"showTransactions"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ZoomRexAgent *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
        
        NSLog(@"agent %@ %@ %d selected.", [object firstName], [object lastName], _objects.count);

        
        TransactionTableViewController* txController = segue.destinationViewController;
        [txController setDetailItem:object];
    //}
}

@end
