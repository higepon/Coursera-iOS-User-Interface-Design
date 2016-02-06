//
//  MyUITableViewController.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MyUITableViewController.h"
#import "MyTableViewCell.h"
#import "DPHandlesToDoEntity.h"

@interface MyUITableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSFetchedResultsController *resulltsController;

@end

@implementation MyUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeNSFetchedResultsControllerDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resulltsController.sections[section].numberOfObjects;
}

-(void)receiveMOC:(NSManagedObjectContext *)incomingMOC
{
    self.managedObjectContext = incomingMOC;
}

- (void)initializeNSFetchedResultsControllerDelegate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"due_date" ascending:YES]];

    self.resulltsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext
                                                                    sectionNameKeyPath:nil cacheName:nil];
    self.resulltsController.delegate = self;

    NSError *err;
    BOOL fetchSuceeeded = [self.resulltsController performFetch:&err];
    if (!fetchSuceeeded) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoEntity* item = self.resulltsController.sections[indexPath.section].objects[indexPath.row];
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    [cell setTodoEntity:item];
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            MyTableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setTodoEntity:item];
            break;
        }
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id<DPHandlesMoc, DPHandlesToDoEntity> child = (id<DPHandlesMoc, DPHandlesToDoEntity>)[segue destinationViewController];
    [child receiveMOC:self.managedObjectContext];

    ToDoEntity *item;
    if ([sender isMemberOfClass:[UIBarButtonItem class]]) {
        item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    } else {
        MyTableViewCell *cell = (MyTableViewCell *)sender;
        item = cell.toDoEntity;
    }
    [child reciveToDoEntity:item];
}


@end
