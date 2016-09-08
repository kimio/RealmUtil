RealmUtil - Objective-c
===================


This guy help us to use Realm in your project Objective-c!
How?
*Category for the CRUD,Autoincrement and get .realm adress \o/*

Source in dev branch, have fun \o\

----------

How to Install
-------------------

First, you need to install the Realm in your project.

> **Realm Objective-C:**

> - Follow the steps https://realm.io/docs/objc/latest/ and install the Realm to Objective-c.

Now Clone the project RealmUtil and copy the category **RLMObject+RealmUtil** to your project \o/

How to Use
-------------------

**Insert Value**
```
ModelRealmObject *model = [ModelRealmObject new];
    model.name = @"My Name";
    model.code = (NSInteger)123;
    NSError* erro = nil;
[ModelRealmObject insert:model andError:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}

```

**Update just determinats fields**
```
ModelRealmObject *model = [ModelRealmObject new];
    model.id = 3;
    model.name = @"Replaced Name";
    [ModelRealmObject update:model updateFields:@[@"name"] andError:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}

```

**Update all fields**
```
ModelRealmObject *model = [ModelRealmObject new];
    model.id = 3;
    model.name = @"Replaced Name";
    model.code = (NSInteger)321;
    [ModelRealmObject update:model andError:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}

```

**Select to return all data**
```
id regs = [ModelRealmObject select:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}
for(ModelRealmObject* reg in regs){
	NSLog([reg description]);
}

```

**Select with query**
```
id regs = [ModelRealmObject select:@" id=3 " andError:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}
for(ModelRealmObject* reg in regs){
    NSLog([prod description]);
}

```

**Delete register**
```
ModelRealmObject *model = [ModelRealmObject new];
    model.id = 3;
    model.name = @"Replaced Name";
    model.code = (NSInteger)321;
    [ModelRealmObject delete:model andError:&erro];
if(erro){
    NSLog([erro localizedDescription]);
}

```


**Get Realm register address**
This method help to use Realm Browser 
https://itunes.apple.com/br/app/realm-browser/id1007457278?l=en&mt=12
```
[ModelRealmObject showRealmAdress];
#//Users/{user}/Library/Developer/CoreSimulator/Devices/{{id device}/data/Containers/Data/Application/{id}/Documents/default.realm

```
