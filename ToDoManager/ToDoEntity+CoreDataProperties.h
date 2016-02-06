//
//  ToDoEntity+CoreDataProperties.h
//  ToDoManager
//
//  Created by Taro Minowa on 2/4/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSDate *due_date;
@property (nonatomic) BOOL inProgress;
@property (nullable, retain) NSString *priority;

@end

NS_ASSUME_NONNULL_END
