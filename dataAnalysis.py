import matplotlib.pylab as plt
import numpy as np


# buchberger
maple_bb = [ 0.423, 14.812, 0.200, 1.408, 0.084, 0.015, 0.108, 0.243, 38.533, 0.120, 0.016, 0.283, 5.800, 34.236, 0.035, 0.079, 0.456, 0.028, 2665.155, 14.949]
cra_bb = [ 0.588, 34.044, 0.344, 4.768, 0.164, 0.024, 0.140, 0.656, 164.207, 6.357, 7.584, 0.444, 39.344, 261.088, 0.929, 6.424, 84.640, 0.040, 6.451, 33.784]
hensel_bb = [ 18.969, 0, 2340.013, 0, 0.891, 0, 0, 0, 0, 1.944, 1.212, 10.684, 0, 0, 1.176, 1.924, 89.820, 0.100, 0, 0]

# maplef4
maple_f4 = [ 0.312, 0.144, 0.099, 0.116, 0.024, 0.132]
cra_f4 = [ 0.491, 0.329, 0.453, 7.112, 7.944, 7.093]

N = len(maple_bb)
ind = np.arange(N)  # the x locations for the groups
width = 0.2       # the width of the bars

fig = plt.figure()
ax = fig.add_subplot( 111)

rects1 = ax.bar(ind, maple_bb, width, color='b', log=True, label='Maple')
rects2 = ax.bar(ind+width, cra_bb, width, color='r', log=True, label='CRA')
#rects3 = ax.bar(ind+2*width, hensel_bb, width, color='y', log=True, label='Hensel')

#rects1 = ax.bar(ind, maple_bb, width, color='b', log=True, label='BB')
#rects2 = ax.bar(ind+width, maple_f4, width, color='r', log=True, label='F4')

ax.set_ylabel('Time (log scaled, seconds)', fontsize=13)
ax.set_xticks(ind+width)
ax.set_xticklabels( ('arnborgI', 'arnborgII', 'arnborgIII', 'arnborgV', 'forsman1', 'forsman2', 'forsman3', 'forsman4', 'katsura7', 'hell-in', 'kiyoshi5', 'caprasse', 'mike2', 'p27', 'p33', 'p34', 'p41', 'trav1', 'cassou_POSSO', 'cyclic6'), ha='right', rotation=50)
ax.set_ylim([ 10**(-2), 3*10**3])


lines, labels = ax.get_legend_handles_labels()
ax.legend(lines, labels, fontsize=10, loc=2)

plt.gcf().subplots_adjust(bottom=0.15)

rect = plt.figure(1).patch
rect.set_facecolor('white')
plt.show()
