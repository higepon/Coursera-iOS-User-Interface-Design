//
//  ToDoEntity+CoreDataProperties.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/4/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity+CoreDataProperties.h"

@implementation ToDoEntity (CoreDataProperties)

@dynamic title;
@dynamic detail;
@dynamic due_date;
@dynamic inProgress;
@dynamic priority;

@end
