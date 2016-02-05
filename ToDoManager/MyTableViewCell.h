//
//  MyTableViewCell.h
//  ToDoManager
//
//  Created by Taro Minowa on 2/4/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"

@interface MyTableViewCell : UITableViewCell

- (void)setTodoEntity:(ToDoEntity *)toDoEntity;

@end
