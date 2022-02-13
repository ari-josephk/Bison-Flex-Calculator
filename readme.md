# Bison Flex Calculator

## Notes
- The var.h file contains the logic for creating and storing variables, so make sure to include it in directory when compiling.
- All "function" operations only take one "factor" token per argument. Therefore, for example
```sin pi/2``` will be evaluated as ```sin(pi)/2``` not ```sin(pi/2)```. To calculate ```sin(pi/2)```, it must be entered as ```sin(pi/2)```. This applies to all function and conversion operators