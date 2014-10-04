<?php
 
require '../../vendor/autoload.php';
use Codebird\Codebird;
  
class TwitterNew
{
    protected $consumer_key = <API_KEY>;
    protected $consumer_secret = <API_SECRET>;
    protected $access_token = <ACCESS_TOKEN>;
    protected $access_secret = <ACCESS_SECRET>;
    protected $twitter;
 
    public function __construct()
    {
        // Fetch new Twitter Instance
        Codebird::setConsumerKey($this->consumer_key, $this->consumer_secret);
        $this->twitter = Codebird::getInstance();
 
        // Set access token
        $this->twitter->setToken($this->access_token, $this->access_secret);
    }
 
    public function tweet($message,$media)
    {
        return $this->twitter->statuses_updateWithMedia(array('status' => $message, 'media[]' => $media));
    }
 
}

?>

<?php
 
// require 'Twitter.php';
 
$twtr = new TwitterNew;
 

$s = @file_get_contents('php://input');
#add your photo link here in file put contents:
file_put_contents("PHOTOS.jpg", $s);
#add your static message here with hashtags, and link to
$twtr->tweet('HackbrightBoo got you! #SiliconChef', 'PHOTOS.jpg' );