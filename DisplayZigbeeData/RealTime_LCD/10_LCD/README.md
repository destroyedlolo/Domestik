This directory contains files related to the configuration and behavior of the LCD screen:

- `LCD.LCD`: Physical screen definition, including the I2C device address and the geometry of the display.
- `LCD.shutdown`: Defines actions to perform during shutdown, such as turning off the LCD display.
- `LCD.Decoration`: Handles screen-specific decorations. In our case, it is used to simply clear the display.

