//
//  ViewController.swift
//  Swift_UITableView
//
//  Created by shao on 16/5/10.
//  Copyright © 2016年 曹少帅. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    var items = ["昵称","账号","性别","地区","我的爱车"]
    var tableView:UITableView!
    var screenObject=UIScreen.mainScreen().bounds;
    var leftBtn:UIButton?
    var rightButtonItem:UIBarButtonItem?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的资料"
        
        let tableViewW:CGFloat=screenObject.width;
        let tableViewH:CGFloat=screenObject.height - 100;
        let tableViewX:CGFloat=0;
        let tableViewY:CGFloat=0;
        tableView = UITableView(frame: CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH),style:UITableViewStyle.Grouped);
        self.view.addSubview(tableView)
        
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
        self.leftBtn!.userInteractionEnabled = true
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
        
        cell.textLabel!.text = items[indexPath.row]
        //        switch(indexPath.row)
        //        {
        //        case 0:
        //            cell.detailTextLabel!.text = "女神"
        //            cell.imageView!.image = UIImage(named: "89-dumbbell.png")
        //            break
        //        case 1:
        //            cell.detailTextLabel!.text = "扔过来"
        //            cell.imageView!.image = UIImage(named: "102-walk.png")
        //            break
        //        case 2:
        //            cell.detailTextLabel!.text = "咪咪虾条"
        //             cell.imageView!.image = UIImage(named: "93-thermometer.png")
        //            break
        //        default:
        //            break
        //        }
        
        return cell
    }
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        let alert:UIAlertController = UIAlertController(title: "吃过咪咪虾条", message: "要锻炼", preferredStyle: UIAlertControllerStyle.ActionSheet)
    //        let sureAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
    //        }
    //        let cancelAction = UIAlertAction(title: "对，你说的对", style: UIAlertActionStyle.Cancel, handler: nil)
    //        alert.addAction(sureAction)
    //        alert.addAction(cancelAction)
    //
    //        self.presentViewController(alert, animated:true, completion: nil)
    //    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: {
            (action: UITableViewRowAction,indexPath: NSIndexPath) -> Void in
            let menu = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil)
            let facebookAction = UIAlertAction(title: "facebook", style: UIAlertActionStyle.Default, handler: nil)
            
            let twitterAction = UIAlertAction(title: "twitter", style: UIAlertActionStyle.Default, handler: nil)
            menu.addAction(facebookAction)
            menu.addAction(twitterAction)
            menu.addAction(cancelAction)
            self.presentViewController(menu, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {
            (action: UITableViewRowAction,indexPath: NSIndexPath) -> Void in
            
            let index = indexPath.row as Int
            self.items.removeAtIndex(index)
            self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            NSLog("删除\(indexPath.row)")
        })
        
        return [shareAction,deleteAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "你选择的是\(self.items[indexPath.row])"
        
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func setupLeftBarButtonItem()
    {
        self.leftBtn = UIButton(type: UIButtonType.System)
        
        self.leftBtn!.frame = CGRectMake(0,0,50,40)
        
        self.leftBtn?.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        
        self.leftBtn!.tag = 100
        
        self.leftBtn!.userInteractionEnabled = false
        self.leftBtn?.addTarget(self, action: "leftBarButtonItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
        let barButtonItem = UIBarButtonItem(customView: self.leftBtn!)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    //左边按钮事件
    func leftBarButtonItemClicked()
    {
        if (self.leftBtn!.tag == 100)
        {
            self.tableView?.setEditing(true, animated: true)
            self.leftBtn!.tag = 200
            self.leftBtn?.setTitle("Done", forState: UIControlState.Normal)
            //将增加按钮设置不能用
            self.rightButtonItem!.enabled=false
        }
        else
        {
            self.rightButtonItem!.enabled=true
            self.tableView?.setEditing(false, animated: true)
            self.leftBtn!.tag = 100
            self.leftBtn?.setTitle("Edit", forState: UIControlState.Normal)
        }
        
    }
    
    //加右边按钮
    func setupRightBarButtonItem()
    {
        self.rightButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self,action: "rightBarButtonItemClicked")
        self.navigationItem.rightBarButtonItem = self.rightButtonItem
        
    }
    //增加事件
    func rightBarButtonItemClicked()
    {
        
        let row = self.items.count
        let indexPath = NSIndexPath(forRow:row,inSection:0)
        self.items.append("我的名片")
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

