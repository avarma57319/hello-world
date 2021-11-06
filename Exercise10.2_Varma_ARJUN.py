#!/usr/bin/env python
# coding: utf-8

# In[1]:


## Importing required packages

from __future__ import print_function, division

get_ipython().run_line_magic('matplotlib', 'inline')

import warnings
warnings.filterwarnings('ignore', category=FutureWarning)

import numpy as np
import pandas as pd

import random

import thinkstats2
import thinkplot


# In[2]:


# creating a function for liner model for prices

def RunQuadraticModel(daily):
 
    daily['years2'] = daily.years**2
    model = smf.ols('ppg ~ years + years2', data=daily)
    results = model.fit()
    return model, results


# In[4]:


# declaring variable dallies - defining function

def GroupByQualityAndDay(transactions):

    groups = transactions.groupby('quality')
    dailies = {}
    for name, group in groups:
        dailies[name] = GroupByDay(group)        

    return dailies


# In[7]:


# Loading mj-clean.csv file
transactions = pd.read_csv('C:''mj-clean.csv', parse_dates=[5])


# In[8]:


# checking loaded file

transactions.head()


# In[17]:


# defining GroupByDay function to calculate AVERAGE Daily price
def GroupByQualityAndDay(transactions):
    groups = transactions.groupby('quality')
    dailies = {}
    for name, group in groups:
        dailies[name] = GroupByDay(group)        

    return dailies


# In[16]:


# Defining groupByDay function for daily averages

def GroupByDay(transactions, func=np.mean):
    grouped = transactions[['date', 'ppg']].groupby('date')
    daily = grouped.aggregate(func)

    daily['date'] = daily.index
    start = daily.date[0]
    one_year = np.timedelta64(1, 'Y')
    daily['years'] = (daily.date - start) / one_year

    return daily


# In[18]:


dailies = GroupByQualityAndDay(transactions)


# In[20]:


# importing formulas as 'smf'

import statsmodels.formula.api as smf

def RunLinearModel(daily):
    model = smf.ols('ppg ~ years', data=daily)
    results = model.fit()
    return model, results   


# In[21]:


name = 'high'
daily = dailies[name]

model, results = RunQuadraticModel(daily)
results.summary()    


# In[23]:


# defining function for fitted model values

def PlotFittedValues(model, results, label=''):
    """Plots original data and fitted values.

    model: StatsModel model object
    results: StatsModel results object
    """
    years = model.exog[:,1]
    values = model.endog
    thinkplot.Scatter(years, values, s=15, label=label)
    thinkplot.Plot(years, results.fittedvalues, label='model', color='#ff7f00')


# In[24]:



PlotFittedValues(model, results, label=name)
thinkplot.Config(title='Fitted values',
                 xlabel='Years',
                 xlim=[-0.1, 3.8],
                 ylabel='price per gram ($)')


# In[26]:


# defining function plotpredictions

def PlotPredictions(daily, years, iters=101, percent=90, func=RunLinearModel):
    result_seq = SimulateResults(daily, iters=iters, func=func)
    p = (100 - percent) / 2
    percents = p, 100-p

    predict_seq = GeneratePredictions(result_seq, years, add_resid=True)
    low, high = thinkstats2.PercentileRows(predict_seq, percents)
    thinkplot.FillBetween(years, low, high, alpha=0.3, color='gray')

    predict_seq = GeneratePredictions(result_seq, years, add_resid=False)
    low, high = thinkstats2.PercentileRows(predict_seq, percents)
    thinkplot.FillBetween(years, low, high, alpha=0.5, color='gray')


# In[28]:


# Defining function

def SimulateResults(daily, iters=101, func=RunLinearModel):
 
    _, results = func(daily)
    fake = daily.copy()
    
    result_seq = []
    for _ in range(iters):
        fake.ppg = results.fittedvalues + thinkstats2.Resample(results.resid)
        _, fake_results = func(fake)
        result_seq.append(fake_results)

    return result_seq


# In[30]:


# defining function to return a sequence of predictions

def GeneratePredictions(result_seq, years, add_resid=False):

    n = len(years)
    d = dict(Intercept=np.ones(n), years=years, years2=years**2)
    predict_df = pd.DataFrame(d)
    
    predict_seq = []
    for fake_results in result_seq:
        predict = fake_results.predict(predict_df)
        if add_resid:
            predict += thinkstats2.Resample(fake_results.resid, n)
        predict_seq.append(predict)

    return predict_seq


# In[31]:




years = np.linspace(0, 5, 101)
thinkplot.Scatter(daily.years, daily.ppg, alpha=0.1, label=name)
PlotPredictions(daily, years, func=RunQuadraticModel)
thinkplot.Config(title='predictions',
                 xlabel='Years',
                 xlim=[years[0]-0.1, years[-1]+0.1],
                 ylabel='Price per gram ($)')


# In[33]:


# Exercise: Write a definition for a class named SerialCorrelationTest that extends HypothesisTest 
#from Section 9.2. 
#It should take a series and a lag as data, compute the serial correlation of the series with the 
#given lag, and then compute the p-value of the observed correlation.
#Use this class to test whether the serial correlation in raw price data is statistically significant. 
#Also test the residuals of the linear model and (if you did the previous exercise), the quadratic model.


# In[47]:


# testing different permutions of correlation


class SerialCorrelationTest(thinkstats2.HypothesisTest):
    

    def TestStatistic(self, data):
        
        series, lag = data
        test_stat = abs(SerialCorr(series, lag))
        return test_stat

    def RunModel(self):
        
        series, lag = self.data
        permutation = series.reindex(np.random.permutation(series.index))
        return permutation, lag


# In[48]:


# defining function to calculate serial correlation with lag

def SerialCorr(series, lag=1):
    xs = series[lag:]
    ys = series.shift(lag)[lag:]
    corr = thinkstats2.Corr(xs, ys)
    return corr


# In[49]:


# test for serial correlation in residuals of the linear model

_, results = RunLinearModel(daily)
series = results.resid
test = SerialCorrelationTest((series, 1))
pvalue = test.PValue()
print(test.actual, pvalue)


# In[50]:


# test for serial correlation in residuals of the quadratic model

_, results = RunQuadraticModel(daily)
series = results.resid
test = SerialCorrelationTest((series, 1))
pvalue = test.PValue()
print(test.actual, pvalue)


# In[51]:





# In[61]:





# In[62]:





# In[58]:





# In[ ]:




