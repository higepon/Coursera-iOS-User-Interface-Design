//
//  DPHandlesMoc.h
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPHandlesMoc <NSObject>

- (void)receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
