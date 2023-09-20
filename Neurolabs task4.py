#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pandas as pd


# In[15]:


import plotly.express as px
import plotly.graph_objects as go


# In[17]:


file_path1="C:/Users/God/Downloads/raw_data.csv"
data2=pd.read_csv(file_path1)


# In[18]:


print(data2)


# In[13]:


file_path = "C:/Users/God/Downloads/transformed_data.csv"
data = pd.read_csv(file_path)



# In[14]:


print(data)


# In[19]:


print(data.head())


# In[20]:


print(data2.head())


# In[21]:


data["COUNTRY"].value_counts()


# In[22]:


#294 is the mode value. 
#We will need to use it for dividing the sum of all the samples related to the human development index, GDP per capita, and the population.
data["COUNTRY"].value_counts().mode()


# In[23]:


#create a new dataset by combining the necessary columns from both the datasets: 
code = data["CODE"].unique().tolist()
country = data["COUNTRY"].unique().tolist()
hdi = []
tc = []
td = []
sti = []
population = data["POP"].unique().tolist()
gdp = []

for i in country:
    hdi.append((data.loc[data["COUNTRY"] == i, "HDI"]).sum()/294)
    tc.append((data2.loc[data2["location"] == i, "total_cases"]).sum())
    td.append((data2.loc[data2["location"] == i, "total_deaths"]).sum())
    sti.append((data.loc[data["COUNTRY"] == i, "STI"]).sum()/294)
    population.append((data2.loc[data2["location"] == i, "population"]).sum()/294)

aggregated_data = pd.DataFrame(list(zip(code, country, hdi, tc, td, sti, population)), 
                               columns = ["Country Code", "Country", "HDI", 
                                          "Total Cases", "Total Deaths", 
                                          "Stringency Index", "Population"])
print(aggregated_data.head())


# In[24]:


# Sorting Data According to Total Cases

data = aggregated_data.sort_values(by=["Total Cases"], ascending=False)
print(data.head())


# In[25]:


# Top 10 Countries with Highest Covid Cases to study the economic analysis

data = data.head(10)
print(data)


# In[26]:


data["GDP Before Covid"] = [65279.53, 8897.49, 2100.75, 
                            11497.65, 7027.61, 9946.03, 
                            29564.74, 6001.40, 6424.98, 42354.41]
data["GDP During Covid"] = [63543.58, 6796.84, 1900.71, 
                            10126.72, 6126.87, 8346.70, 
                            27057.16, 5090.72, 5332.77, 40284.64]
print(data)


# In[40]:


#Analyzing the spread Covid 19 
figure = px.bar(data, y='Total Cases', x='Country',
            title="Countries with Highest Covid Cases")
figure.show()
#USA has the highest number of COVID-19 cases and UK has minimum cases in top 10 countries of COVID Cases


# In[42]:


figure = px.bar(data, y='Total Deaths', x='Country',
            title="Countries with Highest Deaths")
figure.show()
#USA has registered highest death rates followed by Brazil and India. 


# In[31]:


#comparing the total number of cases and total deaths in all these countries:
fig = go.Figure()
fig.add_trace(go.Bar(
    x=data["Country"],
    y=data["Total Cases"],
    name='Total Cases',
    marker_color='indianred'
))
fig.add_trace(go.Bar(
    x=data["Country"],
    y=data["Total Deaths"],
    name='Total Deaths',
    marker_color='lightsalmon'
))
fig.update_layout(barmode='group', xaxis_tickangle=-45)
fig.show()


# In[32]:


#the percentage of total deaths and total cases among all the countries with the highest number of covid-19 cases:
cases = data["Total Cases"].sum()
deceased = data["Total Deaths"].sum()

labels = ["Total Cases", "Total Deaths"]
values = [cases, deceased]

fig = px.pie(data, values=values, names=labels, 
             title='Percentage of Total Cases and Deaths', hole=0.5)
fig.show()


# In[33]:


#calculate the death rate of Covid-19 cases:
death_rate = (data["Total Deaths"].sum() / data["Total Cases"].sum()) * 100
print("Death Rate = ", death_rate)


# In[34]:


#Stringency index :It is a composite measure of response indicators, including school closures, workplace closures, and travel bans.
#how strictly countries are following these measures to control the spread of covid-19:
fig = px.bar(data, x='Country', y='Total Cases',
             hover_data=['Population', 'Total Deaths'], 
             color='Stringency Index', height=400, 
             title= "Stringency Index during Covid-19")
fig.show()
#We can see here USA, Brazil and India has applied high stringent policies to curb the spread of COVID19.


# In[35]:


#Analyzing Covid-19 Impacts on Economy
fig = px.bar(data, x='Country', y='Total Cases',
             hover_data=['Population', 'Total Deaths'], 
             color='GDP Before Covid', height=400, 
             title="GDP Per Capita Before Covid-19")
fig.show()


# In[36]:


#GDP per capita during the rise in the cases of covid-19:
fig = px.bar(data, x='Country', y='Total Cases',
             hover_data=['Population', 'Total Deaths'], 
             color='GDP During Covid', height=400, 
             title="GDP Per Capita During Covid-19")
fig.show()


# In[37]:


#comparing the GDP per capita before covid-19 and during covid-19 to have a look at the impact of covid-19 on the GDP per capita:

fig = go.Figure()
fig.add_trace(go.Bar(
    x=data["Country"],
    y=data["GDP Before Covid"],
    name='GDP Per Capita Before Covid-19',
    marker_color='indianred'
))
fig.add_trace(go.Bar(
    x=data["Country"],
    y=data["GDP During Covid"],
    name='GDP Per Capita During Covid-19',
    marker_color='lightsalmon'
))
fig.update_layout(barmode='group', xaxis_tickangle=-45)
fig.show()
#in this graph it is clear that there was a drop in GDP per capita in all top 10 COVID countries during COVID period as compared to before COVID period.


# In[39]:


#how many countries were spending their budget on the human development:
fig = px.bar(data, x='Country', y='Total Cases',
             hover_data=['Population', 'Total Deaths'], 
             color='HDI', height=400, 
             title="Human Development Index during Covid-19")
fig.show()


# In[ ]:




