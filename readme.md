# Bison Flex Calculator

This is a simple calculator built in Flex and Bison. Solves any expression using proper BODMAS precedence and correct associativity. 

Some features include:
- Unit Conversions   ```mi_to_km```
- Variable Storage   ```var x = 50```

## How to run
To build the executable, simply run 
```make``` or ```make build```

Then, run the calculator executable with 
```make run``` or ```./a.out```

To clean object files and executable, run
```make clean```

## Notes
- The var.h file contains the logic for creating and storing variables, so make sure to include it in directory when compiling.
- The power function (^) is right associative
- All "function" operations have precedence between B and O in BODMAS. In other words, they are evaluated after brackets. 
- All "function" operations only take one "factor" token (or B in BODMAS) per argument. Therefore, for example ```sin pi/2``` will be evaluated as ```sin(pi)/2``` not ```sin(pi/2)```. To calculate ```sin(pi/2)```, it must be entered as ```sin(pi/2)```. This applies to all function and conversion operators
- Because of the above, to use functions as arguments to other functions, you must use brackets:
```abs (abs 2)``` not ```abs abs 2```
- Max variable name length of 63 characters. More may cause segfaults
- Referencing variables that don't exist will cause calculator to abort
