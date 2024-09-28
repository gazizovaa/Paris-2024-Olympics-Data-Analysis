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
<h3>Data Cleaning</h3>
<p>The second step was requiring cleaning the data, such as removing extra columns if they existed, fixing column header, identifying outliers, and more. After clicking <strong>Transform Data</strong> button, I filled the empty cells in the "Rank" column with the necessary values, corrected the "NOC" column, and deleted the last record since it could have interfered with the calculations.</p>
<p>After making the required changes, I clicked <strong>Load</strong> button to load this data into my Excel sheet.</p>
<hr/>
<h3>File Saving</h3>
<ul>
  <li>After the data is imported and cleaned, go to <strong>File -> Save As</strong>.</li>
  <li>Choose the location where we want to save the file.</li>
  <li>In the <strong>Save as type</strong>dropdown, select "CSV" or (*.csv).</li>
  <li>Give the file a name and click <strong>Save</strong> button.</li>
</ul>
