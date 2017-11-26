//
//  IFATableViewSelectionManager.h
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

@import IFAFoundation;

@protocol IFASelectionManagerDataSource;
@protocol IFASelectionManagerDelegate;

/**
* This class manages the state of single or multiple object selection, and it offers integration with a table view for managing associated view state.
*/
@interface IFATableViewSelectionManager : IFASelectionManager

@end

@protocol IFATableViewSelectionManagerDataSource <IFASelectionManagerDataSource>

@required

/**
* Implementing this method allows the selection manager to automatically deselect the table view associated with a user selection or deselection action.
* @param a_selectionManager The sender.
* @returns The table view whose row selection state must be kept in sync with the selection state managed by the sender.
*/
- (UITableView *)tableViewForSelectionManager:(IFASelectionManager *)a_selectionManager;

@end

@protocol IFATableViewSelectionManagerDelegate <IFASelectionManagerDelegate>

@required

/**
* Called by the selection manager to request the UI decoration of the table view cell associated with the selection or deselection action performed.
* When implementing this method, the <[IFASelectionManagerDataSource tableViewForSelectionManager:]> method must also be implemented.
*
* This call gives the UI a chance to update the state of the table view cell provided in order to reflect the selection or deselection performed by the user.
* @param a_selectionManager The sender.
* @param a_cell The table view cell the decoration is being requested for.
* @param a_selected YES if the associated user action has resulted in the selection of an object. NO if the associated user action has resulted in the deselection of an object.
* @param a_object The object being selected or deselected.
*/
- (UITableViewCell *)selectionManager:(IFASelectionManager *)a_selectionManager
          didRequestDecorationForCell:(UITableViewCell *)a_cell
                             selected:(BOOL)a_selected
                               object:(id)a_object;

@end
