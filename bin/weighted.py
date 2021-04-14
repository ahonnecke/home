spread = [
    {"amount": 0.10, "price": 32357.00},
    {"amount": 0.10, "price": 34999.00},
    {"amount": 0.10, "price": 33850.68},
    {"amount": 0.10, "price": 33999.00},
    {"amount": 0.10, "price": 33999.00},
    {"amount": 0.005, "price": 33956.89},
    {"amount": 0.20, "price": 36999.00},
    {"amount": 0.00051087, "price": 37528.86},
    {"amount": 0.10, "price": 37369.48},
    {"amount": 0.025, "price": 37100.92},
    {"amount": 0.25, "price": 34067.88},
    {"amount": 0.35, "price": 34250.89},
    {"amount": 0.50, "price": 34444.51},
    {"amount": 0.25, "price": 34999.00},
    {"amount": 0.05, "price": 34683.34},
    {"amount": 0.50, "price": 34523.75},
    {"amount": 0.10, "price": 34979.90},
    {"amount": 0.10, "price": 35044.59},
    {"amount": 0.025, "price": 35102.30},
    {"amount": 0.10, "price": 35210.63},
    {"amount": 0.10, "price": 35209.99},
    {"amount": 0.05, "price": 35076.66},
    {"amount": 0.15, "price": 34800.09},
]

spread = [
    {"amount": 40, "price": 133.15},
    {"amount": 20, "price": 79.04},
    {"amount": 10, "price": 108.97},
]

s = 0
total = 0
for sell in spread:
    value = sell.get("price")
    weight = sell.get("amount")

    s += value * weight
    total = total + weight

average = s / sum([s["amount"] for s in spread])
print(f"{total} at {average} for {total * average}")
BTC_DELTA = 150000
print(f"or {total * average / (BTC_DELTA)}")
