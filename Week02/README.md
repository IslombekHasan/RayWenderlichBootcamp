
# So many sliders... and Pikachus!

## Struct or Class?
So which one?

In structs, I ***always*** had to give initializers, which would become pretty nagging after some time. In classes, however, I used ***default*** values in order to initialize my `BullsEyeGame` object with no properties. However, if I wanted to have some special places where I would want to initialize my game differently, i could just use the properties anytime.  

However, I believe it wouldn't matter *a lot*, which one of these we used, since there was little-to-none to do with `value-based` or `reference-based` abstracts -- we only had one instance of the game and we never copied that instance anywhere in a controller.

### That's why!
Honestly saying, i didnt feel like bothering about mutation that Structs would cause me, so I went with the good old Classes :)

