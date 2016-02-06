//
//  MyUIViewController.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MyUIViewController.h"
#import "ToDoEntity.h"

@interface MyUIViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) ToDoEntity* toDoEntity;
@property (nonatomic, readonly) NSArray *pickerOptions;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityField;
@property (weak, nonatomic) IBOutlet UISwitch *inProgressSwitch;

@property (nonatomic) BOOL wasDeleted;
@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerOptions = @[@"Important", @"Normal", @"Minor"];
    self.priorityField.dataSource = self;
    self.priorityField.delegate = self;
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

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.pickerOptions objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.toDoEntity.priority = self.pickerOptions[row];
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
    NSString *priority = self.toDoEntity.priority;
    if (priority) {
        [self.priorityField selectRow:[self.pickerOptions indexOfObject:priority] inComponent:0 animated:NO];
    } else {
        [self.priorityField selectRow:1 inComponent:0 animated:NO];
    }
    [self.inProgressSwitch setOn:self.toDoEntity.inProgress];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];

    if (!self.wasDeleted) {
        self.toDoEntity.title = self.titleField.text;
        self.toDoEntity.priority = self.pickerOptions[[self.priorityField selectedRowInComponent:0]];
        self.toDoEntity.inProgress= self.inProgressSwitch.isOn;
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
