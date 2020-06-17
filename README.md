# COVID19-Apex-Machine-Learning-Project
An endeavor to find when the COVID-19 outbreak will end globally using MATLAB Machine Learning Toolbox. 

For this project, the big question is: when is the outbreak projected to end?  This is the most important question because a lot of people have been concerned regarding the end of the outbreak and its current (as well as lasting) effects on our social dynamics, economy, and so on; in fact, it has even changed our inherent culture of giving hugs and kisses when greeting our loved ones! In order to find this apex date, we need to look at the progression of the confirmed number of cases relative to time (or the dates, in this case). Thus, I use a large 102 x 265 data set (27,030 data points) which lists the time series of the global confirmed cases (country-by country). This is supplied by the John Hopkins School of Public Health database via: https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases. The file is called time_series_covid19_confirmed_global.csv; fortunately, it’s in .csv format, so it can easily be imported into MATLAB.

The gloval pandemic apex date is found to be July 3rd, 2020 with a confirmed case count of 5,697,000 cases worldwide. 

Read more about the results and step-by-step process of this project in the given PDF document. 

The code is also included.

EDIT: Now that the COVID-19 count has passed 8 million as of June 17th, 2020, the machine learning model isn't accurate. This is due to sudden outbursts leading to serious data fluctuations, such as the Brazil outbreak, and rising political problems in the US. 
