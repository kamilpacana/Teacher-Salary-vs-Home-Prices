import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

connection = sqlite3.connect('boston_employee_data.db')

query = '''
SELECT *
FROM overall_average_teacher_salaries
'''
teacher_overall_average = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM top_25th_percentile_teacher_salaries
'''
teacher_top_percentile = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM bottom_25th_percentile_teacher_salaries
'''
teacher_bottom_percentile = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM average_fire_department_chief_salary
'''
average_fire_department_chief_salary = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM average_librarian_salary
'''
average_librarian_salary = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM average_custodian_salary
'''
average_custodian_salary = pd.read_sql_query(query, connection)

query = '''
SELECT *
FROM average_police_detective_salary
'''
average_police_detective_salary = pd.read_sql_query(query, connection)


figure, graph = plt.subplots(figsize=(10,6))
graph.grid()

#Plots the average salary for select other public sector employees
plt.plot(average_fire_department_chief_salary.year, average_fire_department_chief_salary.average_earnings,
         label='Fire Department Chief', color='#B86B77')
plt.plot(average_police_detective_salary.year, average_police_detective_salary.average_earnings,
         label='Police Detective', color='#11A797')
plt.plot(average_librarian_salary.year, average_librarian_salary.average_earnings, label='Librarian', color='#C7E9FF')
plt.plot(average_custodian_salary.year, average_custodian_salary.average_earnings, label='Custodian', color='#B8E3A8')


# creates a stacked area chart for teacher salaries
#https://holypython.com/python-visualization-tutorial/creating-stacked-area-charts-with-python/?expand_article=1
colors = sns.color_palette("RdBu", 7)
labels = ['Bottom 25th Percentile Teacher', 'Teachers Overall Average',
          'Top 25th Percentile Teacher']
plt.stackplot(teacher_bottom_percentile.year,
              teacher_bottom_percentile.average_earnings,
              (teacher_overall_average.average_earnings - teacher_bottom_percentile.average_earnings),
              (teacher_top_percentile.average_earnings - (teacher_overall_average.average_earnings)),
              labels=labels, colors=colors,  alpha=0.8)

#https://www.youtube.com/watch?v=HyoPxdSlbgg&t=97s
plt.legend(bbox_to_anchor=(1.0, 1.0))
plt.title("Public School Teacher Salaries in Boston Over Time")
plt.ylabel('Salary in Dollars')
plt.xlabel('Year')
caption = "This graph visualizes the changes in average teachers salaries (with additional subdivision by percentile)" \
          " and compares how they have grown relative to select other Boston public sector workers."
# https://stackoverflow.com/questions/34010205/adding-caption-below-x-axis-for-a-scatter-plot-using-matplotlib
graph.text(0.6, -0.3, caption, wrap=True, horizontalalignment='center', fontsize=12, transform=graph.transAxes)

figure.subplots_adjust(bottom=0.3, right=0.7)

plt.show()