//
//  ProfileService.h
//  Bunny
//
//  Created by mac on 2017/8/5.
//  Copyright © 2017年 Eels. All rights reserved.
//

//个人中心相关接口

#import "BaseService.h"

//main page
#define ProfileDataUrl @"method/profile.get.inc.php"
#define OnReadListUrl @"method/profile.readinglists.inc.php"
#define HasReadListUrl @"method/profile.readedlists.inc.php"

#define UploadAvatarUrl @"method/profile.uploadPhoto.inc.php"

#define GET_FOLLOWINGS_LIST @"method/profile.followings.inc.php"
#define GET_FOLLOWERS_LIST @"method/profile.followers.inc.php"

@interface ProfileService : BaseService


@end
