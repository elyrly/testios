//
//  TransactionTableViewController.m
//  zoomex
//
//  Created by Charlie Federspiel on 6/21/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import "TransactionTableViewController.h"

@interface TransactionTableViewController ()


@end

@implementation TransactionTableViewController
@synthesize detailItem;
@synthesize listingTransactions;
@synthesize sellingTransactions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    listingTransactions = [[NSMutableArray alloc] initWithCapacity:10];
    sellingTransactions = [[NSMutableArray alloc] initWithCapacity:10];
    return self;
}

- (void)insertNewObject:(ZoomRexTransaction*)sender
{
    
}

-(void) loadTransactionsByAgent:(NSString *)agentType agentCriterion:(PFObject*) agent populateTxArray:(NSMutableArray*) loadedTransactions populateTests:(BOOL)tests {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Transaction"];
    // use the reconstructed Agent PFObject in a relational query:
    [query whereKey:agentType equalTo:agent];
    //[query whereKey:@"agents" matchesQuery:agentsQuery];
    [query findObjectsInBackgroundWithBlock:^(NSArray *foundListingTransactions, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d %@ transactions.", foundListingTransactions.count, agentType);
            // Do something with the found objects
            for (PFObject *listingTx in foundListingTransactions) {
                ZoomRexTransaction* currentTransaction =[[ZoomRexTransaction alloc] init];
                currentTransaction.objectId = agent.objectId;
                currentTransaction.address1 = [listingTx objectForKey:@"address1"];
                currentTransaction.address2 = [listingTx objectForKey:@"address2"];
                currentTransaction.city = [listingTx objectForKey:@"city"];
                currentTransaction.state = [listingTx objectForKey:@"state"];
                currentTransaction.zip = [listingTx objectForKey:@"zip"];
                
                //docs
                
                //listingAgent
                
                //sellingAgent
                
                [loadedTransactions addObject:currentTransaction];
                
                NSLog(@"Successfully loaded %d %@", loadedTransactions.count, currentTransaction.address1);
                /*
                NSInteger position = listingTransactions.count;
                //[_objects insertObject:bean* atIndex:position]; // or
                //[_objects addObject:bean];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:position inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                */
            }
            
            if(foundListingTransactions.count > 0) {
                NSLog(@"reloading view");
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [self.tableView reloadData];
                });
            } else if(tests) {
                PFObject *testTransaction = [PFObject objectWithClassName:@"Transaction"];
                testTransaction[@"address1"] = @"101 Post St";
                testTransaction[@"city"] = @"San Franscisco";
                testTransaction[@"state"] = @"CA";
                testTransaction[@"zip"] = @"94108";
                testTransaction[@"MlsId"] = @"1234565";
                
                /*
                 PFUser *user = [PFUser currentUser];
                 PFRelation *relation = [user relationForKey:@"likes"];
                 [relation addObject:post];
                 [user saveInBackground];
                 */
                
                NSMutableArray* documents = [[NSMutableArray alloc] initWithCapacity:10];
                
                // Create the revisions and docs
                //AD
                PFObject *adRevision = [PFObject objectWithClassName:@"DocumentRevision"];
                adRevision[@"url"] = @"/test/1/2/3/adi.pdf";
                adRevision[@"version"] = @1;
                adRevision[@"format"] = @"pdf";
                adRevision[@"uploadedBy"] = @"Josh Ferguson";
                [adRevision save];
                PFObject *adRevision2 = [PFObject objectWithClassName:@"DocumentRevision"];
                adRevision2[@"url"] = @"/test/4/5/6/adi.pdf";
                adRevision2[@"version"] = @1;
                adRevision2[@"format"] = @"pdf";
                adRevision2[@"uploadedBy"] = @"Josh Ferguson";
                [adRevision2 save];
                
                
                //PFRelation* adRevisions = [[NSMutableArray alloc] initWithCapacity:1];

                
                PFObject *adDocument = [PFObject objectWithClassName:@"Document"];
                adDocument[@"shortName"] = @"AD";
                adDocument[@"status"] = @"pending";
                adDocument[@"documentDescription"] = @"Agency Disclosure between buyer and buyer agent";
                //adDocument[@"revisions"] = adRevisions;
                //[adDocument setObject:adRevision forKey:@"revisions"];
                
                PFRelation *adRelation = [adDocument relationForKey:@"revisions"];
                [adRelation addObject:adRevision];
                [adRelation addObject:adRevision2];
                [adDocument save];
                
                adDocument[@"parent"] = [PFObject objectWithoutDataWithClassName:@"Post" objectId:@"1zEcyElZ80"];
                [documents addObject:adDocument];
                
                //AC
                PFObject *acRevision = [PFObject objectWithClassName:@"DocumentRevision"];
                acRevision[@"url"] = @"/test/1/2/3/ac.pdf";
                acRevision[@"version"] = @1;
                acRevision[@"format"] = @"pdf";
                acRevision[@"uploadedBy"] = @"Josh Ferguson";
                [acRevision save];
                
                //NSMutableArray* acRevisions = [[NSMutableArray alloc] initWithCapacity:1];
                
                
                PFObject *acDocument = [PFObject objectWithClassName:@"Document"];
                acDocument[@"shortName"] = @"AC";
                acDocument[@"status"] = @"pending";
                acDocument[@"documentDescription"] = @"Agency Confirmation";
                //acDocument[@"revisions"] = acRevisions;
                //[acDocument setObject:acRevision forKey:@"revisions"];
                PFRelation *acRelation = [acDocument relationForKey:@"revisions"];
                [acRelation addObject:acRevision];
                
                [acDocument save];
                
                [documents addObject:acDocument];
                
                //RPA
                PFObject *rpaRevision = [PFObject objectWithClassName:@"DocumentRevision"];
                rpaRevision[@"url"] = @"/test/1/2/3/rpa.pdf";
                rpaRevision[@"version"] = @1;
                rpaRevision[@"format"] = @"pdf";
                rpaRevision[@"uploadedBy"] = @"Josh Ferguson";
                [rpaRevision save];
                
                //NSMutableArray* rpaRevisions = [[NSMutableArray alloc] initWithCapacity:1];
                
                
                PFObject *rpaDocument = [PFObject objectWithClassName:@"Document"];
                rpaDocument[@"shortName"] = @"RPA";
                rpaDocument[@"status"] = @"pending";
                rpaDocument[@"documentDescription"] = @"Residential Purchase Agreement";
                //rpaDocument[@"revisions"] = rpaRevisions;
                
                //[rpaDocument setObject:rpaRevision forKey:@"revisions"];
                
                PFRelation *rpaRelation = [rpaDocument relationForKey:@"revisions"];
                [rpaRelation addObject:rpaRevision];
                [rpaDocument save];
                
                [documents addObject:rpaDocument];
                
                
                
                // Add a relation between the Post and Comment
                //testTransaction[@"documents"] = documents;
                PFRelation *txDocRelation = [testTransaction relationForKey:@"documents"];
                [txDocRelation addObject:adDocument];
                [txDocRelation addObject:acDocument];
                [txDocRelation addObject:rpaDocument];
                
                
                //testTransaction[@"listingAgent"] = [PFObject objectWithoutDataWithClassName:@"Agent" objectId:@"em7S3eWEEv"];
                //testTransaction[@"sellingAgent"] = [PFObject objectWithoutDataWithClassName:@"Agent" objectId:@"IHeHLAc01I"];
                PFRelation *listerRelation = [testTransaction relationForKey:@"listingAgent"];
                [listerRelation addObject:[PFObject objectWithoutDataWithClassName:@"Agent" objectId:@"em7S3eWEEv"]];
                
                PFRelation *sellerRelation = [testTransaction relationForKey:@"sellingAgent"];
                [sellerRelation addObject:[PFObject objectWithoutDataWithClassName:@"Agent" objectId:@"IHeHLAc01I"]];
                
                [testTransaction saveInBackground];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [detailItem.nickName stringByAppendingString:@"'s Transactions"] ;
    
    NSLog(@"nickName title %@",  detailItem.nickName);
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // get the Agent again for this view:
    NSLog(@"Refreshing listingAgent: %@", detailItem.objectId);
    PFQuery *agentRefreshQuery = [PFQuery queryWithClassName:@"Agent"];
    [agentRefreshQuery getObjectInBackgroundWithId:detailItem.objectId block:^(PFObject* foundAgent, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved Agent: %@", foundAgent.objectId);
            // Do something with the found objectsfor (PFObject *agent in foundAgents) {
                // load Agent for this view
            
            if(!listingTransactions) {
                listingTransactions = [[NSMutableArray alloc] initWithCapacity:10];
            }
            if(!sellingTransactions) {
                sellingTransactions = [[NSMutableArray alloc] initWithCapacity:10];
            }
            [self loadTransactionsByAgent:@"listingAgent" agentCriterion:foundAgent populateTxArray:listingTransactions populateTests:false];
            
             
            [self loadTransactionsByAgent:@"sellingAgent" agentCriterion:foundAgent populateTxArray:sellingTransactions populateTests:false];

            
        } else {
            // could not find Agent
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"returning row count: %d", sellingTransactions.count+ listingTransactions.count);
    return ((section == 0) ? sellingTransactions.count + listingTransactions.count : 0); // add listingTx
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transactionListItem" forIndexPath:indexPath];
    if(cell == NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"transactionListItem"] ;
    }
    NSLog(@"showing row: %d", [indexPath row]);
    // Configure the cell...
    ZoomRexTransaction* t = [self->sellingTransactions objectAtIndex:[indexPath row]];
    cell.textLabel.text = t.address1;
    
    NSLog(@"showing cell: %@", t.address1);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
