# ETL Project

## Exploration of Subway Acessibility, Real Estate and 311 Reports Across NYC (2020)

Group Members: Ryan Eccleston & Alison Sadel
* Context: For this project, we decided to extract, transform and load a datset with information on New York subway stations, residential real estate sales and 311 complaints. Once the ETL process is complete, we ultimately would like to explore socio-economic behaviors and potential disparities within New York City, segmented by zip code for 2020. 

# Extract

### Data Sources
* City of New York Subway Station Data
    * https://data.cityofnewyork.us/Transportation/Subway-Stations/arq3-7z49
* New York Government Statistics
    * https://www.health.ny.gov/statistics/cancer/registry/appendix/neighborhoods.htm
* Socrata 311 API
    * https://nycopendata.socrata.com/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9
* Residential Real Estate Sales 2020
    * http://compass.com/agents (restricted access)

### Extract Process
* Subway Station Data
    * Leveraged Google’s Reverse Geocod[e/ing] API  to transform point objects to an address where the street address/cross street and zip code was extracted.
* Heath NYC - NY Neighborhood ZIP Code Definitions
    * Scraped NY borough-neighborhood-zip code delineation from a table to separate lists.
* 311 Complaints Data
    * Modules required to create the API request for Socrata were Sodapy, json, pprint. 
    * Created a url path to request 311 Data, segmented for January 1st 2020 - February 12th 2021 with a 200k limit. After making the API call the 200k rows of data were loaded into a DataFrame.
* Housing Data
    * Filtered by borough and month/year and manually would select all 120 results for each page and export to google sheets. After creating the CSVs segmented by borough, we used a pd.concat( ) to merge the Dataframess.
    

### Data Limitations & Future Considerations
* Subway Station Data
    * Though this is an exhaustive list of subway stations, it does not provide any immediate indication of the station’s status or accessibility accommodations, only a link (under construction, etc.) 
* Heath NYC - NY Neighborhood ZIP Code Definitions
    * The neighborhoods column is not comprehensive (ex: Astoria is not missing). With Housing Data with a field for neighborhood and the nature of the dataset neighborhood is likely to be more accurate, although still a relative term.
    * Example: what I consider Upper West Side may not be your definitition of the Upper West Side).
* 311 Complaints Data
    * Memory becomes relevant when processing the 311 API. We segmented for 2020 which contains 44M rows of data. We opted to make a request with a 200,000 limit to align with system capabilities.
    * To determine if the 200k sample size is sufficient for future data exploration, it may be helpful to run an independent T-Test.
        
* Housing Data
    * Due to a load error on a specific page, 120 of the Brooklyn records were corrupted and unable to be extracted. 
    * New York Real Estate has no standardized MLS so there likely many additional transactions that occured in 2020 not reflected (non-REBNY, off-market). 
    * The data retrieval for the real estate dataset was extremely manual. In the future, using Splinter and Beautiful soup may be a future option to maintain the dataset over time.
    * One data capture issue we had was due to no standardized MLS (impacts reporting), there were many NaN values across the columns. With the intent to merge all data on zipcode, we ultimately dropped 9,634 columns. An alternative solution would be to run a Google Place API against the dataset, using the addresses to get latitude and longitude and then fill in those missing zipcode values.

## Transform

### Cleaning the Data
* Subway Station Data
    * Removed and renamed columns.
    * Checked for data type issues using a for loop to determine .dtype - no additional actions required.
    * Adjusted index to begin at 1 using .index +=1
* 311 Complaints Data
    * Removed unnecessary columns, reducing the number of columns from 41 to 24.
    * Migrated all data from columns containing the value ‘cross street’ to intersection values to  account for missing values using fillna( ) function. Once the data was merged between the 4 columns, we dropped the 2 redundant ‘cross-street’ columns. After removing the duplicative columns the 311 dataset contained 22 columns.
    * Renamed column headers to merge on ‘zipcode’ and reduced character length of headers for easier horizontal reading.
    * Converted all columns containing string values to lowercase for future data exploration using apply.map( ) function.
    * With the intent to merge dataframes on ‘zipcode’, all rows without a zipcode specified were dropped using the dropna( ) function. Dropping NaNs across rows removed 6,974 rows.
    * The original dataset was composed of 200,000 incident reports (rows) and 41 fields (columns). The cleaned 311 Dataframe contains 22 columns and 193026.
* Housing Data
    * Removed unnecessary columns, reducing the number of columns from 41 to 17.
    * Renamed all column headers to merge on 'zipcode', made all headers lowercase, removed spaces and provided clearer definitiions (ex: 'DOM' became 'days on market')
    * Checked data types using dtypes( ) function. Converted ppsf to float by removing $ sign with a replace( ) function and converted ppsf to float using astype( ) function for future data exploration.
    * With the intent to merge dataframes on ‘zipcode’, all rows without a zipcode specified were dropped using the dropna( ) function. Dropping NaNs across rows removed 9,634 columns.
    * Converted all columns containing string values to lowercase for future data exploration using apply.map( ) function.

## Load





### Resources 
* 311 Complaints Data (311_clean.zip)
    * Prior to transform process, the original dataset was composed of 200,000 incident reports (rows) and 41 fields (columns). The 200,000 sample size (of 44M records), documents 311 complaints for 2020.
    * The cleaned 311 Dataframe contains 22 columns and 193026 rows.

* Housing Data (real_estate_clean.csv)
    * Prior to transform process, the original dataset was composed of 49,876 residential real estate sales (rows) and 41 fields (columns) from 2020. 
    * The cleaned Real Estate Dataframe contains 17 columns and 40,242 rows.




```python

```
