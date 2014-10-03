http.onrequest(function(req, res) {
    res.send(200,"");
    device.send("BOO",1);
});