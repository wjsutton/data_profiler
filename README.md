# The Data Profiler Function 

[![Status](https://img.shields.io/badge/status-active-success.svg)]() [![GitHub Issues](https://img.shields.io/github/issues/wjsutton/data_profiler.svg)](https://github.com/wjsutton/data_profiler/issues) [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/wjsutton/data_profiler.svg)](https://github.com/wjsutton/data_profiler/pulls) [![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

The aim of the function is to profile a simple data quality check on an object it is given. 

First a message is printed describing the structure of the object inputted and its dimensions.

Next a table is built describing the data quality, each row relates to a column in object inputted.

##   Table Definitions:

column        | definition
--------------------------------
column_name   | Column position and name, if no name is present "NULL" is returned.

obj_structure | Assesses how the object is structured, returns: vector, factor, list, character, matrix, array or unknown.

obj_data_type | Assesses the type of data, returns: numeric, string, logical or date.

uniqueness    | Returns a percentage score calculated from the number of distinct elements divided by the total number of elements.

completeness  | Returns a percentage score calculated from the number of non-blank, non-empty and non-null elements divided by the total number of elements.

min           | The minimum value, if string data type this is the minimum character length.

max           | The maxiumum value, if string data type this is the maxiumum character length.

avg           | The average value, if string data type this is the average character length.

standDev      | The standard deviation value, if string data type this is the standard deviation of character length.

