#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Page 89, 7-1
#Using data from the NSFG, make a scatter plot of birth weight versus mother’s age. Plot percentiles of birth weight versus mother’s age. Compute Pearson’s and Spearman’s correlations. 
#How would you characterize the relationship between these variables?


# In[2]:


from __future__ import print_function, division
import sys
import numpy as np
import thinkstats2


# In[3]:


from collections import defaultdict
from __future__ import print_function, division
get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np
import brfss
import thinkstats2
import thinkplot
import pandas as pd


# In[4]:


import first

live, firsts, others = first.MakeFrames()
live = live.dropna(subset=['agepreg', 'totalwgt_lb'])


# In[5]:


#defining correlation function
def Corr(xs, ys):
    xs = np.asarray(xs)
    ys = np.asarray(ys)

    meanx, varx = thinkstats2.MeanVar(xs)
    meany, vary = thinkstats2.MeanVar(ys)

    corr = Cov(xs, ys, meanx, meany) / np.sqrt(varx * vary)
    return corr


# In[6]:


# defining covariance of two variables
def Cov(xs, ys, meanx=None, meany=None):
    xs = np.asarray(xs)
    ys = np.asarray(ys)

    if meanx is None:
        meanx = np.mean(xs)
    if meany is None:
        meany = np.mean(ys)

    cov = np.dot(xs-meanx, ys-meany) / len(xs)
    return cov


# In[7]:


# defining spearman's correlation
def SpearmanCorr(xs, ys):
    xranks = pd.Series(xs).rank()
    yranks = pd.Series(ys).rank()
    return Corr(xranks, yranks)


# In[8]:


ages = live.agepreg
weights = live.totalwgt_lb
print('Corr', Corr(ages, weights))
print('SpearmanCorr', SpearmanCorr(ages, weights))


# In[9]:


# Defining function binned Percentiles

def BinnedPercentiles(df):
    bins = np.arange(10, 48, 3)
    indices = np.digitize(df.agepreg, bins)
    groups = df.groupby(indices)

    ages = [group.agepreg.mean() for i, group in groups][1:-1]
    cdfs = [thinkstats2.Cdf(group.totalwgt_lb) for i, group in groups][1:-1]

    thinkplot.PrePlot(3)
    for percent in [75, 50, 25]:
        weights = [cdf.Percentile(percent) for cdf in cdfs]
        label = '%dth' % percent
        thinkplot.Plot(ages, weights, label=label)

    thinkplot.Config(xlabel="Mother's age (years)",
                     ylabel='Birth weight (lbs)',
                     xlim=[14, 45], legend=True)
    
BinnedPercentiles(live)


# In[10]:


# defining function for scatterplot

def ScatterPlot(ages, weights, alpha=1.0, s=20):
    thinkplot.Scatter(ages, weights, alpha=alpha)
    thinkplot.Config(xlabel='Age (years)',
                     ylabel='Birth weight (lbs)',
                     xlim=[10, 50],
                     ylim=[0, 20],
                     legend=True)
    
ScatterPlot(ages, weights, alpha=0.05, s=10)


# In[11]:


#Page 99: 8-1
#In this chapter we used 𝑥¯x¯ and median to estimate µ, and found that 𝑥¯x¯ yields 
#lower MSE. Also, we used 𝑆2S2 and 𝑆2𝑛−1Sn−12 to estimate σ, and found that 𝑆2S2 is 
#biased and 𝑆2𝑛−1Sn−12 unbiased. Run similar experiments to see if 𝑥¯x¯ and median 
#are biased estimates of µ. Also check whether 𝑆2S2 or 𝑆2𝑛−1Sn−12 yields a lower MSE.


# In[15]:


# defining root mean squared error function
def RMSE(estimates, actual):

    e2 = [(estimate-actual)**2 for estimate in estimates]
    mse = np.mean(e2)
    return np.sqrt(mse)




# In[16]:


# Importing random function for sample population

import random

def Estimate1(n=7, iters=1000):
  
    mu = 0
    sigma = 1

    means = []
    medians = []
    for _ in range(iters):
        xs = [random.gauss(mu, sigma) for _ in range(n)]
        xbar = np.mean(xs)
        median = np.median(xs)
        means.append(xbar)
        medians.append(median)

    print('Experiment 1')
    print('rmse xbar', RMSE(means, mu))
    print('rmse median', RMSE(medians, mu))
    Experiment 1
rmse xbar 0.3801530406846367
rmse median 0.45897967041977156
Estimate1()


# In[19]:


# defining function meanerror

def MeanError(estimates, actual):

    errors = [estimate-actual for estimate in estimates]
    return np.mean(errors)


# In[20]:


# define function for biased and unbiased population sample

def Estimate5(n=7, iters=100000):
 
    mu = 0
    sigma = 1

    estimates1 = []
    estimates2 = []
    for _ in range(iters):
        xs = [random.gauss(mu, sigma) for i in range(n)]
        biased = np.var(xs)
        unbiased = np.var(xs, ddof=1)
        estimates1.append(biased)
        estimates2.append(unbiased)

    print('Experiment 2')
    print('RMSE biased', RMSE(estimates1, sigma**2))
    print('RMSE unbiased', RMSE(estimates2, sigma**2))

Estimate5()


# In[21]:


#Page 99: 8-2
#Suppose you draw a sample with size n=10 from an exponential distribution with λ=2. 
#Simulate this experiment 1000 times and plot the sampling distribution of the estimate L. 
#Compute the standard error of the estimate and the 90% confidence interval.
#Repeat the experiment with a few different values of n and make a plot of standard error versus n.


# In[22]:


def SimulateSample(lam=2, n=10, iters=1000):

    def VertLine(x, y=1):
        thinkplot.Plot([x, x], [0, y], color='0.8', linewidth=3)

    estimates = []
    for _ in range(iters):
        xs = np.random.exponential(1.0/lam, n)
        lamhat = 1.0 / np.mean(xs)
        estimates.append(lamhat)

    stderr = RMSE(estimates, lam)
    print('standard error', stderr)

    cdf = thinkstats2.Cdf(estimates)
    ci = cdf.Percentile(5), cdf.Percentile(95)
    print('confidence interval', ci)
    VertLine(ci[0])
    VertLine(ci[1])

    # plot the CDF
    thinkplot.Cdf(cdf)
    thinkplot.Config(xlabel='estimate',
                     ylabel='CDF',
                     title='Sampling distribution')

    return stderr

SimulateSample()


# In[ ]:




