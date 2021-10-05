//
//  ObjectiveC_Hander.h
//  SQLiteLibTest
//
//  Created by vip on 16/10/25.
//  Copyright © 2016年 jaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ObjectiveC_Hander : NSObject
+(void)runNormalSql:(NSString *)sqlString;

+(void)selectSql;
@end
