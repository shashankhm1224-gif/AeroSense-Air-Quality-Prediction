import csv
import random
from datetime import date, timedelta
from math import sin, pi

cities = ['Delhi', 'Mumbai', 'Pune', 'Chandigarh', 'Bengaluru']
profile = {
    'Delhi': {'temp_base': 29, 'humidity_base': 48, 'pm25_factor': 1.18, 'pm10_factor': 1.10, 'no2_factor': 1.30, 'so2_factor': 1.05, 'co_factor': 1.22, 'o3_factor': 1.00},
    'Mumbai': {'temp_base': 30, 'humidity_base': 72, 'pm25_factor': 0.96, 'pm10_factor': 1.02, 'no2_factor': 0.88, 'so2_factor': 0.72, 'co_factor': 0.84, 'o3_factor': 1.05},
    'Pune': {'temp_base': 26, 'humidity_base': 60, 'pm25_factor': 0.85, 'pm10_factor': 0.90, 'no2_factor': 0.78, 'so2_factor': 0.70, 'co_factor': 0.82, 'o3_factor': 0.97},
    'Chandigarh': {'temp_base': 25, 'humidity_base': 55, 'pm25_factor': 1.09, 'pm10_factor': 1.06, 'no2_factor': 1.12, 'so2_factor': 0.95, 'co_factor': 1.08, 'o3_factor': 0.91},
    'Bengaluru': {'temp_base': 27, 'humidity_base': 64, 'pm25_factor': 0.78, 'pm10_factor': 0.82, 'no2_factor': 0.70, 'so2_factor': 0.65, 'co_factor': 0.74, 'o3_factor': 1.10},
}
random.seed(123)
rows = []
current = date(2024, 1, 1)
end = date(2024, 12, 31)
while current <= end:
    for city in cities:
        p = profile[city]
        month = current.month
        seasonal = 1 + 0.22 * sin((month / 12) * 2 * pi)
        day_effect = 1 + 0.08 * sin((current.day / 30) * 2 * pi)
        temperature = p['temp_base'] + 8 * sin((month / 12) * 2 * pi) + random.uniform(-4, 4)
        humidity = p['humidity_base'] + 12 * sin((month / 12) * 2 * pi + 1.2) + random.uniform(-9, 9)
        temperature = round(max(8, min(42, temperature)), 2)
        humidity = round(max(25, min(95, humidity)), 2)
        pm25 = max(12, 38 * p['pm25_factor'] * seasonal * day_effect + random.uniform(-10, 12))
        pm10 = max(20, 68 * p['pm10_factor'] * seasonal * day_effect + random.uniform(-15, 14))
        no2 = max(8, 24 * p['no2_factor'] * seasonal + random.uniform(-6, 10))
        so2 = max(4, 12 * p['so2_factor'] * seasonal + random.uniform(-4, 6))
        co = max(0.3, 1.1 * p['co_factor'] * seasonal + random.uniform(-0.4, 0.6))
        o3 = max(8, 32 * p['o3_factor'] * (1 + 0.12 * sin((month / 12) * 2 * pi + 1.5)) + random.uniform(-7, 10))
        aqi = 0.38 * pm25 + 0.22 * pm10 + 0.17 * no2 + 0.09 * so2 + 0.10 * co * 18 + 0.09 * o3 + random.uniform(-8, 10)
        aqi = round(max(25, min(400, aqi)), 2)
        rows.append({
            'Date': current.isoformat(),
            'City': city,
            'PM2.5': round(pm25, 2),
            'PM10': round(pm10, 2),
            'NO2': round(no2, 2),
            'SO2': round(so2, 2),
            'CO': round(co, 2),
            'O3': round(o3, 2),
            'Temperature': temperature,
            'Humidity': humidity,
            'AQI': aqi,
        })
    current += timedelta(days=1)

for idx in random.sample(range(len(rows)), 18):
    col = random.choice(['PM2.5', 'PM10', 'NO2', 'SO2', 'CO', 'O3', 'Temperature', 'Humidity', 'AQI'])
    rows[idx][col] = ''

for _ in range(4):
    rows.append(rows[random.randrange(len(rows))].copy())

file_path = r'c:\Users\HP\OneDrive\Desktop\Air_Quality_Analysis_Prediction\air_quality_data.csv'
with open(file_path, 'w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=['Date', 'City', 'PM2.5', 'PM10', 'NO2', 'SO2', 'CO', 'O3', 'Temperature', 'Humidity', 'AQI'])
    writer.writeheader()
    writer.writerows(rows)
print(f'Created {len(rows)} rows at {file_path}')
