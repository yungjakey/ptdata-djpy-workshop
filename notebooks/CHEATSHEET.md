# Python Essentials Reference Guide

## Strings

```python
# Creation and basic operations
s = "Hello, World!"
s2 = 'Python'

# Concatenation
combined = s + " " + s2  # "Hello, World! Python"

# Indexing and slicing
first_char = s[0]        # 'H'
substring = s[0:5]       # 'Hello'
last_char = s[-1]        # '!'
reversed_str = s[::-1]   # '!dlroW ,olleH'

# Common methods
upper_case = s.upper()              # "HELLO, WORLD!"
lower_case = s.lower()              # "hello, world!"
replaced = s.replace("Hello", "Hi") # "Hi, World!"
split_words = s.split(", ")         # ["Hello", "World!"]
stripped = "  text  ".strip()        # "text"
lstripped = "  text  ".lstrip()      # "text  "
rstripped = "  text  ".rstrip()      # "  text"
joined = ", ".join(["a", "b", "c"])  # "a, b, c"

# Checking content
contains = "World" in s              # True
starts_with = s.startswith("Hello")  # True
ends_with = s.endswith("!")          # True

# Formatting
formatted = f"The value is {42}"                  # "The value is 42"
formatted2 = "The value is {:.2f}".format(42.69)  # "The value is 42.69"
formatted3 = "The value is {:.2f}".format(42.69)  # "The value is 42.69"
formatted2 = "The value is {}".format(42)         # "The value is 42"
```

## Lists

```python
# Creation
empty_list = []
numbers = [1, 2, 3, 4, 5]
mixed = [1, "two", 3.0, [4, 5]]

# Accessing elements
first = numbers[0]       # 1
last = numbers[-1]       # 5
subset = numbers[1:3]    # [2, 3]

# Modifying
numbers.append(6)        # [1, 2, 3, 4, 5, 6]
numbers.insert(0, 0)     # [0, 1, 2, 3, 4, 5, 6]
numbers.extend([7, 8])   # [0, 1, 2, 3, 4, 5, 6, 7, 8]
numbers.remove(0)        # [1, 2, 3, 4, 5, 6, 7, 8]
popped = numbers.pop()   # popped = 8, numbers = [1, 2, 3, 4, 5, 6, 7]
numbers[0] = 99          # [99, 2, 3, 4, 5, 6, 7]

# Operations
length = len(numbers)    # 7
sorted_list = sorted(numbers)  # Returns a new sorted list
numbers.sort()           # Sorts the list in-place
numbers.reverse()        # Reverses the list in-place

# Comprehensions
squares = [x**2 for x in range(10)]  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
evens = [x for x in range(10) if x % 2 == 0]  # [0, 2, 4, 6, 8]
```

## Dictionaries

```python
# Creation
empty_dict = {}
person = {"name": "Alice", "age": 30, "city": "New York"}
using_dict = dict(name="Bob", age=25, city="Chicago")

# Accessing elements
name = person["name"]               # "Alice"
age = person.get("age", 0)          # 30 (with default value 0)
keys = person.keys()                # dict_keys(['name', 'age', 'city'])
values = person.values()            # dict_values(['Alice', 30, 'New York'])
items = person.items()              # dict_items([('name', 'Alice'), ('age', 30), ('city', 'New York')])

# Modifying
person["email"] = "alice@example.com"  # Add new key-value pair
person["age"] = 31                  # Update existing value
person.update({"phone": "123-456-7890", "age": 32})  # Update multiple keys
deleted_age = person.pop("age")     # Remove key and return value
person.setdefault("country", "USA") # Set if key doesn't exist

# Operations
has_name = "name" in person        # True
dict_length = len(person)          # Number of key-value pairs

# Dictionary comprehensions
squares_dict = {x: x**2 for x in range(5)}  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
```

## Sets

```python
# Creation
empty_set = set()
fruits = {"apple", "banana", "orange"}
from_list = set([1, 2, 2, 3, 3, 3])  # {1, 2, 3}

# Operations
fruits.add("mango")             # Add one element
fruits.update(["grape", "kiwi"])  # Add multiple elements
fruits.remove("banana")         # Removes element (raises error if not found)
fruits.discard("pineapple")     # Removes if present (no error if not found)
popped = fruits.pop()           # Remove and return an arbitrary element

# Set operations
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}
union = a | b                   # {1, 2, 3, 4, 5, 6}
intersection = a & b            # {3, 4}
difference = a - b              # {1, 2}
symmetric_diff = a ^ b          # {1, 2, 5, 6}

# Checking content
size = len(fruits)              # Number of elements in set
is_in = "apple" in fruits       # True
is_subset = {1, 2}.issubset({1, 2, 3})  # True
```

