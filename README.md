# Paris-2024-Olympics-Data-Analysis
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
<p>After collecting data, the next step involving cleaning and preprocessing it to ensure accuracy and consistency. I completed this process using Pandas and the steps followed were:</p>
<ul>
  <li>The dataset, named paris_olympics_results, was read into a Pandas DataFrame using the <strong>read_csv()</strong> function.</li>
  <li>As an initial review of the dataset, I used various methods such as<strong>head(), tail(), info(), describe(), columns()</strong> and <strong>shape, index, values</strong> methods to understand the structure and content of this dataset. They assisted me to identify any potential issues, including missing values, delete duplicates, and irrelevant rows.</li>
  <li>I renamed the "Country" column to "NOC" using the <strong>rename()</strong> function for consistency with the medals table dataset.</li>
</ul>
<p>I observed that some records, particularly from Japan and China, were irrelevant or missing medal values. To address these issues:</p>
<ul>
  <li>I created two separate mapping dictionaries for both Japan and China, where the "athlete's name" was mapped to their respective medals.</li>
  <li>Used the <strong>fillna()</strong> function, combined with the <strong>map()</strong> function, to fill in missing medal values for the relevant athletes.</li>
</ul>
<p>After making the necessary updates, I saved the cleaned dataset back to the original CSV file using the <strong>to_csv()</strong> function in Pandas.</p>
<hr />
<h3>Data Analysis</h3>
Before starting to analyze these datasets, make sure that we must have an installed version of My SQL (Check the official website of <a href="https://www.mysql.com/" target="_blank"></a> for details).
