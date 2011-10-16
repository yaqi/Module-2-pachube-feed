import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;

void setup()
{
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[2], 9600);

dOut = new DataOut(this, "http://www.pachube.com/api/37411.xml", "Q1jtuBeoic5RjEE28lWRowg1lg3xvUx86BV9u1fbm0w"); 

dOut.addData(0,"lED sensor1, volt, light level");

 }

void draw()
{
   // myValue = 0;
    myValue = arduino.analogRead(0);
      //println(myValue);
    if ((millis() - lastUpdate) > 12000){
        println(myValue);
        println("ready to PUT: ");
        dOut.update(0, myValue);
        int response = dOut.updatePachube();
        println(response);
        lastUpdate = millis();
    }
     
}
