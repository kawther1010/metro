# Calcule d’un trajet de transports publics

This Prolog project is designed to help users find a route within a public transportation network, considering various conditions such as departure time, arrival time, minimizing transfers, and travel duration.

## Project Overview

The project is structured into three main sections:

1. **Representation of Transportation Network**
   - Lines are defined using the `ligne/5` predicate, including information about stops, travel times, and schedules.

2. **Route Calculation**
   - Exercise 01: Tools for manipulating time.
   - Exercise 02: Predicates for checking if a line passes through two stops and considering departure or arrival times.
   - Exercise 03: Predicates for finding routes between two stops, including transfers.

3. **User Interface**
   - Exercise 4: Enhanced predicates with options for network choice, route length preference, and number of transfers.
   - Exercise 5: A simple user interface for selecting departure and arrival stations, along with optional preferences.

## File Structure

- `metro.pl`: Prolog code containing the data.
- `parite01.pl`: Prolog code containing implementations for exercises 1 and 2.
- `partie02.pl`: Prolog code containing implementations for exercises 3 and 4.
- `interface.pl`: Prolog code containing implementations for exercises 5.
- `README.md`: Documentation on how to run the program and project overview.
- `rapport.pdf`: Detailed report explaining design choices and implementation details.

## How to Run

1. Ensure you have a Prolog interpreter installed (e.g., SWI-Prolog).
2. Clone the repository:

    ```bash
    git clone https://github.com/kawther1010/metro.git
    cd metro
    ```

3. Load the Prolog file:

    ```bash
    swipl
    consult('metro.pl').
    consult('parite01.pl').
    consult('partie02.pl').
    consult('interface.pl').
    ```
## Contact Information

For any questions or clarifications, please contact NFIDSA HALIMA at nfidsahalima@gmail.com
