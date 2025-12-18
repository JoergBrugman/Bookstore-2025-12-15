window.BingMapsControl = 
    new Microsoft.Maps.Map(document.getElementById('controlAddIn'), {});

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);
