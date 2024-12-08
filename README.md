# Paris-2024-Olympics-Data-Analysis
![Max Medals](path/to/your/max_medals_per_each_sport.png)

This analysis involves two vital datasets containing statistics about medals won by each country and their respective rankings. Athletes from each country secured various medals (gold, silver, and bronze) by showcasing their performances during the games, which determined their ranks based on the results.
<h3>Data Collection</h3>
<p>The initial step was to implement data extraction process from the official website. Since the official website of Paris 2024 Olympics has been unable to import fast, I decided to import data of medals table from a Wikipedia page through the URL in MS Excel:</p>
<ul>
  <li>Go to the <strong>Data</strong> tab in the ribbon.</li>
  <li>Click on <strong>Get Data</strong>, then select <strong>From Other Sources</strong>, and click on the <strong>From Web</strong> option.</li>
</ul>
  <p>After this step, a pop-up window will be appeared asking for a URL. I entered the URL of the medals page, then click <strong>OK</strong>.Then, it's time to connect it to the webpage.</p>
  
<ul>
  <li><strong>Power Query</strong> will try to get data from the webpage.</li>
  <li>Then, a Navigator window will open, showing tables that Excel found. Choose the table with the medals data.</li>
  <li>If the table doesn't appear right away, then check under "Document" or "Web View".</li>
</ul>
<p>Once we find the right table, click <strong>Load</strong> button.</p>
<hr/>
<h3>Data Cleaning and Preprocessing</h3>
The paris2024 database is created and set to allow write operations. The database contains two primary tables, medals and olympics_results, which are later joined to form a comprehensive <strong>games_results</strong> table for analysis. I renamed columns in both tables for clarity (e.g., noc → country_name, gold → gold_medals). I expanded the athletes column to accommodate detailed athlete data. A new column, <strong>Gender</strong>, is added to olympics_results.  The Gender column is updated based on patterns in the event_type column to categorize events as Male, Female, or Mixed. We update <strong>record</strong> column in games_results table to indicated records set during events: WR, O, None. 

<h5>medals_table.csv contains the following details:</h5>

rank - displays the ranking of each country after the games have concluded;

noc - indicates the name of each country representing each of them;

gold - indicates the number of gold medals won by each country;

silver - indicates the number of silver medals won by each country;

bronze - indicates the number of bronze medals won by each country;

total - represents the total number of gold, silver and bronze medals for each country.

<h5>paris_olympics_results.csv contains the following details:</h5>

noc - indicates the name of each country representing each of them;

medal - indicates the type of medal (gold, silver, or bronze) won by each athlete or group of athletes;

name - displays the full name of each athlete who won a medal for their country;

sport - indicates the sport in which each athlete showcased their performance;

event - lists each event type within each sport in which athletes secured their medals;

date - indicates the full date on which each athlete or a group of athletes won their medal.
<hr />
<h3>Data Analysis</h3>
<p>Before starting to analyze these datasets, make sure that we must have an installed version of My SQL. Check the official website of [MySQL]("https://www.mysql.com/") for details.</p>
<ul>
  <li>Launch MySQL Workbrench on your desktop or use MySQL Command-Line Shell for your analysis.</li>
  <li>Under <strong>MySQL Connections</strong>, click on your connection to open it. If you haven't set up a connection yet, then click the "+" button to create a new one and enter your connection details <strong>(Connection Name, Connection Method, Hostname, and Port)</strong>. Press "OK".</li>
  <li>It will create a connection set. Once we press in it, this will require to type a password.</li>
</ul>

<p>The main objectives of my analysis entail in the following way:</p>

<ul>
  <li>Analysis of Medal Counts by Country and Sport</li>
  <li>Comparison of Male and Female Athletes' Medals by Sport</li>
  <li>Athletes with the Highest Number of Medals by Gender and Sport</li>
  <li>Date of Maximum Medal Wins for Male and Female Athletes</li>
  <li>Countries Whose Athletes Broke Olympic or World Records (OR, WR)</li>
  <li>First Athlete to Break a Record (OR, WR) and Date of Achievement</li>
  <li>Top Athletes with the Most Medals in Each Country</li>
</ul>
<hr />
<h3>Data Visualization</h3>
First, I imported <strong>inline</strong> package for using Jupyter notebooks to display plots directly within the notebook interface. Then, I installed MySQL Connector with <strong>pip pip install mysqlconnector</strong> so that I could import <strong>mysql.connector</strong> library to create a communication between Python and MySQL databases. Also, I installed SQLAlchemy using <strong>pip install SQLAlchemy</strong> to support this connection. Then, I wrote the code which establishes a connection to a MySQL database using the <strong>mysql.connector.connect()</strong> function: it took the host, user, password and database parameters to interact with the MySQL database for querying or inserting data. 


