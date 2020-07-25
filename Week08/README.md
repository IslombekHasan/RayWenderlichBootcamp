#  Discussion
## How to ship with pre-loaded data?

Shipping with preloaded data can help in numerous occasions: for a simple to-do list app it can be ready-made to-dos showing how things work, for an alarm app it can be a set of sounds that can be chosen. Indeed, they are useful and there are several ways to ship your app with preloaded data within.

### JavaScript Object Notation (JSON) / Property List (Plist)

In our course, we've seen two ways to retrieve data to and from a `FileManager` or a `Bundle`. Never has it been easier to work with these file types as Apple has built-in APIs and coders that seemlessly integrate into the environment. 

Being prevalent in the current network-based world, JSON is a to-go choice. It's easy-to-read, clean and supports indeed *everything*. The ability to encode and decode virtually any object to/from JSON lets working with data smooth and hassle-free.

On the other hand, property lists are not as widely used, however they're the loved file types of Apple. In fact, Apple loves `plist` so much that Xcode has a neat Plist editor and all the configurations for the app like *location* or *camera* permissions are set in every iOS `Info.plist` file. In a raw format though, it is just plain XML and sharing it across the network can be a hassle as the file grows.

### Comma-separated values (CSV)

CSVs can be super lightweight to hold tons of data, but editing them can be somewhat a nightmare. The thing with CSVs is that unless you export them from an external source, e.g. a `Numbers` table, writing down each and every element is so error-prone that you'd better be super careful. Moreover, even if storing and reading from csv can be lightweight, decoding complex objects are solely *manual*. So why would you even use it then?

### CoreData
Well actually if you're working with data, wouldn't it be easier just to use built-in tools like Core Data? Well, yes and no. CoreData has tons of functionalities and configuring it (creating entities, managing relationships, creating subclasses) at first can be a little bit of work. However, once done, it can really be a time-saver; especially if use  `NSFetchedResultsController` which takes care of retrieving data. Though, IMHO for small apps that don't use so much data, it can be an overkill.

### Network-based solutions
And what about just getting the data from the network? Be it Firebase, Realm or your custom REST API call, getting data from network requires you entertain the user while your URL request is being fetched. This is especially true for users that have terrible internet connection. Users like me for example :] 

## Conclusion

I'd probably go with what my heart is telling me, but i can't. I have to go with the one that suits the case/task/app the best. So, all in all. ***It depends :]***


