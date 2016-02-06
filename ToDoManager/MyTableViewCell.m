//
//  MyTableViewCell.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/4/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressLabe;

@end

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTodoEntity:(ToDoEntity *)toDoEntity
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    self.toDoEntity = toDoEntity;
    self.priorityLabel.text = self.toDoEntity.priority;
    self.inProgressLabe.text = self.toDoEntity.inProgress ? @"In Progress" : @"Not Started";
    self.titleLabel.text = toDoEntity.title;
}

@end
