# FiveM Vehicle Rental Script

## Overview

This FiveM vehicle rental script allows players to rent vehicles for a specified duration. If they exceed the rental time, they will be charged per minute. The script includes a customizable configuration file for easy adjustments.

## Features

- Rent vehicles for a specified number of hours.
- Charge players per minute if they exceed the rental time.
- Deduct charges from cash or bank balance.
- Notifications for rental events and errors.
- Configurable vehicle options, rental locations, and prices.

## Requirements

- [QBCore Framework](https://github.com/qbcore-framework/qb-core)
- [ox_target](https://github.com/overextended/ox_target)

1. **Download the Script:**
   - Clone or download the repository to your local machine.
   ```sh
   git clone https://github.com/thiercelinflorian/Fivem-Rental-Vehicle.git
   ```
2. **Place in Resources Folder:**
   - Move the fivem-vehicle-rental folder to your FiveM server's resources directory.

3. **Add to Server Config:**
   - Add the following line to your server.cfg file:
   ```sh
   ensure fivem-rental-vehicle
   ```
4. **Dependencies:**
   - Ensure you have the QBCore framework and ox_target installed and running on your server.

**Configuration**
- The script comes with a Config.lua file that allows you to customize various settings:

- Rental Price Per Hour: Set the hourly rental rate.
- Texts: Customize notification messages.
- Peds: Define the locations and properties of the rental NPCs.
- Blips: Set up blips on the map for rental locations.
- Vehicles: List of available vehicles for rent.
- Sounds: Configure sounds for rental events.
- Extra Charge Per Minute: Set the rate for extra charges per minute.

```lua
Config = {}

Config.RentalPricePerHour = 100

Config.Texts = {
    rentalMenuTitle = "Vehicle Rental",
    rentalMenuPrompt = "Number of hours",
    invalidHours = "Enter a valid number of hours!",
    notEnoughMoney = "You don't have enough money!",
    vehicleReturned = "Vehicle returned after %.2f hours",
    noVehicleToReturn = "You don't have a vehicle to return!",
    chooseVehicle = "Choose a vehicle",
    rentalExpired = "Your rental time has expired!",
    extraCharge = "You have been charged %s$ for exceeding the rental time.",
    notEnoughMoney = "You don't have enough money to pay the extra charges.",
    vehicleReturned = "Vehicle returned after %s minutes.",
    rentVehicle = "Rent a Vehicle",
    returnVehicle = "Return Vehicle",

}

Config.PedHash = `a_m_m_farmer_01`

Config.VehiclePlate = "RENTAL"

Config.Peds = {
    {coords = vector4(215.32, -810.81, 30.73, 157.89)},
    {coords = vector4(200.55, -700.63, 30.89, 150.32)}
}

Config.Blips = {
    {coords = vector3(215.32, -810.81, 30.73), name = "Vehicle Rental", sprite = 326, color = 2, scale = 0.8},
    {coords = vector3(200.55, -700.63, 30.89), name = "Vehicle Rental", sprite = 326, color = 2, scale = 0.8}
}

Config.Vehicles = {
    {label = "Panto", model = "panto", sprite = 225},
    {label = "Blista", model = "blista", sprite = 225},
    {label = "Issi", model = "issi2", sprite = 225},
    {label = "Dilettante", model = "dilettante", sprite = 225},
    {label = "Prairie", model = "prairie", sprite = 225},
    {label = "Rhapsody", model = "rhapsody", sprite = 225}
}

Config.ExtraChargePerMinute = 10

Config.Texts.extraCharge = "Vous avez été facturé %s$ pour le dépassement de la durée de location."
Config.Texts.notEnoughMoney = "Vous n'avez pas assez d'argent pour payer les frais supplémentaires."
Config.Texts.vehicleReturned = "Véhicule rendu après %s minutes."
```
