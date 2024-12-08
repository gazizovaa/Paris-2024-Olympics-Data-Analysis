import inline
import mysql.connector
import pandas as pd

pd.plotting.register_matplotlib_converters()
import matplotlib.pyplot as plt
import seaborn as sns

# create a connection with my sql
connection = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Aziz2001',
    database='paris2024'
)

# 1.analyze which country won the highest number of medals in each sport
max_medals_per_each_sport_query = """
SELECT country_name, max_medals AS highest_number_of_medals, sport
FROM (
    SELECT country_name, sport, COUNT(medal) AS total_medals,
           MAX(COUNT(medal)) OVER (PARTITION BY country_name) AS max_medals
    FROM games_results
    GROUP BY country_name, sport
) AS subquery_table
WHERE total_medals = max_medals
ORDER BY highest_number_of_medals DESC, country_name ASC, sport ASC;
"""
max_medals_per_each_sport_df = pd.read_sql(max_medals_per_each_sport_query, connection)

# Create a unique color palette for the countries
countries = max_medals_per_each_sport_df['country_name'].unique()
custom_palette = sns.color_palette("husl", len(countries))
palette_dict = dict(zip(countries, custom_palette))

plt.figure(figsize=(16, 8))
sns.barplot(x='sport', y='highest_number_of_medals', hue='country_name', data=max_medals_per_each_sport_df,
            palette='Set2', dodge=False)
plt.title('Highest Number of Medals in Each Sport By Country')
plt.xlabel('Sport')
plt.ylabel('Highest Number of Medals')
plt.xticks(rotation=45, ha='right', fontsize=7)
plt.yticks(fontsize=7)
plt.legend(title='Countries', bbox_to_anchor=(1.02, 0.5), loc='upper left', fontsize=10, title_fontsize=12)
plt.subplots_adjust(right=0.65, bottom=0.25)

# 2.compare the number of medals won by male and female athletes for each sport
compare_number_of_medals_query = """
SELECT country_name, gender, sport, COUNT(medal) AS total_medals
FROM games_results
WHERE gender != 'Mixed'
GROUP BY country_name, gender, sport
ORDER BY total_medals DESC, sport ASC, gender ASC;
"""
compare_number_of_medals_df = pd.read_sql(compare_number_of_medals_query, connection)
gender_palette = {'Male': '#4E79A7', 'Female': '#E15759'}
sns.barplot(x='sport', y='total_medals', hue='gender', data=compare_number_of_medals_df, palette=gender_palette)
plt.title('Medals Won By Male and Female Athletes per Each Sport')
plt.xlabel('Sport')
plt.ylabel('Total Number of Medals')
plt.xticks(rotation=45, ha='right', fontsize=10)
plt.yticks(fontsize=10)

# 3.identify male and female athletes with the highest number of medals in each sport
identify_athletes_with_highest_number_of_medals_query = """
SELECT athletes, gender, MAX(total_medals) AS max_medals, sport
FROM (SELECT athletes, gender, COUNT(medal) AS total_medals, sport
      FROM games_results
      GROUP BY athletes, gender, sport
) AS derived_table
WHERE gender IN('Male', 'Female')
GROUP BY athletes, gender, sport
ORDER BY max_medals DESC
LIMIT 10;
"""
identify_athletes_with_highest_number_of_medals_df = pd.read_sql(identify_athletes_with_highest_number_of_medals_query, connection)
sns.barplot(x='max_medals', y='athletes', hue='gender', data=identify_athletes_with_highest_number_of_medals_df, palette='pastel')
plt.title('Athletes with the Highest Medals in Each Sport')
plt.xlabel('Max Number of Medals')
plt.ylabel('Athletes')
plt.xticks(rotation=0, fontsize=10)
plt.yticks(fontsize=10)

# 4.find the date on which the highest number of medals were won by male and female athletes
date_with_highest_number_of_medals_query = """
SELECT gender, MAX(total_medals) AS max_medals, event_date
FROM (
    SELECT gender, COUNT(medal) AS total_medals, event_date
    FROM games_results
    WHERE gender != 'Mixed'
    GROUP BY gender, event_date
) AS derived_table
GROUP BY gender, event_date
ORDER BY max_medals DESC, event_date ASC;
"""
date_with_highest_number_of_medals_df = pd.read_sql(date_with_highest_number_of_medals_query, connection)
sns.lineplot(x='event_date', y='max_medals', hue='gender', data=date_with_highest_number_of_medals_df, marker='o', palette='Purples')
plt.title('Dates with the Highest Medals Won by Gender')
plt.xlabel('Dates')
plt.ylabel('Max Number of Medals')
plt.xticks(rotation=45, fontsize=10)
plt.yticks(fontsize=10)

# 5.identify the countries whose athletes broke Olympic or World Records (OR, WR)
define_countries_based_on_records_query = """
SELECT country_name, athletes, record
FROM games_results
WHERE record LIKE '_R'
ORDER BY country_name, record ASC;
"""
define_countries_based_on_records_df = pd.read_sql(define_countries_based_on_records_query, connection)
pivot_data = define_countries_based_on_records_df[define_countries_based_on_records_df['record'].notnull()]
pivot_data = pivot_data.pivot_table(index='country_name', columns='record', aggfunc='size', fill_value=0)
pivot_data = pivot_data.loc[(pivot_data > 0).any(axis=1)]

sns.heatmap(pivot_data, annot=True, cmap='coolwarm', fmt='d')
plt.title('Countries Breaking OR/WR Records')
plt.xlabel('Records')
plt.ylabel('Countries')

# 6.find the first athlete to break a record (OR, WR) and the date it occurred
first_athlete_who_break_record_query = """
SELECT athletes, record, MIN(event_date) AS earliest_date
FROM games_results
WHERE record LIKE '_R'
GROUP BY athletes, record
LIMIT 5;
"""
first_athlete_who_break_record_df = pd.read_sql(first_athlete_who_break_record_query, connection)
sns.scatterplot(x='earliest_date', y='athletes', hue='record', data=first_athlete_who_break_record_df, style='record', palette='tab10')
plt.title('First Athlete to Break Record')
plt.xlabel('Dates')
plt.ylabel('Athletes')
plt.xticks(rotation=45, fontsize=10)
plt.yticks(fontsize=10)

# 7.find the top athlete(s) with the most medals in each country
top_athletes_per_each_country_query = """
SELECT country_name, athletes, COUNT(medal) AS total_medals
FROM games_results
GROUP BY country_name, athletes
ORDER BY total_medals DESC
LIMIT 10;
"""
top_athletes_per_each_country_df = pd.read_sql(top_athletes_per_each_country_query, connection)
sns.stripplot(x='country_name', y='total_medals', hue='athletes', data=top_athletes_per_each_country_df, palette='Set2', jitter=True)
plt.title('Top Athletes with Most Medals by Country')
plt.xlabel('Countries')
plt.ylabel('Total Number of Medals')
plt.xticks(rotation=45, fontsize=10)
plt.yticks(fontsize=10)

plt.tight_layout()
plt.show()
