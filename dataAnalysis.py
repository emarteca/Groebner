import matplotlib.pylab as plt
import numpy as np


maple = [ 0.423, 0.200, 0.243, 0.120, 0.016, 0.079]
cra = [ 0.588, 0.344, 0.656, 6.357, 7.584, 6.424]
hensel = [ 18.969, 2340.013, 0, 1.944, 1.212, 1.924]

N = len(maple)
ind = np.arange(N)  # the x locations for the groups
width = 0.2       # the width of the bars

fig = plt.figure()
ax = fig.add_subplot( 111)

rects1 = ax.bar(ind, maple, width, color='b', log=True, label='Maple')
rects2 = ax.bar(ind+width, cra, width, color='r', log=True, label='CRA')
rects3 = ax.bar(ind+2*width, hensel, width, color='y', log=True, label='Hensel')

ax.set_ylabel('Time (log scaled, seconds)', fontsize=13)
ax.set_xticks(ind+width)
ax.set_xticklabels( ('arnborgI', 'arnborgIII', 'forsman4', 'hell-in', 'kiyoshi5', 'p34'), ha='right', rotation=50)
ax.set_ylim([ 10**(-2), 5*10**3])


lines, labels = ax.get_legend_handles_labels()
ax.legend(lines, labels, fontsize=10, loc=2)

plt.gcf().subplots_adjust(bottom=0.15)

rect = plt.figure(1).patch
rect.set_facecolor('white')
plt.show()
