//
//  MainPageService.h
//  Bunny
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Eels. All rights reserved.
//

#import "BaseService.h"

#define AddNewReviewUrl @"method/review.new.inc.php"
#define AlterRevieUrl @"method/review.update.inc.php"

//详情页
#define AbandonRecordUrl @"method/book.delete.inc.php"
#define BookDetailUrl @"method/book.glance.inc.php"

#define ServerVersion @"ServerVersion"

@interface MainPageService : BaseService

+(void) getVersionFromServerSuccess:(void (^)(NSDictionary *versionInfo ,BOOL needUpdate))  successBlock
                               fail:(void (^)(void)) failBlock;

@end
