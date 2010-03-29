/* lilypad.pde
 * Author:    Chris Ball <chris@printf.net>
 * Function:  Take a number from a serial port, and display it on LEDs.
 * URL:       http://github.com/cjb/lilypad-email-tshirt/
 * License:   GPLv2+ or later, at your option.
 */

void setup() {
  Serial.begin(115200);  
  for (int i = 12; i <= 18; i++) {
    /* Set pins 12-17 to output, and strobe them to test. */
    pinMode(i, OUTPUT);
    digitalWrite(i, HIGH);
    delay(100);
    digitalWrite(i, LOW);
  }
}

void loop()          
{
  int i = 0;
  int numMails = 0;
  delay(2000);
  
  switch (Serial.available()) {
    /* Serial.available() is the number of bytes waiting.  Convert from 
     * ASCII val to an int.  Intentional switch-case fall through below. 
     */
    case 3:
      numMails = Serial.read();
      numMails -= 48;
      numMails *= 10;
    case 2:
      numMails += Serial.read();
      numMails -= 48;
      numMails *= 10;
    case 1:
      numMails += Serial.read();
      numMails -= 48;
      break;
    default:
      /* If >3 chars, just clear out the incoming buffer. */
      while (Serial.available())
        Serial.read();
      return;
  }

  digitalWrite(12, HIGH && (numMails & B1000000));
  digitalWrite(13, HIGH && (numMails & B0100000));
  digitalWrite(14, HIGH && (numMails & B0010000));
  digitalWrite(15, HIGH && (numMails & B0001000));
  digitalWrite(16, HIGH && (numMails & B0000100));
  digitalWrite(17, HIGH && (numMails & B0000010));
  digitalWrite(18, HIGH && (numMails & B0000001));
}
