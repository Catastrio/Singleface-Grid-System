integer listen_handle;
list newCoordinates;
list oldCoordinates;
string newXCoord;
string newYCoord;
string oldXCoord;
string oldYCoord;
integer result;
vector currentPos;

float numberOfColumns = 15.0;
float numberOfRows = 15.0;
float boardSize = 2.0; // Size in meters. Make it equal for now. Split to X/Y later for uneven grids.

getBoardCoords(string chatMessage)
{
    storeOldCoords(newCoordinates);
    newCoordinates = llParseString2List(chatMessage, [", "], []);
    newXCoord = llList2String(newCoordinates, 0);
    newYCoord = llList2String(newCoordinates, 1);
}

storeOldCoords(list coordinates)
{
    oldXCoord = llList2String(newCoordinates, 0);
    oldYCoord = llList2String(newCoordinates, 1);
    oldCoordinates = newCoordinates;
}

moveX(string newXCoord)
{
    if (newXCoord == oldXCoord)
    {
        difference((integer)newXCoord, (integer)oldXCoord);
        notify("No movement, difference is " + (string)result);
    }
    else if ((integer)newXCoord < (integer)oldXCoord)
    {
        difference((integer)newXCoord, (integer)oldXCoord);
        currentPos.x -= ((boardSize / numberOfRows) * result);
        llSetPos(currentPos);
    }
    else if ((integer)newXCoord > (integer)oldXCoord)
    {
        difference((integer)newXCoord, (integer)oldXCoord);
        currentPos.x += ((boardSize / numberOfRows) * result);
        llSetPos(currentPos);
    }
}

moveY(string newYCoord)
{
    if (newYCoord == oldYCoord)
    {
        difference((integer)newYCoord, (integer)oldYCoord);
        notify("No movement, difference is " + (string)result);
    }
    else if ((integer)newYCoord < (integer)oldYCoord)
    {
        difference((integer)newYCoord, (integer)oldYCoord);
        currentPos.y -= ((boardSize / numberOfColumns) * result);
        llSetPos(currentPos);
    }
    else if ((integer)newYCoord > (integer)oldYCoord)
    {
        difference((integer)newYCoord, (integer)oldYCoord);
        currentPos.y += ((boardSize / numberOfColumns) * result);
        llSetPos(currentPos);
    }
}

integer difference(integer x, integer y)
{    
    if (x >= y)
    {
        result = x - y;
        return result;
    }
    else
    {
        result = y - x;
        return result;
    }
}

display()
{
    llSetText("My current coordinates: " + (string)newXCoord + ", " + (string)newYCoord + "\n \nMy old coordinates: " + (string)oldXCoord + ", " + (string)oldYCoord, <0.5, 0.0, 1.0>, 1.0);
}

notify(string message)
{
    llSay(0, message);   
}

default
{
    state_entry()
    {
        listen_handle = llListen(453, "", NULL_KEY, "");
        currentPos = llGetPos();
    }
    
    listen(integer channel, string name, key id, string message)
    {
        if (channel == 453)
        {
            getBoardCoords(message);
            oldCoordinates = newCoordinates;
            notify("My starting position is: " + (string)newXCoord + ", " + (string)newYCoord);
            state readyForMove;
        }
    }
}

state readyForMove
{
    state_entry()
    {
        listen_handle = llListen(453, "", NULL_KEY, "");
        display();
        notify("Listening for coords");
    }
    listen(integer channel, string name, key id, string message)
    {
        if (channel == 453)
        {
            getBoardCoords(message);
            moveX(newXCoord);
            moveY(newYCoord);
            display();
        }
    }
}
