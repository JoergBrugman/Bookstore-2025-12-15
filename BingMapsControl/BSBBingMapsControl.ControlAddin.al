controladdin "BSB BingMapsControl"
{
    //Get your Bing Maps key here: https://www.microsoft.com/en-us/maps/create-a-bing-maps-key
    Scripts =
        'https://www.bing.com/api/maps/mapcontrol?key=AjH41I6q9pOFrZI7gwmjm-rQ76C0RM0d6BAKCMb3xODBFCtQNVemrPE3-_-FdWJ2',
        'BingMapsControl/Script.js';
    StartupScript = 'BingMapsControl/StartupScript.js';

    RequestedWidth = 300;
    RequestedHeight = 300;
    MinimumWidth = 250;
    MinimumHeight = 250;
    MaximumWidth = 500;
    MaximumHeight = 500;
    HorizontalShrink = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    VerticalStretch = true;

    event ControlAddInReady();
    procedure ShowAddress(Address: Text);
}