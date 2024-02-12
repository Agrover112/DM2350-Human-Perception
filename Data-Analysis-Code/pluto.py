import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset
file_path = 'PJ1_Cleaned CSV - results-survey110205.csv'
data = pd.read_csv(file_path)

# Display the first few rows of the dataset to understand its structure
data.head()

eco_friendly_columns = ['BLU01AFR. How Eco-friendly do you perceive this product to be?0 = Not eco-friendly at all\xa0 |\xa0 5 = Extremely eco-friendly  ',
 'BLU01ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU01EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU02AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU02ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU02EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU03AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU03ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'BLU03EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN01AFR. How Eco-friendly do you perceive this product to be?0 = Not eco-friendly at all\xa0 |\xa0 5 = Extremely eco-friendly  ',
 'GRN01ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN01EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN02AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN02ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN02EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN03AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN03ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'GRN03EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG01AFR. How Eco-friendly do you perceive this product to be?0 = Not eco-friendly at all\xa0 |\xa0 5 = Extremely eco-friendly  ',
 'ORG01ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG01EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG02AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG02ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG02EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG03AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG03ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'ORG03EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK01AFR. How Eco-friendly do you perceive this product to be?0 = Not eco-friendly at all\xa0 |\xa0 5 = Extremely eco-friendly  ',
 'PNK01ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK01EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK02AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK02ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK02EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK03AFR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK03ASI. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ',
 'PNK03EUR. How Eco-friendly do you perceive that product to be?0 = Not eco-friendly at all\xa0 |\xa0\xa05 = Extremely eco-friendly  ']
# Correctly aggregating the ratings for each color
color_ratings_corrected = {color: pd.Series(dtype='float') for color in set([col[:3] for col in eco_friendly_columns])}

for col in eco_friendly_columns:
    color = col[:3]  # Extracting the color code from the column name
    color_ratings_corrected[color] = color_ratings_corrected[color].add(data[col], fill_value=0)

# Calculating average ratings for each color
for color in color_ratings_corrected:
    num_regions = len([1 for col in eco_friendly_columns if col.startswith(color)])
    color_ratings_corrected[color] /= num_regions

# Creating a DataFrame for the average ratings
average_ratings_df = pd.DataFrame(color_ratings_corrected)

# Displaying the first few rows of the average ratings DataFrame
average_ratings_df.head()



# Setting the style for the plots
sns.set(style="whitegrid")

# Plotting the average ratings for each color
plt.figure(figsize=(12, 6))
sns.boxplot(data=average_ratings_df)
plt.title('Average Eco-Friendliness Ratings for Different Colors averaged across Regions')
plt.ylabel('Average Rating')
plt.xlabel('Color')
plt.show()