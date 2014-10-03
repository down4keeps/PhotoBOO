// These values may be different for your servo
const SERVO_MIN = 0.03;
const SERVO_MAX = 0.1;
 
// create global variable for servo and configure
servo <- hardware.pin7;
servo.configure(PWM_OUT, 0.02, SERVO_MIN);
 
// expects a value between 0.0 and 1.0
function SetServo(value) {
  local scaledValue = value * (SERVO_MAX-SERVO_MIN) + SERVO_MIN;
  servo.write(scaledValue);
}
 
// expects a value between -80.0 and 80.0
function SetServoDegrees(value) {
  local scaledValue = (value + 81) / 161.0 * (SERVO_MAX-SERVO_MIN) + SERVO_MIN;
  servo.write(scaledValue);
}
 
// current position (we'll flip between 0 and 1)
position <- 0;
 count <- 0;
function Sweep() {
  // write the position
  SetServo(position);
  
  // invert the position
  position = 1.0 - position;
  
  // do it again in half a second:
  if(count<=10){
  imp.wakeup(1.0, Sweep);
  count++;
  }
} 

agent.on("BOO", function(arg) {
    Sweep();
});