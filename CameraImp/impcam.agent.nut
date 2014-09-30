const SCARE_DELAY = 0.65; //(seconds)
const MY_SERVER_URL = "http://photoboo-149990.usw1-2.nitrousbox.com/Twitter.php";

requests <- []

jpeg_buffer <- null


device.on("jpeg_start", function(size) {
    jpeg_buffer = blob(size);
});

device.on("jpeg_chunk", function(v) {
    local offset = v[0];
    local b = v[1];
    for(local i = offset; i < (offset+b.len()); i++) {
        if(i < jpeg_buffer.len()) {
            jpeg_buffer[i] = b[i-offset];
        }
    }
});

device.on("jpeg_end", function(v) {
    local s = "";
    foreach(chr in jpeg_buffer) {
        s += format("%c", chr);
    }
    local req = http.post(MY_SERVER_URL, {}, s);
    req.sendsync();
    foreach(res in requests) {
        res.header("Location", "http://photoboo-149990.usw1-2.nitrousbox.com/tut.jpg");
        res.send(302, "Found\n");
    }
    server.log(format("Agent: JPEG Sent (%d bytes)"s.len()));
});

function takePicture(res) {
    device.send("take_picture", 1);
    requests.push(res);
}

http.onrequest(function(req, res) {
   http.get("https://agent.electricimp.com/w4t8GwoyeKxm").sendsync(); 
   imp.wakeup(SCARE_DELAY, function() {
       takePicture(res);
   });
});
