//
//  MyUIViewController.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MyUIViewController.h"
#import "ToDoEntity.h"

@interface MyUIViewController ()

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) ToDoEntity* toDoEntity;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDateField;
@property (nonatomic) BOOL wasDeleted;
@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)titleFieldEditEnd:(id)sender {
    self.toDoEntity.title = self.titleField.text;
    [self saveToDoEntity];
}

- (IBAction)trashTapped:(id)sender {
    [self.managedObjectContext deleteObject:self.toDoEntity];
    [self saveToDoEntity];
    self.wasDeleted = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)dueDateEditEnd:(id)sender {
    self.toDoEntity.due_date = self.dueDateField.date;
    [self saveToDoEntity];
}

- (void)saveToDoEntity
{
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if (!saveSuccess) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.wasDeleted = NO;
    self.titleField.text = self.toDoEntity.title;
    self.detailField.text = self.toDoEntity.detail;
    if (self.toDoEntity.due_date != nil) {
        self.dueDateField.date = self.toDoEntity.due_date;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];

    if (!self.wasDeleted) {
        self.toDoEntity.title = self.titleField.text;
        self.toDoEntity.detail = self.detailField.text;
        self.toDoEntity.due_date = self.dueDateField.date;
        [self saveToDoEntity];
    }
}

- (void)textViewDidEndEditing:(NSNotification *)notificaton
{
    if (notificaton.object == self) {
        self.toDoEntity.detail = self.detailField.text;
        [self saveToDoEntity];
    }
}

-(void)receiveMOC:(NSManagedObjectContext *)incomingMOC;
{
    self.managedObjectContext = incomingMOC;
}

-(void)reciveToDoEntity:(ToDoEntity *)incomingEntity
{
    self.toDoEntity = incomingEntity;
}

@end
