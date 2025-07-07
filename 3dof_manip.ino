#include <Servo.h>

// Create servo objects for each joint
Servo baseServo;     
Servo shoulderServo; 
Servo elbowServo;    

// Define servo pins
const int basePin = 9;
const int shoulderPin = 10;
const int elbowPin = 11;

void setup() {
  // Attach the servos to pins
  baseServo.attach(basePin);
  shoulderServo.attach(shoulderPin);
  elbowServo.attach(elbowPin);

  // Move to initial positions
  moveToPosition(90, 90, 90);

  // Initialize serial communication
  Serial.begin(9600);
  Serial.println("3 DOF Manipulator Ready.");
  Serial.println("Enter angles as: base shoulder elbow (e.g., 90 120 60)");
}

void loop() {
  if (Serial.available()) {
    int baseAngle = Serial.parseInt();
    int shoulderAngle = Serial.parseInt();
    int elbowAngle = Serial.parseInt();

    if (Serial.read() == '\n' || Serial.read() == ' ') {
      // Clamp angles to valid servo range (0–180)
      baseAngle = constrain(baseAngle, 0, 180);
      shoulderAngle = constrain(shoulderAngle, 0, 180);
      elbowAngle = constrain(elbowAngle, 0, 180);

      moveToPosition(baseAngle, shoulderAngle, elbowAngle);

      Serial.print("Moved to: ");
      Serial.print(baseAngle);
      Serial.print(" ");
      Serial.print(shoulderAngle);
      Serial.print(" ");
      Serial.println(elbowAngle);
    }
  }
}

// Function to move all servos
void moveToPosition(int baseAngle, int shoulderAngle, int elbowAngle) {
  baseServo.write(baseAngle);
  shoulderServo.write(shoulderAngle);
  elbowServo.write(elbowAngle);
  delay(500); // Wait for movement to complete
}
