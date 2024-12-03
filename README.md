# Paris-2024-Olympics-Data-Analysis
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
medals_table.csv contains the following details:

rank - displays the ranking of each country after the games have concluded;

noc - indicates the name of each country representing each of them;

gold - indicates the number of gold medals won by each country;

silver - indicates the number of silver medals won by each country;

bronze - indicates the number of bronze medals won by each country;

total - represents the total number of gold, silver and bronze medals for each country.
<hr />
<h3>Data Analysis</h3>
<p>Before starting to analyze these datasets, make sure that we must have an installed version of My SQL. Check the official website of [MySQL]("https://www.mysql.com/") for details.</p>
<ul>
  <li>Launch MySQL Workbrench on your desktop or use MySQL Command-Line Shell for your analysis.</li>
  <li>Under <strong>MySQL Connections</strong>, click on your connection to open it. If you haven't set up a connection yet, then click the "+" button to create a new one and enter your connection details <strong>(Connection Name, Connection Method, Hostname, and Port)</strong>. Press "OK".</li>
  <li>It will create a connection set. Once we press in it, this will require to type a password.</li>
</ul>
<p>I created a new database named "paris2024" using the <strong>CREATE DATABASE</strong> statement. After that, I clicked the refresh button under <strong>Schemas</strong> in the <strong>Navigator</strong> panel on the left side, and the newly created database appeared. To set this database as the default, I used the <strong>USE</strong> command followed by the database name. Next, I executed <strong>ALTER DATABASE paris2024 READ ONLY = 1</strong> statement to switch the database to be a read-only state. This means that no user can perform any changes to the data within this database.</p>

