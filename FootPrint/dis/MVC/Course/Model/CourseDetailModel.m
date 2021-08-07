//
//  CourseDetailModel.m
//  GZJ
//
//  Created by YyMacBookPro on 2019/3/13.
//  Copyright © 2019年 cscs. All rights reserved.
//

#import "CourseDetailModel.h"

@implementation CoursePlayerFootModel

+ (NSMutableArray<CoursePlayerFootModel *> *)getVideoListInfo:(NSArray<NSDictionary *> *)listInfos {
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dict in listInfos) {
        CoursePlayerFootModel *model = [[CoursePlayerFootModel alloc] initWithDict:dict];
        if ([model.did isKindOfClass:[NSNumber class]]) {
            model.did = [(NSNumber *)model.did stringValue];
        }
        [arrM addObject:model];
    }
    return arrM;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setNilValueForKey:(NSString *)key{}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSArray *)getAllKeys{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    NSMutableArray *keys = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        [keys addObject:[NSString stringWithUTF8String:name]];
    }
    return keys;
}

+ (NSData *)dateWithInfoModel:(CoursePlayerFootModel *)mo {
    NSDictionary *dict = [mo dictionaryWithValuesForKeys:[mo getAllKeys]];
    return [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
}
+ (CoursePlayerFootModel *)infoWithData:(NSData *)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    CoursePlayerFootModel *mo = [[CoursePlayerFootModel alloc] initWithDict:dict];
    return mo;
}

@end

@implementation ChannelModel

@end
@implementation GroupUserModel

@end

//@implementation CountModel
//
//@end
@implementation JoinGroupUserModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"group_user":[GroupUserModel class]};
}


@end



@implementation CourseChapterModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"video_list":[CoursePlayerFootModel class]};
}

@end
@implementation GroupModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"join_group_user":[JoinGroupUserModel class],
             };
}



@end
@implementation GroupingModel



@end

@implementation CourseDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"chapter_video":[CourseChapterModel class],
             @"chapter_audio":[CoursePlayerFootModel class],
             @"curChannel":[ChannelModel class],
             @"group":[GroupModel class],
             @"grouping":[GroupingModel class]
             };
}

@end


