// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Listitem.h instead.

#import <CoreData/CoreData.h>

extern const struct ListitemAttributes {
	__unsafe_unretained NSString *item;
} ListitemAttributes;

@interface ListitemID : NSManagedObjectID {}
@end

@interface _Listitem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ListitemID* objectID;

@property (nonatomic, strong) NSString* item;

//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;

@end

@interface _Listitem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveItem;
- (void)setPrimitiveItem:(NSString*)value;

@end
