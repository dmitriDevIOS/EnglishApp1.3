//
//  Notifications.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 08/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//


import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {

     let notificationCenter = UNUserNotificationCenter.current()
    
    
       func requestAutorization() {
           notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
               print("permission allowed: \(granted)")
               guard granted else { return }
               self.getNotificationSettings()
           }
       }
    
       func getNotificationSettings() {
           notificationCenter.getNotificationSettings { (settings ) in
               print("Notification settings: \(settings)")
           }
       }
       
       func scheduledNotification(notificationType: String) {
           
           let content = UNMutableNotificationContent()
           let userAction = "User Action"
           
           content.title = notificationType
           content.body = "This is example how to create " + notificationType
           content.sound = UNNotificationSound.default
           content.badge = 1
           content.categoryIdentifier = userAction
        
        guard let path = Bundle.main.path(forResource: "notificationImage", ofType: "jpg") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "notificationImage", url: url, options: nil)
            content.attachments = [attachment]
        } catch {
            print("The attachment could not be loaded")
        }
            
           
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false )
           let identifier = "Local Notification"
           
           let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
           
           notificationCenter.add(request) { (error) in
               if let error = error {
                   print("Error: \(error.localizedDescription)")
               }
           }
           
           let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
           let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
           let category = UNNotificationCategory(identifier: userAction, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
           
           notificationCenter.setNotificationCategories([category])
       }
    
    
    // Delegate Methods 
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
        if response.notification.request.identifier == "Local Notification" {
            print("handle notification with the local notification identifier")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze" :
            print("Snooze")
            scheduledNotification(notificationType: "Reminder")
        case "Delete" :
            print("Delete")
        default:
            print("Unkown action")
        }
        
        
        completionHandler()
    }
    
}
