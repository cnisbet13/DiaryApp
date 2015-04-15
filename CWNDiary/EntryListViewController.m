//
//  EntryListViewController.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-30.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "EntryListViewController.h"
#import "CNCoreDataStack.h"
#import "DiaryEntry.h"

@interface EntryListViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResulTsControllers;



@end

@implementation EntryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.fetchedResulTsControllers performFetch:nil];
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.fetchedResulTsControllers.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResulTsControllers sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    DiaryEntry *entry = [self.fetchedResulTsControllers objectAtIndexPath:indexPath];
    cell.textLabel.text = entry.body;
    return cell;
}


- (NSFetchRequest *)entryListFetch
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DiaryEntry"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}






- (NSFetchedResultsController *)fetchedResultsControllers  {
    if (_fetchedResulTsControllers != nil) {
       return _fetchedResulTsControllers;
    }
    
    CNCoreDataStack *coreDatStack = [CNCoreDataStack defaultStack];
    NSFetchRequest *newFetch = [self entryListFetch];
    _fetchedResulTsControllers = [[NSFetchedResultsController alloc] initWithFetchRequest:newFetch managedObjectContext:coreDatStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResulTsControllers.delegate = self;
    
    return _fetchedResulTsControllers;
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/






/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end