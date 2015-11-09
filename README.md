#Instagallery
(Yes, "Instagallery". I need to change the project/repo name.)

A beautiful way to browse your Instagram feed and focus on the content before the creator or details -- much like a real art gallery.

###How to Set Up

1. Make sure you have a Mac and Xcode.
2. Download the ZIP at the bottom of the column to the right.
3. Unzip and open up Instasearch.xcworkspace.
4. Hit the play button up left.

###Interesting

1. Instagram won't let you like or comment on behalf of the authenticated user for some reason. The endpoints for these actions are protected and you have to be some sort of weird non-commercial business and apply for access in order to use them. Tis a shame :/
2. SFSafariViewController was so easy to set up, even for a guy who has never worked with any time of WebView before. It took me a second to figure out how to handle getting the access token and dismiss the SFSafariViewController, however.

###Difficult

1. UICollectionViewCell selections is the most confusing and undocumented thing about UICollectionViews. I spent a solid hour tinkering with the selection delegate methods to no avail. This is first on the future to-do!
2. Mutating properties of UICollectionViewCell subviews can only be done in the cell's `setSelected:` method. I learned that the hard way. This is one of the reasons UICollectionViewCell selections is weird, because each cell tap fires ~3 calls to `setSelected:`. Again, on the to-do.

###Down the Road

I'm planning on expanding a good deal on this project. Here's a couple of thoughts I have going forward:

- [ ] Perfect the cell selection/detail toggle.
- [ ] Add an app icon.
- [ ] Officially change the name to "Instagallery" (or find something better).
- [ ] Add in link-ified hashtags/user handle's and direct the user to that hashtag's/user's "gallery".
- [ ] Add in the user's own "gallery".
- [ ] Add in the local "gallery".
- [ ] Add in search for specific "galleries".
- [x] Put "gallery" in quotes again.

###Pods used (THANK YOU)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [Masonry](https://github.com/SnapKit/Masonry)
* [SDWebImage](https://github.com/rs/SDWebImage)
* [DGActivityIndicatorView](https://github.com/gontovnik/DGActivityIndicatorView)
* [Chameleon Framework](https://github.com/ViccAlexander/Chameleon)

###Feedback

If it's an issue, please open up an issue on the repo.

If it's general feedback ("I hate ____" / "____ is awesome."), shoot me an electonic mail at lucas.newman@icloud.com.
