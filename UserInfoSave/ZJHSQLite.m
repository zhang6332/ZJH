//
//  ZJHSQLite.m
//  AppleDevelop
//
//  Created by Apple on 2017/5/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZJHSQLite.h"
#import <sqlite3.h>
#define kDBName @"data.db"
#import <objc/runtime.h>

@interface ZJHSQLite ()
{
    sqlite3 *db;
}

@end

static ZJHSQLite *_instance;

@implementation ZJHSQLite

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
/**
 *  得到工具类对象
 *
 *  @return 工具类对象
 */
+ (ZJHSQLite *)sharedSQLite
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
/**
 *  创建表
 *
 *  @param clazz 实体类class
 */
-(void)createTableWithClass:(Class)clazz withDatabaseName:(NSString *)dataBaseName
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS ";
    const char *tableName = class_getName(clazz);
    sql = [sql stringByAppendingString:[[NSString alloc] initWithUTF8String:tableName]];
    sql = [sql stringByAppendingString:@"(ID INTEGER PRIMARY KEY AUTOINCREMENT,"];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(clazz,&count);
    for (int i=0; i<count; i++)
    {
        Ivar ivar =  ivarList[i];
        NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"%@ TEXT",key]];
        if(i!=(count-1))
        {
            sql = [sql stringByAppendingString:@","];
        }
    }
    free(ivarList);
    sql = [sql stringByAppendingString:@")"];
    
    NSLog(@"create sql ->%@",sql);
    
    [self execSql:sql withDatabaseName:dataBaseName];
}
/**
 *  删除表
 *
 *  @param clazz 实体类class
 */
-(void)dropTableWithClass:(Class)clazz withDatabaseName:(NSString *)dataBaseName
{
    const char *tableName = class_getName(clazz);
    NSString *tableNameStr =[[NSString alloc] initWithUTF8String:tableName];
    NSString*sql = [NSString stringWithFormat:@"DROP TABLE '%@'",tableNameStr];
    NSLog(@"drop sql ->%@",sql);
    [self execSql:sql withDatabaseName:dataBaseName];
}
/**
 * 打开数据库
 */
-(BOOL)openDatabaseWithName:(NSString *)dataBaseName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = nil;
    if (dataBaseName) {
        database_path = [documents stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",dataBaseName]];
    }else {
        database_path = [documents stringByAppendingPathComponent:kDBName];
    }
    //    MyLog(@"%@",database_path);
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return NO;
    }
    return YES;
}
/**
 *  执行sql
 */
-(void)execSql:(NSString *)sql withDatabaseName:(NSString *)dataBaseName
{
    char *err;
    if([self openDatabaseWithName:dataBaseName])
    {
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
        {
            sqlite3_close(db);
            NSLog(@"执行sql失败-->%@",sql);
        }
        sqlite3_close(db);
    }
}
/**
 *  删除全部记录
 *
 *  @param clazz 实体类class
 */
-(void)deleteRecordAllWithClass:(Class)clazz withDatabaseName:(NSString *)dataBaseName
{
    [self deleteRecordWithClass:clazz params:nil withDatabaseName:dataBaseName];
}
/**
 *  删除记录(相等)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@='%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录(大于)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isGreaterValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@ >'%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录(大于等于)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isGreaterEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@ >= '%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录(小于)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isLessValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@ <'%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录(小于等于)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isLessEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@ <='%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录(like)
 *
 *  @param clazz   实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值(自己加对应%)
 */
-(void)deleteRecordWithClass:(Class)clazz andKey:(NSString*)keyName isLikeValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    NSString *params =@"";
    if (keyName!=nil)
    {
        params = [NSString stringWithFormat:@" _%@ LIKE '%@' ",keyName,value];
    }
    else
    {
        params = @" 1=1 ";
    }
    [self deleteRecordWithClass:clazz params:params withDatabaseName:dataBaseName];
}
/**
 *  删除记录
 *
 *  @param clazz  实体类class
 *  @param params 条件
 */
-(void)deleteRecordWithClass:(Class)clazz  params:(NSString*)params withDatabaseName:(NSString *)dataBaseName
{
    if (params==nil)
    {
        params = @" 1=1";
    }
    const char *tableName = class_getName(clazz);
    NSString *tableNameStr =[[NSString alloc] initWithUTF8String:tableName];
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableNameStr,params];
    
    NSLog(@"delete sql ->%@",sql);
    [self execSql:sql withDatabaseName:dataBaseName];
}
/**
 *  查询全部数据
 *  @param clazz 实体类class
 *  @return 查询列表
 */
