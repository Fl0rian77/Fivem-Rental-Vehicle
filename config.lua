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
