import pandas as pd

# Load CSV files
umsatzdaten = pd.read_csv('umsatzdaten_gekuerzt.csv', parse_dates=['Datum'])
wetter = pd.read_csv('wetter.csv', parse_dates=['Datum'])
kiwo = pd.read_csv('kiwo.csv', parse_dates=['Datum'])

# Merge on 'Datum'
df_merged = pd.merge(umsatzdaten, wetter, on='Datum', how='outer')
df_merged = pd.merge(df_merged, kiwo, on='Datum', how='outer')

# Check the first few rows of the merged DataFrame
print(df_merged.head())

# Check for any missing values
print(df_merged.isna().sum())

# Save to a new CSV file
df_merged.to_csv('merged_data.csv', index=False)