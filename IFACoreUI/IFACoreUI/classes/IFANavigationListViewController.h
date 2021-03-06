//
//  IFANavigationListViewController.h
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 28/07/10.
//  Copyright 2010 InfoAccent Pty Limited. All rights reserved.
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

#import "IFAListViewController.h"

@class IFAFormViewController;

@interface IFANavigationListViewController : IFAListViewController {
}

/**
 * Bar button item that provides managed object deletion in edit mode and supports multiple selection.
 * To use it, just add it to the array returned by ifa_editModeToolbarItems.
 */
@property (nonatomic, readonly) UIBarButtonItem *deleteBarButtonItem;

/**
 * Bar button item that provides managed object duplication functionality in edit mode.
 * To use it, just add it to the array returned by ifa_editModeToolbarItems.
 */
@property (nonatomic, readonly) UIBarButtonItem *duplicateBarButtonItem;

/**
 * Table view row action that provides managed object deletion functionality.
 */
@property (nonatomic, readonly) UITableViewRowAction *deleteTableViewRowAction;

/**
 * Table view row action that provides managed object duplication functionality.
 */
@property (nonatomic, readonly) UITableViewRowAction *duplicateTableViewRowAction;

/**
 * Returns YES if the any table view cell is showing actions, otherwise it returns NO.
 * This property can be used, for instance, to avoid showing a toolbar when entering edit mode as a result of the user swiping a table view cell to reveal its actions.
 * In that case, simply return an empty array from an overridden ifa_editModeToolbarItems method when this property is equal to YES.
 */
@property (nonatomic, readonly) BOOL showingTableViewCellActions;

@end
