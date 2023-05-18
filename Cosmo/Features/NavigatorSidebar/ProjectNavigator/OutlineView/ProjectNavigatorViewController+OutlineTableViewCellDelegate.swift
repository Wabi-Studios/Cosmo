/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmo :: composer
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

import Foundation

// MARK: - OutlineTableViewCellDelegate

extension ProjectNavigatorViewController: OutlineTableViewCellDelegate
{
  func moveFile(file: CEWorkspaceFile, to destination: URL)
  {
    if !file.isFolder
    {
      workspace?.tabManager.tabGroups.closeAllTabs(of: file)
    }
    file.move(to: destination)
    if !file.isFolder
    {
      workspace?.tabManager.openTab(item: file)
    }
  }

  func copyFile(file: CEWorkspaceFile, to _: URL)
  {
    file.duplicate()
  }
}
