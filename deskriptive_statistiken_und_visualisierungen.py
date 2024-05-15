import pandas as pd
import matplotlib.pyplot as plt

# load data
df = pd.read_csv('merged_data.csv', parse_dates=['Datum'])

# check data
print(df.head())
print(df.info())
print(df.isna().sum())  # Überprüfung auf fehlende Daten

# Fehlende Werte für numerische Daten ersetzen
df['Temperatur'].fillna(df['Temperatur'].median(), inplace=True)
df['Umsatz'].fillna(df['Umsatz'].median(), inplace=True)
df['Windgeschwindigkeit'].fillna(df['Windgeschwindigkeit'].median(), inplace=True)

# Fehlende Werte für kategorische Daten ersetzen
df['Warengruppe'].fillna('Unbekannt', inplace=True)
df['Wettercode'].fillna('Unbekannt', inplace=True)


# Deskriptive Statistiken
print(df.describe())

# Visualisierungen
# Histogramme für Temperatur und Umsatz
df['Temperatur'].plot.hist(bins=20, alpha=0.7)
plt.title('Verteilung der Temperatur')
plt.xlabel('Temperatur (°C)')
plt.show()

df['Umsatz'].plot.hist(bins=20, alpha=0.7, color='green')
plt.title('Verteilung des Umsatzes')
plt.xlabel('Umsatz')
plt.show()

# Boxplot Warengruppe
df.boxplot(column='Umsatz', by='Warengruppe')
plt.title('Umsatz nach Warengruppe')
plt.ylabel('Umsatz')
plt.xticks(rotation=45)
plt.show()

# Scatter Plot Temperatur vs. Umsatz
plt.scatter(df['Temperatur'], df['Umsatz'], alpha=0.5)
plt.title('Temperatur vs. Umsatz')
plt.xlabel('Temperatur (°C)')
plt.ylabel('Umsatz')
plt.show()

# Umgang mit fehlenden Daten
# Fehlende Werte in 'Temperatur' und 'Umsatz' mit dem Median ersetzen
df['Temperatur'].fillna(df['Temperatur'].median(), inplace=True)
df['Umsatz'].fillna(df['Umsatz'].median(), inplace=True)


print(df.isna().sum())


