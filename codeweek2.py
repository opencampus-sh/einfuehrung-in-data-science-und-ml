import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV file into a DataFrame
df = pd.read_csv("umsatzdaten_gekuerzt.csv")

# Group the data by 'Warengruppe' and calculate the sum of 'Umsatz' for each group
grouped_data = df.groupby('Warengruppe')['Umsatz'].sum()

# Plot the bar chart
grouped_data.plot(kind='bar')

# Add labels and title
plt.xlabel('Warengruppe')
plt.ylabel('Total Umsatz')
plt.title('Total Umsatz by Warengruppe')

# Show the plot
plt.show()