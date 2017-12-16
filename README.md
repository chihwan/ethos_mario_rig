# ethos_mario_rig
<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="favicon.png" type="image/x-icon" />
    <title>Chat</title>
    <style>
        body {
            margin: 0px;
        }
        h1 {
            font-family: arial;
            font-size: 100%;
        }
        iframe {
            width: 1366px;
            height: 768px;
        }
        div.top {
            background-color: white;
            height: 30px;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="top">
        <center><h1>Mario_Rig_Hash_Monitoring</h1></center>
    </div>

    <iframe id="iframe" src="http://ethosdistro.com/graphs/global.php?panel=superm&type=all_hash"></iframe>

    <script>
        window.setInterval(function() {
            reloadIFrame()
        }, 3000);

        function reloadIFrame() {
            console.log('reloading..');
            document.getElementById('iframe').contentWindow.location.reload();
        }
    </script>
</body>
</html>