-(NSMutableArray *)selectAllWithClass:(Class)clazz withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:nil withDatabaseName:dataBaseName];
}
/**
 *  查询数据(大于)
 *
 *  @param clazz   clazz 实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 *
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz andKey:(NSString*)keyName isGreaterValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:[NSString stringWithFormat:@" %@ > '%@'",keyName,value] withDatabaseName:dataBaseName];
}
/**
 *  查询数据(大于等于)
 *
 *  @param clazz   clazz 实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 *
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz andKey:(NSString*)keyName isGreaterEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:[NSString stringWithFormat:@" %@ >= '%@'",keyName,value] withDatabaseName:dataBaseName];
}
/**
 *  查询数据(小于)
 *
 *  @param clazz   clazz 实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 *
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz andKey:(NSString*)keyName isLessValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:[NSString stringWithFormat:@" %@ < '%@'",keyName,value] withDatabaseName:dataBaseName];
}
/**
 *  查询数据(小于等于)
 *
 *  @param clazz   clazz 实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值
 *
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz andKey:(NSString*)keyName isLessEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:[NSString stringWithFormat:@" %@ <= '%@'",keyName,value] withDatabaseName:dataBaseName];
}
/**
 *  查询数据(Like)
 *
 *  @param clazz   clazz 实体类class
 *  @param keyName 实体对象属性名
 *  @param value   对应值(自己加%)
 *
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz andKey:(NSString*)keyName isLikeValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    return  [self selectWithClass:clazz params:[NSString stringWithFormat:@" %@ LIKE '%@'",keyName,value] withDatabaseName:dataBaseName];
}
/**
 *  查询数据 当params=nil时查询全部
 *
 *  @param clazz 实体类class
 *  @param params  条件
 *  @return 查询列表
 */
-(NSMutableArray *)selectWithClass:(Class)clazz params:(NSString*)params withDatabaseName:(NSString *)dataBaseName
{
    if (params==nil)
    {
        params = @" 1=1";
    }
    NSMutableArray *data = [NSMutableArray array];
    if([self openDatabaseWithName:dataBaseName])
    {
        const char *tableName = class_getName(clazz);
        NSString *tableNameStr =[[NSString alloc] initWithUTF8String:tableName];
        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",tableNameStr,params];
        sqlite3_stmt * statement;
        if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            unsigned int count = 0;
            Ivar *ivarList = class_copyIvarList(clazz,&count);
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                id obj = [[clazz alloc] init];
                for (int i=1; i<=count; i++)
                {
                    Ivar ivar =  ivarList[(i-1)];
                    char * value= (char*)sqlite3_column_text(statement, i);
                    NSString *valueStr = [[NSString alloc]initWithUTF8String:value];
                    NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                    [obj setValue:valueStr forKeyPath:key];
                }
                
                [data addObject:obj];
            }
            free(ivarList);
        }
        NSLog(@"select sql ->%@",sqlQuery);
        sqlite3_close(db);
        sqlite3_finalize(statement);
        return data;
    }
    return nil;
}
/**
 *  插入一条记录
 *
 *  @param obj 实体对象
 */
-(void)insertWithObj:(id)obj withDatabaseName:(NSString *)dataBaseName
{
    char *err;
    if([self openDatabaseWithName:dataBaseName])
    {
        const char *tableName = class_getName([obj class]);
        NSString *tableNameStr =[[NSString alloc] initWithUTF8String:tableName];
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(",tableNameStr];
        NSString *sqlValues =@"(";
        
        
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([obj class],&count);
        
        for (int i=0; i<count; i++)
        {
            Ivar ivar =  ivarList[i];
            NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@"%@",key]];
            sqlValues =[sqlValues stringByAppendingString:[NSString stringWithFormat:@"'%@'",[obj valueForKey:key]]];
            if(i!=(count-1))
            {
                sql = [sql stringByAppendingString:@","];
                sqlValues = [sqlValues stringByAppendingString:@","];
            }
        }
        sql = [NSString stringWithFormat:@"%@) VALUES %@)",sql,sqlValues];
        NSLog(@"insert sql ->%@",sql);
        free(ivarList);
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
        {
            sqlite3_close(db);
            NSLog(@"数据库插入一条记录失败!");
        }
        sqlite3_close(db);
    }
}
/**
 *  更新一条记录
 *
 *  @param obj     实体对象
 *  @param keyName 实体对象属性名
 *  @param value   条件值
 *
 */
-(void)updateWithObj:(id)obj andKey:(NSString*)keyName isEqualValue:(NSString*)value withDatabaseName:(NSString *)dataBaseName
{
    char *err;
    if([self openDatabaseWithName:dataBaseName])
    {
        const char *tableName = class_getName([obj class]);
        NSString *tableNameStr =[[NSString alloc] initWithUTF8String:tableName];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET ",tableNameStr];
        
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([obj class],&count);
        
        for (int i=0; i<count; i++)
        {
            Ivar ivar =  ivarList[i];
            NSString *key =  [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if(![keyName isEqualToString:[key substringFromIndex:1]])
            {
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"%@ = '%@'",key,[obj valueForKey:key]]];
                sql = [sql stringByAppendingString:@","];
            }
        }
        sql = [sql substringToIndex:sql.length-1];
        
        free(ivarList);
        if (keyName!=nil)
        {
            sql = [sql stringByAppendingString:@" WHERE "];
            sql = [NSString stringWithFormat:@"%@ _%@ = '%@' ",sql,keyName,value];
        }
        NSLog(@"update sql ->%@",sql);
        
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
        {
            sqlite3_close(db);
            NSLog(@"数据库更新一条记录失败!");
        }
        sqlite3_close(db);
    }
}

@end