## Tuples

```python
# Creation
empty_tuple = ()
single_item = (1,)  # Note the comma
coordinates = (10, 20)
mixed = (1, "two", 3.0)

# Operations
x, y = coordinates  # Unpacking
first = coordinates[0]  # 10
length = len(coordinates)  # 2

# Methods
count = (1, 2, 2, 3).count(2)  # 2
index = (1, 2, 3).index(2)  # 1
```

## Datetime objects

```python
from datetime import datetime, timedelta, date, time

# Current date and time
now = datetime.now()  # Current local date and time
utc_now = datetime.utcnow()  # Current UTC date and time

# Creating date and time objects
dt = datetime(2023, 5, 15, 10, 30, 0)  # Year, month, day, hour, minute, second
d = date(2023, 5, 15)  # Year, month, day
t = time(10, 30, 0)  # Hour, minute, second

# Formatting dates
formatted = now.strftime("%Y-%m-%d %H:%M:%S")  # '2023-05-15 10:30:00'
formatted_date = d.strftime("%B %d, %Y")  # 'May 15, 2023'

# Parsing strings to dates
parsed = datetime.strptime("2023-05-15 10:30:00", "%Y-%m-%d %H:%M:%S")

# Date arithmetic
tomorrow = now + timedelta(days=1)
next_week = now + timedelta(weeks=1)
two_hours_later = now + timedelta(hours=2)
diff = tomorrow - now  # A timedelta object

# Accessing components
year = now.year
month = now.month
day = now.day
hour = now.hour
minute = now.minute
second = now.second

# F-string formatting with datetime
formatted_f = f"Current date: {now:%Y-%m-%d}"  # 'Current date: 2023-05-15'
formatted_f_time = f"Current time: {now:%H:%M:%S}"  # 'Current time: 10:30:00'
formatted_f_timestamp = f"Current time: {now:%s}" # 'Current time: 1741077701'
```

## File Operations

```python
# Reading a file
with open("file.txt", "r") as file:
    content = file.read()  # Read entire file
    
with open("file.txt", "r") as file:
    lines = file.readlines()  # Read as list of lines
    
with open("file.txt", "r") as file:
    for line in file:  # Read line by line
        print(line.strip())

# Writing to a file
with open("output.txt", "w") as file:
    file.write("Hello, World!")
    
with open("output.txt", "a") as file:  # Append mode
    file.write("More content.")
    
# Using pathlib (modern approach)
from pathlib import Path
path = Path("file.txt")
content = path.read_text()  # Read file
path.write_text("New content")  # Write to file
```

## JSON Operations

```python
import json

# Parsing JSON strings
json_str = '{"name": "Alice", "age": 30, "is_student": false}'
data = json.loads(json_str)
name = data["name"]  # "Alice"

# Creating JSON strings
person = {"name": "Bob", "age": 25, "hobbies": ["reading", "cycling"]}
json_string = json.dumps(person)
pretty_json = json.dumps(person, indent=2, sort_keys=True)  # Pretty print

# Reading JSON files
with open("data.json", "r") as file:
    data = json.load(file)

# Writing JSON files
with open("output.json", "w") as file:
    json.dump(person, file, indent=4)
```

## Pandas DataFrames

```python
import pandas as pd
import numpy as np

# Creating DataFrames
df = pd.DataFrame({
    'A': [1, 2, 3],
    'B': ['a', 'b', 'c'],
    'C': [4.0, 5.0, 6.0]
})

df2 = pd.DataFrame(
    np.random.randn(5, 3),
    columns=['A', 'B', 'C']
)

# From CSV, Excel, etc.
df_csv = pd.read_csv("data.csv")
df_excel = pd.read_excel("data.xlsx", sheet_name="Sheet1")
df_json = pd.read_json("data.json")

# Basic information
df.head()  # First 5 rows
df.tail(3)  # Last 3 rows
df.info()  # Summary of DataFrame
df.describe()  # Statistical summary
df.shape  # (rows, columns)
df.columns  # Column names
df.dtypes  # Data types

# Selection
value = df.loc[0, 'A']  # Select by label
value = df.iloc[0, 0]  # Select by position
col_a = df['A']  # Select column (returns Series)
subset = df[['A', 'B']]  # Select multiple columns
row = df.loc[0]  # Select row
filtered = df[df['A'] > 1]  # Filter rows

# Modifying
df['D'] = [7, 8, 9]  # Add column
df.loc[3] = [4, 'd', 7.0]  # Add row
df.drop('C', axis=1, inplace=True)  # Drop column
df.drop(0, axis=0, inplace=True)  # Drop row

# Operations
df.sort_values('A', ascending=False)  # Sort
df.groupby('B').sum()  # Group by and aggregate
df.reset_index(drop=True)  # Reset index
df.fillna(0)  # Fill missing values
df.dropna()  # Drop rows with missing values
df['A'].apply(lambda x: x*2)  # Apply function

# Merging, joining, concatenating
merged = pd.merge(df1, df2, on='key')  # SQL-style join
concat = pd.concat([df1, df2])  # Append rows
```

