# Singleface-Grid-System
LSL Script that allows for a single face to function as a grid for an object.

Here's my thought processes on this initial commit.

Notify() - Exists as a shorthand to circumvent SL's need to do llSay(0, message) every time and just have my own debugging chat messages. Will be removed when final.
Difference() - I'm like 99% it'd be better form to use absolute values for this but I somehow decided this was easier to do at 4 AM. Will be removed/replaced eventually.
getBoardCoords() - Will store OldCoords(currentCoords) and listen for new coordinates. Converts those into a list to work with the stored x and y values.
storeOldCoords() - Will store the old coordinates to calculate the Difference() between current position and new position.
moveX()/moveY() - Compares new and old coordinates. Depending on the change (positive or negative) and the Difference(), it will move that many squares.
Display() - A useful debugging method. This displays the current and old coordinates of the object, updating every move. Will be removed in final version.

Default State: This needs to be completely redone for the final project. As of right now, it *gets the job done.* Final version will instantiate a player object, it will either be told where to rez where it will store that information or it will ask the user where it should rez. Right now, it's kinda wonky just to get it to work.

readyForMove State: The bread and butter. Eventually, the player will be a state machine that can wait turns or enter special condition states. Right now, the player enters and then remains in this state until reset. While in this state, any click on the grid will move the player object to that square.

Here's a video of me talking about all of my experiments and trials before getting to a passable stage:
[![](http://img.youtube.com/vi/uPfG5mQ4vfg/0.jpg)](http://www.youtube.com/watch?v=uPfG5mQ4vfg "")
