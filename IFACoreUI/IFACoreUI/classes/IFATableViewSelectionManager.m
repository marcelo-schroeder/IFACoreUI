//
//  IFATableViewSelectionManager.m
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 14/07/11.
//  Copyright 2011 InfoAccent Pty Limited. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "IFACoreUI.h"

@interface IFATableViewSelectionManager () <IFATableViewSelectionManagerDelegate>
@property (nonatomic, readonly) id<IFATableViewSelectionManagerDataSource> tableViewDataSource;
@property (nonatomic, readonly) id<IFATableViewSelectionManagerDelegate> tableViewDelegate;
@property (nonatomic) id<IFASelectionManagerDelegate> actualDelegate;
@end

@implementation IFATableViewSelectionManager

#pragma mark - IFATableViewSelectionManagerDelegate

- (void)selectionManager:(IFASelectionManager *)a_selectionManager
        willSelectObject:(id)a_selectedObject
          deselectObject:(id)a_deselectedObject
               indexPath:(NSIndexPath *)a_indexPath
     deselectedIndexPath:(NSIndexPath *)a_deselectedIndexPath
                userInfo:(NSDictionary *)a_userInfo {

    if ([self.actualDelegate respondsToSelector:@selector(selectionManager:willSelectObject:deselectObject:indexPath:deselectedIndexPath:userInfo:)]) {
        [self.actualDelegate selectionManager:a_selectionManager willSelectObject:a_selectedObject deselectObject:a_deselectedObject indexPath:a_indexPath deselectedIndexPath:a_deselectedIndexPath userInfo:a_userInfo];
    }

}

- (void)selectionManager:(IFASelectionManager *)a_selectionManager
         didSelectObject:(id)a_selectedObject
        deselectedObject:(id)a_deselectedObject
               indexPath:(NSIndexPath *)a_indexPath
     deselectedIndexPath:(NSIndexPath *)a_deselectedIndexPath
                userInfo:(NSDictionary *)a_userInfo {

    if ([self.actualDelegate respondsToSelector:@selector(selectionManager:didSelectObject:deselectedObject:indexPath:deselectedIndexPath:userInfo:)]) {
        [self.actualDelegate selectionManager:a_selectionManager didSelectObject:a_selectedObject deselectedObject:a_deselectedObject indexPath:a_indexPath deselectedIndexPath:a_deselectedIndexPath userInfo:a_userInfo];
    }

#warning Need to see the conditional logic was for calling the new blocks of code below
    
    // Deselect row (UITableView's default visual indication only)
    [[self.tableViewDataSource tableViewForSelectionManager:self] deselectRowAtIndexPath:a_indexPath
                                                                                animated:YES];

    // Old cell
    if (l_previousSelectedObject) {
        if ([self.dataSource respondsToSelector:@selector(tableViewForSelectionManager:)]
            && [self.delegate respondsToSelector:@selector(selectionManager:didRequestDecorationForCell:selected:object:)]
            ) {
            NSIndexPath *oldIndexPath = l_previousSelectedIndexPath;
            UITableViewCell *oldCell = [[self.dataSource tableViewForSelectionManager:self] cellForRowAtIndexPath:oldIndexPath];
            [self.delegate selectionManager:self
                didRequestDecorationForCell:oldCell
                                   selected:NO
                                     object:l_previousSelectedObject];
        }
    }
    
    // New cell
    if (l_selectedObject) {
        if ([self.dataSource respondsToSelector:@selector(tableViewForSelectionManager:)]
            && [self.delegate respondsToSelector:@selector(selectionManager:didRequestDecorationForCell:selected:object:)]
            ) {
            UITableViewCell *newCell = [[self.dataSource tableViewForSelectionManager:self] cellForRowAtIndexPath:a_indexPath];
            [self.delegate selectionManager:self
                didRequestDecorationForCell:newCell
                                   selected:YES
                                     object:l_selectedObject];
        }
    }

}

- (UITableViewCell *)selectionManager:(IFASelectionManager *)a_selectionManager
          didRequestDecorationForCell:(UITableViewCell *)a_cell
                             selected:(BOOL)a_selected
                               object:(id)a_object {
    
    writing this...
    
}

#pragma mark - Private

- (id<IFASelectionManagerDelegate>)delegate {
    return self;
}

- (void)setDelegate:(id<IFASelectionManagerDelegate>)delegate {
    self.actualDelegate = delegate;
}

- (id<IFATableViewSelectionManagerDataSource>)tableViewDataSource {
    if ([self.dataSource conformsToProtocol:@protocol(IFATableViewSelectionManagerDataSource)]) {
        return (id<IFATableViewSelectionManagerDataSource>)self.dataSource;
    } else {
        return nil;
    }
}

- (id<IFATableViewSelectionManagerDelegate>)tableViewDelegate {
    if ([self.dataSource conformsToProtocol:@protocol(IFATableViewSelectionManagerDelegate)]) {
        return (id<IFATableViewSelectionManagerDelegate>)self.dataSource;
    } else {
        return nil;
    }
}

@end