## Functions
```python
# Definition
def function_name(parameter1, parameter2):
    """Docstring: Explains what the function does"""
    # Function body
    result = parameter1 + parameter2
    return result
    
# Calling the function
output = function_name(5, 3)  # output = 8

# Positional arguments
def greet(name, message):
    return f"{message}, {name}!"

greet("Alice", "Hello")  # "Hello, Alice!"

# Keyword arguments
greet(message="Hi", name="Bob")  # "Hi, Bob!"

# Mix of positional and keyword arguments
# Positional must come before keyword arguments
greet("Charlie", message="Hey")  # "Hey, Charlie!"

# Default values
def greet(name, message="Hello"):
    return f"{message}, {name}!"
    
greet("Alice")  # "Hello, Alice!"
greet("Bob", "Hi")  # "Hi, Bob!"

# *args for variable positional arguments
def sum_all(*args):
    total = 0
    for num in args:
        total += num
    return total
    
sum_all(1, 2, 3, 4)  # 10

# **kwargs for variable keyword arguments
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")
        
print_info(name="Alice", age=30, location="New York")

# Recursion
def factorial(n):
    if n == 0 or n == 1:  # Base case
        return 1
    else:
        return n * factorial(n-1)  # Recursive call
        
factorial(5)  # 120 (5 * 4 * 3 * 2 * 1)

# Type hints specifying expected argument types
def jolo(name: str = "jakob"):
    print(f"{name} only lives once")

```

## Classes
```python
# Basic class definition
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        
    def greet(self):
        return f"Hello, my name is {self.name}"
    
# Creating an instance
person = Person("Alice", 30)
greeting = person.greet()  # "Hello, my name is Alice"

# Inheritance
class Student(Person):
    def __init__(self, name, age, student_id):
        super().__init__(name, age)
        self.student_id = student_id
        
    def study(self):
        return f"{self.name} is studying"

# Class variables
class Counter:
    count = 0  # Class variable
    
    def __init__(self):
        Counter.count += 1
        
    @classmethod
    def get_count(cls):
        return cls.count

# Static methods
class MathUtils:
    @staticmethod
    def add(a, b):
        return a + b

# Properties
class Temperature:
    def __init__(self, celsius):
        self._celsius = celsius
        
    @property
    def celsius(self):
        return self._celsius
    
    @celsius.setter
    def celsius(self, value):
        self._celsius = value
        
    @property
    def fahrenheit(self):
        return (self.celsius * 9/5) + 32
    
    @fahrenheit.setter
    def fahrenheit(self, value):
        self.celsius = (value - 32) * 5/9

# Dunder methods
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)
    
    def __str__(self):
        return f"Vector({self.x}, {self.y})"
    
    def __len__(self):
        return int((self.x**2 + self.y**2)**0.5)
```

## Data Visualization

### Matplotlib

```python
import matplotlib.pyplot as plt
import numpy as np

# Line plot
x = np.linspace(0, 10, 100)
plt.figure(figsize=(10, 6))
plt.plot(x, np.sin(x), label='sin(x)')
plt.plot(x, np.cos(x), label='cos(x)')
plt.title('Sine and Cosine Functions')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.grid(True)
plt.savefig('trig_functions.png')
plt.show()

# Scatter plot
x = np.random.rand(50)
y = np.random.rand(50)
colors = np.random.rand(50)
sizes = 1000 * np.random.rand(50)
plt.scatter(x, y, c=colors, s=sizes, alpha=0.5)
plt.title('Scatter Plot')
plt.show()

# Bar plot
categories = ['A', 'B', 'C', 'D']
values = [3, 7, 2, 5]
plt.bar(categories, values)
plt.title('Bar Plot')
plt.show()

# Histogram
data = np.random.randn(1000)
plt.hist(data, bins=30, alpha=0.7)
plt.title('Histogram')
plt.show()

# Pie chart
labels = ['Frogs', 'Hogs', 'Dogs', 'Logs']
sizes = [15, 30, 45, 10]
plt.pie(sizes, labels=labels, autopct='%1.1f%%')
plt.axis('equal')
plt.title('Pie Chart')
plt.show()

# Subplots
fig, axs = plt.subplots(2, 2, figsize=(10, 8))
axs[0, 0].plot(x, np.sin(x))
axs[0, 0].set_title('Sine')
axs[0, 1].plot(x, np.cos(x))
axs[0, 1].set_title('Cosine')
axs[1, 0].plot(x, np.exp(x))
axs[1, 0].set_title('Exponential')
axs[1, 1].plot(x, np.log(x+1))
axs[1, 1].set_title('Logarithm')
plt.tight_layout()
plt.show()
```

