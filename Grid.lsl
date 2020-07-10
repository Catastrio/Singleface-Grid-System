notify(string message)
{
    llSay(0, message);
}

vector myPos;
integer numberOfRows    = 15;
integer numberOfColumns = 15;
 
default
{
    state_entry()
    {
        myPos = llGetPos();
        notify("Rezzing at: " + (string)myPos);
        llRezObject("Player Object Gridless 1.2", myPos + <0.0,0.0,0.06>, <0.0,0.0,0.0>, <0.0,0.0,0.0,1.0>, 0); // Player Object Temp Name
        llSay(453, "8" + ", " + "8");
    }
    
    touch_start(integer total_number)
    {
        vector  touchST     = llDetectedTouchST(0);
 
        integer columnIndex = (integer) ((touchST.x * numberOfColumns) + 1.0);
        integer rowIndex    = (integer) ((touchST.y * numberOfRows) + 1.0);
        
        //notify((string)touchST);
 
        llSay(453, (string)columnIndex + ", " + (string)rowIndex);
        llSay(0, (string)columnIndex + ", " + (string)rowIndex);
    }
}
