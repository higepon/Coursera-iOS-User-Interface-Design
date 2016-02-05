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

@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