### Seaborn

```python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

# Set theme
sns.set_theme(style="whitegrid")

# Sample dataset
tips = sns.load_dataset("tips")
flights = sns.load_dataset("flights")
iris = sns.load_dataset("iris")

# Distribution plot
plt.figure(figsize=(10, 6))
sns.histplot(tips['total_bill'], kde=True)
plt.title('Distribution of Total Bill')
plt.show()

# Scatter plot with regression line
plt.figure(figsize=(10, 6))
sns.regplot(x='total_bill', y='tip', data=tips)
plt.title('Relationship between Bill and Tip')
plt.show()

# Categorical plots
plt.figure(figsize=(10, 6))
sns.boxplot(x='day', y='total_bill', data=tips)
plt.title('Bill Amount by Day')
plt.show()

plt.figure(figsize=(10, 6))
sns.violinplot(x='day', y='total_bill', hue='sex', data=tips, split=True)
plt.title('Bill Distribution by Day and Gender')
plt.show()

# Bar plot
plt.figure(figsize=(10, 6))
sns.barplot(x='day', y='total_bill', data=tips)
plt.title('Average Bill by Day')
plt.show()

# Heatmap
flights_pivot = flights.pivot("month", "year", "passengers")
plt.figure(figsize=(12, 8))
sns.heatmap(flights_pivot, annot=True, fmt="d", cmap="YlGnBu")
plt.title('Passenger Count by Month and Year')
plt.show()

# Pair plot (scatter matrix)
sns.pairplot(iris, hue="species")
plt.suptitle('Iris Dataset Features', y=1.02)
plt.show()

# Facet grid
g = sns.FacetGrid(tips, col="time", row="sex")
g.map_dataframe(sns.scatterplot, x="total_bill", y="tip")
g.add_legend()
plt.show()
```

### Plotly

```python
import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import numpy as np

# Basic line plot
fig = px.line(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
fig.update_layout(title='Square Function', xaxis_title='x', yaxis_title='x^2')
fig.show()

# Scatter plot
df = px.data.iris()
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species",
                 size="petal_length", hover_data=['petal_width'])
fig.update_layout(title='Iris Dataset Scatter Plot')
fig.show()

# Bar chart
df = px.data.gapminder().query("country == ['Canada', 'Brazil', 'United States']")
fig = px.bar(df, x="country", y="gdpPercap", color="country",
             animation_frame="year", animation_group="country")
fig.update_layout(title='GDP per Capita Over Time')
fig.show()

# Pie chart
df = px.data.gapminder().query("year == 2007").query("continent == 'Europe'")
fig = px.pie(df, values='pop', names='country', title='Population of European Countries')
fig.show()

# Box plot
df = px.data.tips()
fig = px.box(df, x="day", y="total_bill", color="smoker")
fig.update_layout(title='Bill Distribution by Day and Smoker Status')
fig.show()

# Histogram
fig = px.histogram(df, x="total_bill", nbins=20, marginal="rug")
fig.update_layout(title='Distribution of Bill Amounts')
fig.show()

# Heatmap
df = px.data.medals_long()
fig = px.density_heatmap(df, x="medal", y="nation", z="count",
                        color_continuous_scale="Viridis")
fig.update_layout(title='Medal Counts by Nation')
fig.show()

# 3D Scatter
df = px.data.iris()
fig = px.scatter_3d(df, x='sepal_length', y='sepal_width', z='petal_width',
                    color='species')
fig.update_layout(title='3D Scatter Plot of Iris Dataset')
fig.show()

# Maps
df = px.data.gapminder().query("year==2007")
fig = px.choropleth(df, locations="iso_alpha", color="lifeExp",
                    hover_name="country", range_color=[20, 80],
                    projection="natural earth")
fig.update_layout(title='Life Expectancy by Country (2007)')
fig.show()

# Using graph_objects for more customization
fig = go.Figure()
x = np.linspace(0, 10, 100)
fig.add_trace(go.Scatter(x=x, y=np.sin(x), mode='lines', name='sin(x)'))
fig.add_trace(go.Scatter(x=x, y=np.cos(x), mode='lines', name='cos(x)'))
fig.update_layout(title='Sine and Cosine Functions',
                  xaxis_title='x',
                  yaxis_title='y')
fig.show()
```